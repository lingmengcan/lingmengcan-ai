import { IsNotEmpty } from 'class-validator';
import { Column, Entity, OneToMany, PrimaryColumn } from 'typeorm';
import { Message } from './message.entity';
import { File } from './file.entity';

@Entity('conversation')
export class Conversation {
  @PrimaryColumn({ type: 'varchar', name: 'conversation_id', length: 36 })
  conversationId: string;

  @Column('varchar', { name: 'conversation_name', length: 255 })
  conversationName: string;

  @Column('varchar', { name: 'user_name', length: 32 })
  userName: string;

  @Column('float', { name: 'temperature' })
  temperature: number;

  @Column('varchar', { name: 'llm', length: 128 })
  llm: string;

  @Column('tinyint', {
    name: 'status',
    comment: '-1 deleted, 0 normal，1 deactivated',
  })
  @IsNotEmpty()
  status: number;

  @Column('datetime', {
    name: 'created_at',
    default: () => 'CURRENT_TIMESTAMP',
  })
  createdAt: Date;

  @Column('datetime', {
    name: 'updated_at',
    default: () => 'CURRENT_TIMESTAMP',
  })
  updatedAt: Date;

  @OneToMany(() => Message, (message) => message.conversation)
  messages: Message[];

  @OneToMany(() => File, (file) => file.conversation)
  files: File[];
}
