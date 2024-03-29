import { Message } from '@/entities/message.entity';
import { ApiProperty } from '@nestjs/swagger';

export class ChatDto {
  message: Message;
  temperature: number;
  llm: string;
}

export class ChatGlmDto {
  message: string;
  @ApiProperty({
    example: [
      ['Human:xx', 'Assistant:xx'],
      ['Human:xx', 'Assistant:xx'],
    ],
  })
  history: Array<string>;
}

export class ChatGptDto {
  message: string;
  api_key: string;
  basePath: string;
  @ApiProperty({
    example: [
      ['Human:xx', 'Assistant:xx'],
      ['Human:xx', 'Assistant:xx'],
    ],
  })
  history: Array<string>;
}
export class SetEmbeddingDto {
  @ApiProperty({
    example: 'default/cohere/openai',
  })
  name: string;
  api_key?: string;
}
