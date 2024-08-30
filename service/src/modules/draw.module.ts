import { DrawController } from '@/controllers/draw.controller';
import { DrawService } from '@/services/draw.service';
import { Module } from '@nestjs/common';
import { MediaModule } from './media.module';
import { ControlNetPreprocessorModule } from './control-net-preprocessor.module';

@Module({
  imports: [MediaModule, ControlNetPreprocessorModule],
  controllers: [DrawController],
  providers: [DrawService],
  exports: [DrawService],
})
export class DrawModule {}
