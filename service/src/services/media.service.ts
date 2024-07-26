import { MediaListDto, Txt2ImgDto } from '@/dtos/draw.dto';
import { Media } from '@/entities/media.entity';
import { StableDiffusionService } from './stable-diffusion.service';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { v4 as uuidv4 } from 'uuid';
import { isNullOrUndefined } from '@/utils';
import fs from 'fs';
import { ConfigService } from '@nestjs/config';
import dayjs from 'dayjs';

@Injectable()
export class MediaService {
  constructor(
    @InjectRepository(Media)
    private repository: Repository<Media>,
    private readonly configService: ConfigService,
  ) {}

  /**
   * 文生图，然后添加图片到表
   *
   * @param dto 信息
   * @return 结果
   */
  async txt2img(dto: Txt2ImgDto, userName: string) {
    const stableDiffusionService = new StableDiffusionService();
    const baseUrl = `http://127.0.0.1:7861`;
    const txt2img = await stableDiffusionService.txt2img(dto, baseUrl);

    const images = txt2img.images;

    if (images.length === 0) return;

    const basePath = this.configService.get<string>('files.aigc') + '/images/' + dayjs().format('YYYY-MM-DD');
    // 自动创建目录，如果不存在
    if (!fs.existsSync(basePath)) {
      fs.mkdirSync(basePath, { recursive: true });
    }
    images.forEach((base64Image) => {
      const imageName = `${uuidv4()}.png`;
      const imagePath = `${basePath}/${imageName}`;
      const buffer = this.convertBase64ToBuffer(base64Image);
      this.saveBufferAsImage(buffer, imagePath);

      this.addMedia('image', imageName, `/${imagePath}`, 'sd', JSON.stringify(dto), 'completed', userName);
    });

    return 'Success';
  }

  /**
   * 列表
   *
   * @param dto
   * @returns
   */
  async findAll(dto: MediaListDto, userName: string) {
    const { mediaType, status, page, pageSize } = dto;
    // 默认首页
    const skip = page && pageSize ? (page - 1) * pageSize : 0;

    // 默认10条数据
    const take = pageSize ? pageSize : 10;
    const qb = this.repository.createQueryBuilder('Media').andWhere('Media.createdUser = :value', {
      value: userName,
    });

    // if (mediaType) {
    //   // 将单个字符串转换为数组
    //   const typeArray = Array.isArray(mediaType) ? mediaType : [mediaType];

    //   // 仅在数组不为空时添加查询条件
    //   if (typeArray.length > 0) {
    //     qb = qb.andWhere('Media.mediaType IN (:...value)', {
    //       value: typeArray,
    //     });
    //   }
    // }

    // if (!isNullOrUndefined(status)) {
    //   qb = qb.andWhere('Media.status = :value', {
    //     value: status,
    //   });
    // }

    qb.orderBy({ 'Media.createdAt': 'DESC' });

    const [list, count] = await qb.skip(skip).take(take).getManyAndCount();
    return {
      list,
      page,
      pageSize,
      count,
    };
  }

  /**
   * 添加媒体到表
   *
   * @param media 信息
   * @return 结果
   */
  async addMedia(
    mediaType: string,
    fileName: string,
    filePath: string,
    ai: string,
    generationParameters: string,
    status: string,
    createdUser: string,
  ) {
    const mediaId = uuidv4();

    const entity = new Media();
    entity.mediaId = mediaId;
    entity.mediaType = mediaType;
    entity.fileName = fileName;
    entity.filePath = filePath;
    entity.ai = ai;
    entity.generationParameters = generationParameters;
    entity.status = status;
    entity.createdUser = createdUser;
    entity.createdAt = new Date();

    return this.repository.save(entity);
  }

  // 将 Base64 编码的字符串转换为 Buffer
  convertBase64ToBuffer = (base64: string): Buffer => {
    const base64Data = base64.replace(/^data:image\/\w+;base64,/, '');
    return Buffer.from(base64Data, 'base64');
  };

  // 将 Buffer 写入 PNG 文件
  saveBufferAsImage = (buffer: Buffer, fileName: string): void => {
    fs.writeFileSync(fileName, buffer);
    console.log(`Image saved as ${fileName}`);
  };
}
