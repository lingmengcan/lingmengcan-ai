import { ModelListDto } from '@/dtos/model.dto';
import { Model } from '@/entities/model.entity';
import { ModelService } from '@/services/model.service';
import { successJson } from '@/utils/result';
import { Controller, UseGuards, Request, Post, Body } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('model') // 添加 接口标签 装饰器
@Controller('model')
export class ModelController {
  constructor(private readonly modelService: ModelService) {}

  /**
   * 管理列表
   *
   * @param dto
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('list')
  async findAll(@Body() dto: ModelListDto) {
    return successJson(await this.modelService.findAll(dto));
  }

  /**
   * 变更状态
   *
   * @param model
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('change-status')
  async changeStatus(@Body() model: Model, @Request() req: any) {
    const userName = req.user.userName;
    model.updatedUser = userName;
    return successJson(await this.modelService.updateStatus(model));
  }

  /**
   * 添加
   *
   * @param model
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('/add')
  async add(@Body() model: Model, @Request() req: any) {
    const userName = req.user.userName;
    model.updatedUser = userName;
    model.createdUser = userName;
    return successJson(await this.modelService.addModel(model));
  }

  /**
   * 编辑
   *
   * @param model
   * @param req
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('edit')
  async edit(@Body() model: Model, @Request() req: any) {
    const userName = req.user.userName;
    model.updatedUser = userName;
    return successJson(await this.modelService.updateModel(model));
  }
}
