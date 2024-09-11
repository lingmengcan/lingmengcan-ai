import { ControlNetPreprocessor } from '@/entities/control-net-preprocessor.entity';
import { ControlNetPreprocessorService } from '@/services/control-net-preprocessor.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([ControlNetPreprocessor])],
  providers: [ControlNetPreprocessorService],
  exports: [ControlNetPreprocessorService],
})
export class ControlNetPreprocessorModule {}
