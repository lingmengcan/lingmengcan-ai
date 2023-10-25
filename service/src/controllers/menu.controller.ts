import { MenuListDto } from '@/dtos/menu.dto';
import { MenuService } from '@/services/menu.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Get, Request, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('menu') // 添加 接口标签 装饰器
@Controller('menu')
export class MenuController {
  constructor(private readonly menuService: MenuService) {}

  /**
   * 获取菜单路由
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Get('/routes')
  async getRoutes(@Request() req: any) {
    const menus = await this.menuService.findMenusByUser(req.user.userId);
    const routes = this.menuService.buildRoutes(menus);

    return successJson(routes);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('/list')
  async findAll(@Body() dto: MenuListDto) {
    return successJson(await this.menuService.findAll(dto));
  }
}
