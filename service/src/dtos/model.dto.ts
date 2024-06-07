import { IsNotEmpty } from 'class-validator';

/**
 * 用户列表
 */
export class ModelListDto {
  modelName: string;
  modelType: string;

  status: string;

  @IsNotEmpty()
  page: number;

  @IsNotEmpty()
  pageSize: number;
}
