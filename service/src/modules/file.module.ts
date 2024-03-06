import { FileService } from '@/services/file.service';
import { Module } from '@nestjs/common';
import { FileController } from '@/controllers/file.controller';

@Module({
  controllers: [FileController],
  providers: [FileService],
  exports: [FileService],
})
export class FileModule {}
