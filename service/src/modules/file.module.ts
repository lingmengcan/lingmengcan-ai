import { FileService } from '@/services/file.service';
import { Module } from '@nestjs/common';
import { FileController } from '@/controllers/file.controller';
import { MulterModule } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname, join } from 'path';
import { v4 as uuidv4 } from 'uuid';
import { ConfigModule, ConfigService } from '@nestjs/config';
import dayjs from 'dayjs';
import { File } from '@/entities/file.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ServeStaticModule } from '@nestjs/serve-static';

@Module({
  imports: [
    TypeOrmModule.forFeature([File]),
    MulterModule.registerAsync({
      imports: [ConfigModule],
      useFactory(configService: ConfigService) {
        return {
          storage: diskStorage({
            //文件储存位置
            destination:
              configService.get<string>('files.destination') + '/' + dayjs().format('YYYY-MM-DD'),
            //文件名定制
            filename: (req, file, callback) => {
              const path = uuidv4() + extname(file.originalname);
              callback(null, path);
            },
          }),
          // 文件名编码设置为 UTF-8
          fileFilter: (req, file, callback) => {
            file.originalname = Buffer.from(file.originalname, 'latin1').toString('utf8');
            callback(null, true);
          },
        };
      },
      inject: [ConfigService],
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '../..', 'upload-files'),
      // Tell NestJS to serve the files under ~/upload-files/
      serveRoot: '/upload-files/',
    }),
  ],
  controllers: [FileController],
  providers: [FileService],
  exports: [FileService],
})
export class FileModule {}
