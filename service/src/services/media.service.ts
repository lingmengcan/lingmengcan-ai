import { Txt2ImgDto } from '@/dtos/draw.dto';
import { Media } from '@/entities/media.entity';
import { StableDiffusionService } from './stable-diffusion.service';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class MediaService {
  constructor(
    @InjectRepository(Media)
    private repository: Repository<Media>,
  ) {}

  /**
   * 添加媒体到表
   *
   * @param dto 信息
   * @return 结果
   */
  async txt2img(dto: Txt2ImgDto) {
    const stableDiffusionService = new StableDiffusionService();
    const baseUrl = `http://127.0.0.1:7861`;
    return stableDiffusionService.txt2img(dto, baseUrl);
  }

  /**
   * 添加媒体到表
   *
   * @param model 信息
   * @return 结果
   */
  async addModel(model: Media) {
    const mediaId = uuidv4();

    const entity = new Media();
    entity.mediaId = mediaId;
    entity.mediaType = model.mediaType;
    entity.fileName = model.fileName;
    entity.filePath = model.filePath;
    entity.ai = model.ai;
    entity.generationParameters = model.generationParameters;
    entity.status = model.status;
    entity.createdUser = model.createdUser;
    entity.createdAt = new Date();

    return this.repository.save(entity);
  }
}
