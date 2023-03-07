import * as AWS from 'aws-sdk';
import { Collection, MongoClient } from 'mongodb';
import * as dotenv from 'dotenv';

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function connectToSQS() {
  var config = {
    endpoint: new AWS.Endpoint('http://localhost:9324'),
    accessKeyId: 'na',
    secretAccessKey: 'na',
    region: 'REGION',
  };

  return new AWS.SQS(config);
}

async function connectToMongo() {
  const connectionUri = `mongodb://${process.env.MONGO_INITDB_ROOT_USERNAME}:${process.env.MONGO_INITDB_ROOT_PASSWORD}@localhost:27017/${process.env.MONGO_INITDB_DATABASE}?authSource=admin`;
  const client: MongoClient = new MongoClient(connectionUri);
  await client.connect();

  return client.db();
}

describe('Analytics data flow system test', () => {
  let sqs: AWS.SQS;
  let dataCollection: Collection;

  beforeAll(async () => {
    dotenv.config({ path: './docker/.env' });

    sqs = await connectToSQS();
    dataCollection = (await connectToMongo()).collection('data');
  });

  it('Should send a record, consume it and persist it in the collection', async () => {
    const listQueuesRequest = await sqs.listQueues().promise();
    let queueUrl: string;
    if (!listQueuesRequest.QueueUrls?.length) {
      const createQueueRequest = await sqs
        .createQueue({ QueueName: 'test' })
        .promise();
      queueUrl = createQueueRequest.QueueUrl!;
    } else {
      const queueUrlRequest = await sqs
        .getQueueUrl({ QueueName: 'test' })
        .promise();
      queueUrl = queueUrlRequest.QueueUrl!;
    }

    await sqs
      .sendMessage({
        QueueUrl: queueUrl,
        MessageBody: JSON.stringify({
          headers: {
            regionCode: 'EMEA',
            countryCode: 'IT',
            brandCode: 'AMPLIFON',
            shopCode: 'SYSTEST',
            serialNumber: 'SYS-0000',
            type: 'TEST',
            version: 'v0',
            day: new Date().toISOString(),
          },
          timestamp: new Date().toISOString(),
          attributes: {
            test: 'yes',
          },
        }),
      })
      .promise();

    await delay(2000);

    const records = await dataCollection.find().toArray();
    expect(records.length).toBeGreaterThan(0);
  });
});
