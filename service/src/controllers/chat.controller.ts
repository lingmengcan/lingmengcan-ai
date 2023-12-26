import { ChatDto } from '@/dtos/chat.dto';
import { Conversation } from '@/entities/conversation.entity';
import { Message } from '@/entities/message.entity';
import { ChatService } from '@/services/chat.service';
import { ConversationService } from '@/services/conversation.service';
import { MessageService } from '@/services/message.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Get, Param, Post, UseGuards, Request } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBody, ApiTags } from '@nestjs/swagger';

@ApiTags('chat') // 添加 接口标签 装饰器
@Controller('chat')
export class ChatController {
  constructor(
    private readonly chatService: ChatService,
    private readonly conversationService: ConversationService,
    private readonly messageService: MessageService,
  ) {}

  /**
   * Glm对话
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('')
  @ApiBody({
    description: '对话',
    type: ChatDto,
  })
  async chat(@Body() dto: ChatDto) {
    return successJson(await this.chatService.chat(dto));
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('regenerate')
  @ApiBody({
    description: '重新回答',
    type: ChatDto,
  })
  async regenerate(@Body() dto: any) {
    return successJson(await this.chatService.regenerate(dto));
  }

  /**
   * 新增对话
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('/conversation/add')
  async add(@Body() conversation: Conversation, @Request() req: any) {
    const userName = req.user.userName;
    conversation.userName = userName;
    return successJson(await this.conversationService.addConversation(conversation));
  }

  /**
   * 编辑
   *
   * @param conversation
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('/conversation/edit')
  async edit(@Body() conversation: Conversation) {
    return successJson(await this.conversationService.updateConversation(conversation));
  }

  /**
   * 对话列表
   *
   * @param dto
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('list')
  async chatList(@Request() req: any) {
    const userName = req.user.userName;
    return successJson(await this.conversationService.findUserList(userName));
  }

  /**
   * 变更状态
   *
   * @param conversation
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('change-conversation-status')
  async changeStatus(@Body() conversation: Conversation) {
    return successJson(await this.conversationService.updateStatus(conversation));
  }

  /**
   * 清空用户对话列表
   *
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('clear-conversation-list')
  async clearConversationList(@Request() req: any) {
    const userName = req.user.userName;
    return successJson(await this.conversationService.clearConversationList(userName));
  }

  /**
   * 根据id获取详细信息
   *
   * @param conversationId
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Get('conversation/:conversationId')
  async findConversation(@Param('conversationId') conversationId: string) {
    const res = await this.conversationService.findByConversationId(conversationId);
    return successJson(res);
  }

  /**
   * 添加
   *
   * @param message
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('message/add')
  async addMessage(@Body() message: Message) {
    return successJson(await this.messageService.addMessage(message));
  }

  /**
   * 编辑
   *
   * @param message
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('message/edit')
  async editMessage(@Body() message: Message) {
    return successJson(await this.messageService.updateMessage(message));
  }

  /**
   * 变更消息状态
   *
   * @param conversation
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('change-message-status')
  async changeMessageStatus(@Body() message: Message) {
    return successJson(await this.messageService.updateStatus(message));
  }

  /**
   * 清空消息
   *
   * @param conversationId
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('clear-conversation-messages/:conversationId')
  async clearMessagesByConversationId(@Param('conversationId') conversationId: string) {
    const user = await this.messageService.clearMessagesByConversationId(conversationId);
    return successJson(user);
  }
}
