import { Column, Entity, Index, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';
import { Dialog } from './dialog.entity';
import { IsNotEmpty } from 'class-validator';

@Index('message_dialog_id_foreign', ['dialogId'], {})
@Entity('message', { schema: 'lmc' })
export class Message {
  @PrimaryColumn({ type: 'varchar', name: 'message_id', length: 36 })
  messageId: string;

  @Column({ type: 'varchar', name: 'dialog_id', length: 36 })
  dialogId: string;

  @Column({ type: 'text', name: 'message_text' })
  messageText: string;

  @Column('tinyint', {
    name: 'status',
    comment: '-1 deleted, 0 normal，1 deactivated',
  })
  @IsNotEmpty()
  status: number;

  @Column('varchar', {
    name: 'sender',
  })
  @IsNotEmpty()
  sender: string;

  @Column('datetime', {
    name: 'created_at',
    default: () => 'CURRENT_TIMESTAMP',
  })
  createdAt: Date;

  @ManyToOne(() => Dialog, (dialog) => dialog.dialogMessages, {
    onDelete: 'CASCADE',
    onUpdate: 'RESTRICT',
  })
  @JoinColumn([{ name: 'dialog_id', referencedColumnName: 'dialogId' }])
  dialog: Dialog;
}
