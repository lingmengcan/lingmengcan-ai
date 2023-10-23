import { Menu } from '@/entities/menu.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class MenuService {
  constructor(
    @InjectRepository(Menu)
    private repository: Repository<Menu>,
  ) {}

  /**
   * 查找用户全部权限
   * @param userId
   * @returns
   */
  async findPermissionsByUserId(userId: string): Promise<string[]> {
    const permissions = await this.repository
      .createQueryBuilder('Menu')
      .select('Menu.permission')
      .innerJoin('Menu.roleMenus', 'RoleMenu')
      .innerJoin('RoleMenu.role', 'Role')
      .innerJoin('Role.roleUsers', 'RoleUser')
      .where('RoleUser.userId = :userId AND Role.status=0 AND Menu.status=0', {
        userId,
      })
      .getMany();

    const res: string[] = [];
    permissions.forEach((item) => {
      if (item) {
        res.push(item.permission);
      }
    });

    return res;
  }
}
