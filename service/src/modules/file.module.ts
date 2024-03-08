import { FileService } from '@/services/file.service';
import { Module } from '@nestjs/common';
import { FileController } from '@/controllers/file.controller';
import { MulterModule } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 as uuidv4 } from 'uuid';
import { ConfigModule, ConfigService } from '@nestjs/config';

@Module({
  imports: [
    MulterModule.registerAsync({
      imports: [ConfigModule],
      useFactory(configService: ConfigService) {
        return {
          storage: diskStorage({
            //文件储存位置
            destination: configService.get<string>('files.destination'),
            //文件名定制
            filename: (req, file, callback) => {
              const path = uuidv4() + extname(file.originalname);
              callback(null, path);
            },
          }),
        };
      },
      inject: [ConfigService],
    }),
  ],
  controllers: [FileController],
  providers: [FileService],
  exports: [FileService],
})
export class FileModule {}
