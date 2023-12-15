import { ChatController } from '@/controllers/chat.controller';
import { ChatService } from '@/services/chat.service';
import { Module } from '@nestjs/common';
import { ConversationModule } from './conversation.module';
import { MessageModule } from './message.module';

@Module({
  imports: [ConversationModule, MessageModule],
  controllers: [ChatController],
  providers: [ChatService],
  exports: [ChatService],
})
export class ChatModule {}
