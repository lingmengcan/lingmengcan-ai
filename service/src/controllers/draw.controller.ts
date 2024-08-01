import { MediaService } from '@/services/media.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Request, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags } from '@nestjs/swagger';
import { MediaListDto, Txt2ImgDto } from '../dtos/draw.dto';

@UseGuards(AuthGuard('jwt'))
@ApiTags('draw') // 添加 接口标签 装饰器
@Controller('draw')
export class DrawController {
  constructor(private readonly mediaService: MediaService) {}

  /**
   * 文生图
   *
   * @param dto
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('txt2img')
  async txt2img(@Body() dto: Txt2ImgDto, @Request() req: any) {
    const userName = req.user.userName;
    const res = await this.mediaService.txt2img(dto, userName);
    return successJson(res);
  }

  /**
   * 获取全部生成的内容
   *
   * @param dto
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('list')
  async list(@Body() dto: MediaListDto, @Request() req: any) {
    const userName = req.user.userName;
    const res = await this.mediaService.findAll(dto, userName);

    return successJson(res);
  }
}
