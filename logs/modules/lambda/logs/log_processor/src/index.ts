import { CloudWatchLogsEvent, CloudWatchLogsLogEvent, Context } from 'aws-lambda';
import * as jf from 'joiful';
var zlib = require('zlib');
import mysql from 'mysql2';
import { LogDto } from './dto/log.dto';

const DB_HOST = process.env.DB_HOST!;
const DB_NAME = process.env.DB_NAME!;
const DB_USERNAME = process.env.DB_USERNAME!;
const DB_PASSWORD = process.env.DB_PASSWORD!;
const DB_PORT = process.env.DB_PORT! as unknown as number;

const pool = mysql.createPool({
  connectionLimit: 1,
  host: DB_HOST,
  user: DB_USERNAME,
  password: DB_PASSWORD,
  database: DB_NAME,
  port: DB_PORT
});

const dbQuery = async (query: string, fields: any[]) => {
  return new Promise((resolve, reject) => {
    pool.query(mysql.format(query, fields), function (error: any, results: unknown) {
      if (error) {
        console.log('[dbQuery] error: ', error);
        reject(error);
      }
      resolve(results);
    });
  });
};

exports.dbQuery = dbQuery;

const checkCreateTable = async () => {
  try {
    return await dbQuery(
      `
    CREATE TABLE IF NOT EXISTS Logs (
      uuid VARCHAR(191) NOT NULL,
      ipAddress VARCHAR(191) DEFAULT NULL,
      level VARCHAR(191) DEFAULT NULL,
      action VARCHAR(191) DEFAULT NULL,
      _system VARCHAR(191) DEFAULT NULL,
      description TEXT DEFAULT NULL,
      createdAt VARCHAR(191) NOT NULL,
  
      PRIMARY KEY (uuid)
    ) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    `,
      []
    );
  } catch (error) {
    console.log('[checkCreateTable] error: ', error);
    throw error;
  }
};

const postInsertLog = async (log: LogDto) => {
  try {
    return await dbQuery(`INSERT INTO Logs VALUES (?, ?, ?, ?, ?, ?, ?);`, [
      log.uuid,
      log.ipAddress,
      log.level,
      log.action,
      log.system,
      JSON.stringify(log.description),
      log.createdAt
    ]);
  } catch (error) {
    console.log('[postInsertToken] error: ', error);
    throw error;
  }
};

export const handler = async (event: CloudWatchLogsEvent, _context: Context): Promise<void> => {
  try {
    console.log('EVENT: ', event);
    // await checkCreateTable();
    if (event.awslogs && event.awslogs.data) {
      const payload = Buffer.from(event.awslogs.data, 'base64');
      const logevents: CloudWatchLogsLogEvent[] = JSON.parse(zlib.unzipSync(payload).toString()).logEvents;

      for (const logevent of logevents) {
        const record: LogDto = JSON.parse(logevent.message);
        const result = jf.validateAsClass(record, LogDto);
        if (result.error) {
          throw result.error;
        }
        if (record.error) {
          record.description.error = record.error;
        }
        await postInsertLog(record);
      }
    }
    return undefined;
  } catch (error) {
    console.warn('Unknown error');
    console.error(error);
  }
};
