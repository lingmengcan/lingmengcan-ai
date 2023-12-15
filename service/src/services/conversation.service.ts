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

  /**
   * 获取实体
   * @param id
   * @returns
   */
  findOne(id: string): Promise<Conversation> {
    return this.repository.findOneBy({ conversationId: id });
  }

  findByConversationId(conversationId: string): Promise<Conversation> {
    return this.repository.findOne({
      where: { conversationId, status: 0 },
    });
  }

  /**
   * 对话列表
   *
   * @returns
   */
  async findList() {
    return this.repository.find({
      where: { status: 0 },
      order: { createdAt: 'DESC' },
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

  /**
   * 修改对话
   *
   * @param conversation 对话信息
   * @return 结果
   */
  async updateConversation(conversation: Conversation) {
    const entity = await this.findOne(conversation.conversationId);
    entity.conversationName = conversation.conversationName;
    entity.status = conversation.status;
    entity.updatedAt = new Date();
    return this.repository.save(entity);
  }

  /**
   * 修改对话状态
   *
   * @param conversation 对话信息
   * @return 结果
   */
  async updateStatus(conversation: Conversation) {
    const entity = await this.findOne(conversation.conversationId);
    entity.status = conversation.status;
    entity.updatedAt = new Date();
    return this.repository.save(entity);
  }
}
