import { ChatController } from '@/controllers/chat.controller';
import { ChatService } from '@/services/chat.service';
import { Module } from '@nestjs/common';
import { DialogModule } from './dialog.module';

@Module({
  imports: [DialogModule],
  controllers: [ChatController],
  providers: [ChatService],
  exports: [ChatService],
})
export class ChatModule {}
