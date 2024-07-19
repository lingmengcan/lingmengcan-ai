import { DrawController } from '@/controllers/draw.controller';
import { Media } from '@/entities/media.entity';
import { MediaService } from '@/services/media.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Media])],
  controllers: [DrawController],
  providers: [MediaService],
  exports: [MediaService],
})
export class MediaModule {}
