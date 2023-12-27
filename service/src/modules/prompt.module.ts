import { PromptController } from '@/controllers/prompt.controller';
import { Prompt } from '@/entities/prompt.entity';
import { PromptService } from '@/services/prompt.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Prompt])],
  controllers: [PromptController],
  providers: [PromptService],
  exports: [PromptService],
})
export class PromptModule {}
