import { MenuListDto } from '@/dtos/menu.dto';
import { Meta, Route } from '@/dtos/route.dto';
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
      .select('Menu.permissions')
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
        res.push(item.permissions);
      }
    });

    return res;
  }

  findAll(dto: MenuListDto): Promise<Menu[]> {
    const { menuName, status } = dto;

    let qb = this.repository
      .createQueryBuilder('Menu')
      .andWhere('Menu.status != -1');

    if (menuName) {
      qb = qb.andWhere('Menu.menuName like :name', {
        name: '%' + menuName + '%',
      });
    }

    if (status) {
      qb = qb.andWhere('Menu.status = :value', {
        value: status,
      });
    }

    qb.orderBy('Menu.sort', 'ASC');
    return qb.getMany();
  }

  /**
   * 查找用户全部权限菜单
   * @param userId
   * @returns
   */
  async findMenusByUser(userId: string): Promise<Menu[]> {
    const qb = await this.repository
      .createQueryBuilder('Menu')
      .innerJoin('Menu.roleMenus', 'RoleMenu')
      .innerJoin('RoleMenu.role', 'Role')
      .innerJoin('Role.roleUsers', 'RoleUser')
      .where('RoleUser.userId = :userId AND Role.status=0 AND Menu.status=0', {
        userId,
      })
      .orderBy({ 'Menu.parentId': 'ASC', 'Menu.sort': 'ASC' })
      .getMany();

    return qb;
  }

  /**
   * 构建前端路由所需要的菜单
   *
   * @param menus 菜单列表
   * @return 路由列表
   */
  buildRoutes(menus: Menu[], menuId = '0'): Route[] {
    const routes: Route[] = [];
    menus.forEach((menu) => {
      // 如果是目录和菜单，递归找子路由
      if (
        menu.parentId === menuId &&
        (menu.menuType === 'contents' || menu.menuType === 'menu')
      ) {
        const route = new Route();
        route.name = menu.menuCode || 'Menu' + menu.menuId;
        // route.path = this.getRoutePath(menu, parentPath); // 留给前端处理
        route.path = menu.path;
        route.component = menu.component;
        route.query = menu.query;
        route.redirect = menu.redirect;

        const meta = new Meta();
        meta.cached = menu.cached === 1;
        meta.icon = menu.icon;
        meta.title = menu.menuName;
        meta.query = menu.query;
        meta.hidden = menu.hidden === 1;
        meta.permissions = menu.permissions;
        route.meta = meta;
        const children = this.buildRoutes(menus, menu.menuId);

        // 如果存在子菜单
        if (children.length > 0) {
          route.children = children;
        }

        routes.push(route);
      }
    });
    return routes;
  }

  /**
   * 获取路由地址
   *
   * @param menu 菜单信息
   * @return 路由地址
   */
  getRoutePath(menu: Menu, parentPath: string): string {
    // 非外链
    if (!menu.path.match(/(http|https):\/\/([\w.]+\/?)\S*/)) {
      return `${parentPath}/${menu.path}`;
    }
    return menu.path;
  }

  // 获取子菜单
  async getChildren(parentId: string): Promise<Menu[]> {
    // 获取所有子菜单以计算menuid
    const children = await this.repository.find({
      where: { parentId: parentId },
      order: { menuId: 'DESC' },
    });
    return children;
  }

  /**
   * 菜单，假删除，状态改为-1
   *
   * @param menuId
   * @return 结果
   */
  async delStatus(menuId: string, userName: string) {
    return await this.repository.update(
      { menuId: menuId },
      { status: -1, updatedUser: userName },
    );
  }
}
