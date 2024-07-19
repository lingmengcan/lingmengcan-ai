import { Method } from '@/utils/http/axiosplus';
import { Txt2ImgDto, Txt2ImgResponse } from '../dtos/draw.dto';
import httpHandler from '@/utils/http';
import fs from 'fs';

export class StableDiffusionService {
  async txt2img(dto: Txt2ImgDto, baseUrl: string) {
    const url = `${baseUrl}/sdapi/v1/txt2img`;

    const res = await httpHandler.request<Txt2ImgResponse>(url, Method.POST, dto);

    const images = res.images;
    if (images.length === 0) return;
    // const imageUrls = images.map((item) => `data:image/png;base64,${item}`);
    // console.log(imageUrls);
    images.forEach((base64Image, index) => {
      const buffer = this.convertBase64ToBuffer(base64Image);
      this.saveBufferAsImage(buffer, `image_${index}.png`);
    });

    return res;
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
