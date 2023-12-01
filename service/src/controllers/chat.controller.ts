import { ChatGlmDto } from '@/dtos/chat.dto';
import { ChatService } from '@/services/chat.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBody, ApiTags } from '@nestjs/swagger';

@ApiTags('chat') // 添加 接口标签 装饰器
@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

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
}
