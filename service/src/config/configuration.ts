// Custom configuration files

import { readFileSync } from 'fs';
import * as yaml from 'js-yaml';
import { join } from 'path';

export default () => {
  const env = process.env.NODE_ENV || 'development';
  const YAML_CONFIG_FILENAME = `../../config.${env}.yaml`;

  return yaml.load(
    readFileSync(join(__dirname, YAML_CONFIG_FILENAME), 'utf8'),
  ) as Record<string, any>;
};

// export default () => ({
//   port: process.env.PORT,

//   database: {
//     type: process.env.DATABASE_TYPE,
//     host: process.env.DATABASE_HOST,
//     port: process.env.DATABASE_PORT,
//     user: process.env.DATABASE_USER,
//     password: process.env.DATABASE_PASSWORD,
//     name: process.env.DATABASE_NAME,
//     synchronize: process.env.DATABASE_SYNCHRONIZE,
//   },
// });

// 环境配置
export class SystemConfig {
  prefix = '';
  port = 80;
}

// // 数据库配置
// export interface DatabaseConfig {
//   type: string;
//   host: string;
//   port: number;
//   user: string;
//   password: number;
//   name: string;
//   synchronize: boolean;
// }
