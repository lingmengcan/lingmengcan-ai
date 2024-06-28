import { Llm } from '@/entities/llm.entity';
import { LlmService } from '@/services/llm.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ModelController } from '@/controllers/model.controller';
import { DiffusionModelService } from '@/services/diffusion-model.service';
import { DiffusionModel } from '@/entities/diffusion-model.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Llm]), TypeOrmModule.forFeature([DiffusionModel])],
  controllers: [ModelController],
  providers: [LlmService, DiffusionModelService],
  exports: [LlmService, DiffusionModelService],
})
export class ModelModule {}
