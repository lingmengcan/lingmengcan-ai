import { ModelListDto } from '@/dtos/model.dto';
import { Model } from '@/entities/model.entity';
import { isNullOrUndefined } from '@/utils';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class ModelService {
  constructor(
    @InjectRepository(Model)
    private repository: Repository<Model>,
    private dataSource: DataSource,
  ) {}

  /**
   * 获取实体
   * @param id
   * @returns
   */
  findOne(id: string): Promise<Model> {
    return this.repository.findOneBy({ modelId: id });
  }

  findByModelId(modelId: string): Promise<Model> {
    return this.repository.findOne({
      where: { modelId, status: 0 },
    });
  }

  findByModelName(modelname: string): Promise<Model> {
    return this.repository.findOne({
      where: { modelName: modelname, status: 0 },
    });
  }

  /**
   * 字典管理列表
   *
   * @param modelDto
   * @returns
   */
  async findAll(modelDto: ModelListDto) {
    const { modelName, modelType, status, page, pageSize } = modelDto;
    // 默认首页
    const skip = page && pageSize ? (page - 1) * pageSize : 0;

    // 默认20条数据
    const take = pageSize ? pageSize : 20;
    let qb = this.repository.createQueryBuilder('Model').andWhere('Model.status != -1');

    if (modelName) {
      qb = qb.andWhere('Model.modelName like :value', {
        value: '%' + modelName + '%',
      });
    }

    if (modelType) {
      qb = qb.andWhere('Model.modelType like :value', {
        value: '%' + modelType + '%',
      });
    }

    if (!isNullOrUndefined(status)) {
      qb = qb.andWhere('Model.status = :value', {
        value: status,
      });
    }

    qb.orderBy({ 'Model.modelType': 'ASC', 'Model.sort': 'ASC' });

    const [list, count] = await qb.skip(skip).take(take).getManyAndCount();
    return {
      list,
      page,
      pageSize,
      count,
    };
  }

  /**
   * 修改状态
   *
   * @param model 信息
   * @return 结果
   */
  async updateStatus(model: Model) {
    const entity = await this.findOne(model.modelId);
    entity.status = model.status;
    entity.updatedUser = model.updatedUser;
    entity.updatedAt = new Date();
    return this.repository.save(entity);
  }

  /**
   * 修改用户
   *
   * @param model 用户信息
   * @return 结果
   */
  async updateModel(model: Model) {
    const entity = await this.findOne(model.modelId);
    entity.modelName = model.modelName;
    entity.modelTypeName = model.modelTypeName;
    entity.modelType = model.modelType;
    entity.sort = model.sort;
    entity.status = model.status;
    entity.description = model.description;
    entity.updatedUser = model.updatedUser;
    entity.updatedAt = new Date();
    return this.repository.save(entity);
  }

  /**
   * 添加用户
   *
   * @param model 信息
   * @return 结果
   */
  async addModel(model: Model) {
    const modelId = uuidv4();

    const entity = new Model();
    entity.modelId = modelId;
    entity.modelName = model.modelName;
    entity.modelTypeName = model.modelTypeName;
    entity.modelType = model.modelType;
    entity.sort = model.sort;
    entity.status = model.status;
    entity.description = model.description ?? '';
    entity.createdUser = model.createdUser;
    entity.updatedUser = model.updatedUser;
    entity.createdAt = new Date();
    entity.updatedAt = new Date();

    return this.repository.save(entity);
  }
}
