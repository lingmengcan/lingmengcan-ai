import { Dialog } from '@/entities/dialog.entity';
import { DialogService } from '@/services/dialog.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Dialog])],
  providers: [DialogService],
  exports: [DialogService],
})
export class DialogModule {}
