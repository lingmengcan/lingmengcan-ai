import { AigcController } from '@/controllers/aigc.controller';
import { Media } from '@/entities/media.entity';
import { MediaService } from '@/services/media.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Media])],
  controllers: [AigcController],
  providers: [MediaService],
  exports: [MediaService],
})
export class MediaModule {}
