import { Model } from '@/entities/model.entity';
import { ModelService } from '@/services/model.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MenuModule } from './menu.module';
import { ModelController } from '@/controllers/model.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Model]), MenuModule],
  controllers: [ModelController],
  providers: [ModelService],
  exports: [ModelService],
})
export class ModelModule {}
