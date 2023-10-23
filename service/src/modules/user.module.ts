import { User } from '@/entities/user.entity';
import { UserService } from '@/services/user.service';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MenuModule } from './menu.module';
import { UserController } from '@/controllers/user.controller';

@Module({
  imports: [TypeOrmModule.forFeature([User]), MenuModule],
  controllers: [UserController],
  providers: [UserService],
  exports: [UserService],
})
export class UserModule {}
