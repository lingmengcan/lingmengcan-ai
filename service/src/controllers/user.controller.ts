import { MenuService } from '@/services/menu.service';
import { UserService } from '@/services/user.service';
import { successJson } from '@/utils/result';
import { Controller, Get, UseGuards, Request } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('user') // 添加 接口标签 装饰器
@Controller('user')
export class UserController {
  constructor(
    private readonly userService: UserService,
    private readonly menuService: MenuService,
  ) {}

  @UseGuards(AuthGuard('jwt'))
  @Get('info')
  async getUserInfo(@Request() req: any) {
    const userId = req.user.userId;
    const permissions = await this.menuService.findPermissionsByUserId(userId);

    const result = {
      user: req.user,
      permissions,
    };
    // 生成令牌
    return successJson(result);
  }
}
