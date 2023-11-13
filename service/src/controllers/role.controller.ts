import { RoleListDto } from '@/dtos/role.dto';
import { Role } from '@/entities/role.entity';
import { RoleService } from '@/services/role.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Post, UseGuards, Request } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('role') // 添加 swagger 接口标签
@Controller('role')
export class RoleController {
  constructor(private readonly roleService: RoleService) {}

  /**
   * 角色管理列表
   *
   * @param dto
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('list')
  async findAll(@Body() dto: RoleListDto) {
    // console.log(roleDto);
    return successJson(await this.roleService.findAll(dto));
  }

  /**
   * 变更状态
   *
   * @param role
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('change-status')
  async changeStatus(@Body() role: Role, @Request() req: any) {
    const userName = req.user.userName;
    role.updatedUser = userName;
    return successJson(await this.roleService.updateStatus(role));
  }

  /**
   * 查找所有角色次菜单id
   *
   * @param roleId
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('menus')
  async getMenus(@Body('roleId') roleId: string) {
    return successJson(await this.roleService.findMenuIdsByRoleId(roleId));
  }
}
