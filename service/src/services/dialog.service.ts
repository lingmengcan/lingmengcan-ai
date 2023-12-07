import { Dialog } from '@/entities/dialog.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class DialogService {
  constructor(
    @InjectRepository(Dialog)
    private repository: Repository<Dialog>,
    private dataSource: DataSource,
  ) {}

  findByDialogId(dialogId: string): Promise<Dialog> {
    return this.repository.findOne({
      where: { dialogId: dialogId, status: 0 },
    });
  }

  /**
   * 新增
   *
   * @param menu 信息
   * @return 结果
   */
  async addDialog(dialog: Dialog) {
    const dialogId = uuidv4();

    const entity = new Dialog();
    entity.dialogId = dialogId;
    entity.dialogName = dialog.dialogName;
    entity.userName = dialog.userName;
    entity.status = dialog.status;
    entity.createdAt = new Date();
    entity.updatedAt = new Date();
    return this.repository.save(entity);
  }
}
