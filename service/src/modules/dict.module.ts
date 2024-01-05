import { Dict } from '@/entities/dict.entity';
import { DictService } from '@/services/dict.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MenuModule } from './menu.module';
import { DictController } from '@/controllers/dict.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Dict]), MenuModule],
  controllers: [DictController],
  providers: [DictService],
  exports: [DictService],
})
export class DictModule {}
