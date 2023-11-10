import { RoleListDto } from '@/dtos/role.dto';
import { Role } from '@/entities/role.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class RoleService {
  constructor(
    @InjectRepository(Role)
    private repository: Repository<Role>,
    private dataSource: DataSource,
  ) {}

  /**
   * 角色管理列表
   *
   * @param roleDto
   * @returns
   */
  async findAll(roleDto: RoleListDto) {
    const { roleName, roleCode, status, page, pageSize } = roleDto;
    // 默认首页
    const skip = page && pageSize ? (page - 1) * pageSize : 0;

    // 默认20条数据
    const take = pageSize ? pageSize : 20;
    let qb = this.repository
      .createQueryBuilder('Role')
      .andWhere('Role.status != -1');

    if (roleName) {
      qb = qb.andWhere('Role.roleName like :name', {
        name: '%' + roleName + '%',
      });
    }

    if (roleCode) {
      qb = qb.andWhere('Role.roleCode like :value', {
        value: '%' + roleCode + '%',
      });
    }

    if (status) {
      qb = qb.andWhere('Role.status = :value', {
        value: status,
      });
    }

    qb.orderBy('Role.sort', 'ASC');
    // const roles = this.repository.find({
    //   where: {
    //     roleCode: Like('%' + roleCode + '%'),
    //     roleName: Like('%' + roleName + '%'),
    //     status: status,
    //   },
    //   order: {
    //     sort: 'ASC',
    //   },
    //   skip: skip,
    //   take: take,
    // });

    const [list, count] = await qb.skip(skip).take(take).getManyAndCount();
    return {
      list,
      page,
      pageSize,
      count,
    };
  }
}
