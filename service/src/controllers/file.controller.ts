import { FileDto } from '@/dtos/file.dto';
import { FileService } from '@/services/file.service';
import { successJson } from '@/utils/result';
import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFile,
  Body,
  Request,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiTags } from '@nestjs/swagger';
import { Express } from 'express';

@ApiTags('file') // 添加 接口标签 装饰器
@Controller('file')
export class FileController {
  constructor(private readonly fileService: FileService) {}

  /**
   * upload
   *
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @UseInterceptors(FileInterceptor('file'))
  @Post('upload')
  async upload(
    @Body() dto: FileDto,
    @Request() req: any,
    @UploadedFile() file: Express.Multer.File,
  ) {
    const userName = req.user.userName;

    const fileId = await this.fileService.chatfile(userName, dto, file);

    console.log(fileId);
    return successJson(fileId);
  }
}
