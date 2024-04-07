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
  Res,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiTags } from '@nestjs/swagger';
import { Express } from 'express';
import { Response } from 'express';

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

  /**
   * upload
   *
   * @returns
   */
  @UseGuards(AuthGuard('jwt'))
  @UseInterceptors(FileInterceptor('file'))
  @Post('chat')
  async file(
    @Body() dto: FileDto,
    @Request() req: any,
    @UploadedFile() file: Express.Multer.File,
    @Res() res: Response,
  ) {
    res.setHeader('Content-Type', 'text/plain');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');
    res.setHeader('Transfer-Encoding', 'chunked');
    res.setHeader('X-Content-Type-Options', 'nosniff');

    const userName = req.user.userName;

    const stream = await this.fileService.chatfile(userName, dto, file);

    for await (const chunk of stream) {
      res.write(chunk);
    }
    res.end();
  }
}
