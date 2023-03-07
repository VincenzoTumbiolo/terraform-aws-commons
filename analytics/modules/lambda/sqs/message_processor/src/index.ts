import { Context, SQSBatchResponse, SQSEvent } from 'aws-lambda';
import { AnalyticsDocument, AnalyticsDto } from './dto/analytics.dto';
import * as jf from 'joiful';
import * as dotenv from 'dotenv';
import { Collection, Db, MongoClient } from 'mongodb';

dotenv.config();
var dataCollection: Collection;
var errorsCollection: Collection;

const client: MongoClient = new MongoClient(process.env.DOCUMENT_DB_URI!);

const connectToMongo = async () => {
  try {
    await client.connect();
    const db: Db = client.db();
    dataCollection = db.collection('data');
    errorsCollection = db.collection('errors');
    console.log('connection started');
  } catch (error) {
    console.warn('Connection error! Aborting lambda.');
    console.error(error);

    process.exit(1);
  }
};

const closeConnectionMongo = async () => {
  try {
    await client.close();
    console.log('connection ended');
  } catch (error) {
    console.warn('Disconnection error! Aborting lambda.');
    console.error(error);

    process.exit(1);
  }
};

const checkIndexes = async (record: AnalyticsDto) => {
  const indexes = await dataCollection.indexes();
  if (!indexes.map((doc: any) => doc.name).includes('timestampIndex')) {
    await dataCollection.createIndex({ timestamp: -1 }, { name: 'timestampIndex' });

    const headersIndex: any = {};
    Object.keys(record.headers).forEach((header) => (headersIndex[`headers.${header}`] = 1));
    await dataCollection.createIndex({ ...headersIndex }, { name: 'headersIndex' });
  }
};

export const handler = async (event: SQSEvent, _context: Context): Promise<SQSBatchResponse | undefined> => {
  try {
    console.log('EVENT:  ', event);

    await connectToMongo();
    const response: SQSBatchResponse = {
      batchItemFailures: []
    };

    for await (const recordRaw of event.Records) {
      try {
        const record: AnalyticsDto = JSON.parse(recordRaw.body);
        const result = jf.validateAsClass(record, AnalyticsDto);
        if (result.error) {
          throw result.error;
        }

        const document: AnalyticsDocument = {
          ...record,
          createdAt: new Date()
        };
        await dataCollection.insertOne(document);
        await checkIndexes(record);
      } catch (error) {
        console.warn('Error consuming messsage!');
        console.error(error);

        response.batchItemFailures.push({ itemIdentifier: recordRaw.messageId });
        if (error instanceof jf.joi.ValidationError) {
          await errorsCollection.insertOne({
            name: error.name,
            message: error.message,
            stack: error.stack,
            details: error.details
          });
        } else {
          const genericError = error as Error;
          await errorsCollection.insertOne({
            name: genericError.name,
            message: genericError.message,
            stack: genericError.stack
          });
        }
        await closeConnectionMongo();
      }
    }
    await closeConnectionMongo();
    return response;
  } catch (error) {
    await closeConnectionMongo();
    console.warn('Unknown error');
    console.error(error);
  }
};
