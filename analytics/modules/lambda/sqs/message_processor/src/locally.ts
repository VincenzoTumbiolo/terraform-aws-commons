import { Context, SQSEvent, SQSRecord } from 'aws-lambda';
import * as AWS from 'aws-sdk';
import { handler } from './index';

try {
  var config: AWS.SQS.ClientConfiguration = {
    endpoint: new AWS.Endpoint('http://localhost:9324'),
    accessKeyId: 'na',
    secretAccessKey: 'na',
    region: 'REGION'
  };

  var sqs = new AWS.SQS(config);
} catch (error) {
  console.error(error);
  process.exit(1);
}

async function pollMessages(sqs: AWS.SQS) {
  while (true) {
    try {
      const listQueuesRequest = await sqs.listQueues().promise();
      let queueUrl: string;
      if (!listQueuesRequest.QueueUrls?.length) {
        const createQueueRequest = await sqs.createQueue({ QueueName: 'test' }).promise();
        queueUrl = createQueueRequest.QueueUrl!;
      } else {
        const queueUrlRequest = await sqs.getQueueUrl({ QueueName: 'test' }).promise();
        queueUrl = queueUrlRequest.QueueUrl!;
      }

      await sqs
        .receiveMessage(
          {
            QueueUrl: queueUrl,
            WaitTimeSeconds: 1
          },
          async (err, data) => {
            if (err) {
              console.error(err);
              return;
            }

            if (!data.Messages?.length) {
              return;
            }

            const records = data.Messages.map((it) => ({ body: it.Body } as SQSRecord));
            const event = { Records: records } as SQSEvent;

            await handler(event, undefined as unknown as Context);
          }
        )
        .promise();
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  }
}

pollMessages(sqs);
