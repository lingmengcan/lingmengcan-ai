import { MenuController } from '@/controllers/menu.controller';
import { Menu } from '@/entities/menu.entity';
import { MenuService } from '@/services/menu.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Menu])],
  controllers: [MenuController],
  providers: [MenuService],
  exports: [MenuService],
})
export class MenuModule {}
