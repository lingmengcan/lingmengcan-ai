import { IsNotEmpty } from 'class-validator';

/**
 * 角色列表
 */
export class RoleListDto {
  roleName: string;

  roleCode: string;

  status: string;

  @IsNotEmpty()
  page: number;

  @IsNotEmpty()
  pageSize: number;
}
