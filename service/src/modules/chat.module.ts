import { ChatController } from '@/controllers/chat.controller';
import { ChatService } from '@/services/chat.service';
import { Module } from '@nestjs/common';

@Module({
  controllers: [ChatController],
  providers: [ChatService],
  exports: [ChatService],
})
export class ChatModule {}
