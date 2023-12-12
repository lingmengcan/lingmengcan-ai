import { ChatGlmDto } from '@/dtos/chat.dto';
import { Conversation } from '@/entities/conversation.entity';
import { ChatService } from '@/services/chat.service';
import { ConversationService } from '@/services/conversation.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBody, ApiTags } from '@nestjs/swagger';

@ApiTags('chat') // 添加 接口标签 装饰器
@Controller('chat')
export class ChatController {
  constructor(
    private readonly chatService: ChatService,
    private readonly conversationService: ConversationService,
  ) {}

  /**
   * Glm对话
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('')
  @ApiBody({
    description: 'Glm对话',
    type: ChatGlmDto,
  })
  async chat(@Body() dto: any) {
    return successJson(await this.chatService.chat(dto));
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('chatfile')
  @ApiBody({
    description: 'Glm文档问答',
    type: ChatGlmDto,
  })
  async chatfile(@Body() dto: any) {
    return successJson(await this.chatService.chatfile(dto));
  }

  /**
   * 新增对话
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('/add-conversation')
  async add(@Body() conversation: Conversation) {
    return successJson(await this.conversationService.addConversation(conversation));
  }
}
