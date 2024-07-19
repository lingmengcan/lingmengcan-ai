import { MediaService } from '@/services/media.service';
import { successJson } from '@/utils/result';
import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags } from '@nestjs/swagger';
import { Txt2ImgDto } from '../dtos/draw.dto';

@ApiTags('draw') // 添加 接口标签 装饰器
@Controller('draw')
export class DrawController {
  constructor(private readonly mediaService: MediaService) {}

  /**
   * 管理列表
   *
   * @param dto
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @Post('txt2img')
  async txt2img(@Body() dto: Txt2ImgDto) {
    const res = await this.mediaService.txt2img(dto);
    return successJson(res);
  }
}
