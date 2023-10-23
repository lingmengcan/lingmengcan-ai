import { Menu } from '@/entities/menu.entity';
import { MenuService } from '@/services/menu.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Menu])],
  providers: [MenuService],
  exports: [MenuService],
})
export class MenuModule {}
