import { Conversation } from '@/entities/conversation.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class ConversationService {
  constructor(
    @InjectRepository(Conversation)
    private repository: Repository<Conversation>,
    private dataSource: DataSource,
  ) {}

  findByConversationId(conversationId: string): Promise<Conversation> {
    return this.repository.findOne({
      where: { conversationId: conversationId, status: 0 },
    });
  }

  /**
   * 新增
   *
   * @param menu 信息
   * @return 结果
   */
  async addConversation(conversation: Conversation) {
    const conversationId = uuidv4();

    const entity = new Conversation();
    entity.conversationId = conversationId;
    entity.conversationName = conversation.conversationName;
    entity.userName = conversation.userName;
    entity.status = conversation.status;
    entity.createdAt = new Date();
    entity.updatedAt = new Date();
    return this.repository.save(entity);
  }
}
