import { Injectable } from '@nestjs/common';
import { ChatglmService } from './chatglm.service';

@Injectable()
export class ChatService {
  //chatglm交互
  //自由对话
  async chat(body) {
    const res = new ChatglmService();
    return res.chat(body);
  }
  //文档问答
  async chatfile(body) {
    const res = new ChatglmService();
    return res.chatfile(body);
  }
}
