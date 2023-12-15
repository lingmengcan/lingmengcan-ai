import { Message } from '@/entities/message.entity';
import { MessageService } from '@/services/message.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Message])],
  providers: [MessageService],
  exports: [MessageService],
})
export class MessageModule {}
