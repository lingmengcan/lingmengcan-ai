import { User } from '@/entities/user.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private repository: Repository<User>,
    private dataSource: DataSource,
  ) {}

  findByUserId(userId: string): Promise<User> {
    return this.repository.findOne({
      where: { userId: userId, status: 0 },
    });
  }

  findByUsername(username: string): Promise<User> {
    return this.repository.findOne({
      where: { userName: username, status: 0 },
    });
  }
}
