import { IsNotEmpty } from 'class-validator';
import { Column, Entity, OneToMany, PrimaryColumn } from 'typeorm';
import { Message } from './message.entity';

@Entity('dialog')
export class Dialog {
  @PrimaryColumn({ type: 'varchar', name: 'dialog_id', length: 36 })
  dialogId: string;

  @Column('varchar', { name: 'dialog_name', length: 255 })
  dialogName: string;

  @Column('varchar', { name: 'user_name', length: 32 })
  userName: string;

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

  @OneToMany(() => Message, (message) => message.dialog)
  dialogMessages: Message[];
}
