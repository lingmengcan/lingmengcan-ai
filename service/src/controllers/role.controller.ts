import { RoleListDto } from '@/dtos/role.dto';
import { RoleService } from '@/services/role.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Post, UseGuards } from '@nestjs/common';
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
}
