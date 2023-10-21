import { IsNotEmpty } from 'class-validator';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { RoleDept } from './role_dept.entity';
import { User } from './user.entity';

@Entity('dept')
export class Dept {
  @PrimaryGeneratedColumn({ type: 'bigint', name: 'dept_id', unsigned: true })
  deptId: string;

  @Column('bigint', { name: 'parent_id', nullable: true })
  parentId: string | null;

  @Column('varchar', { name: 'dept_name', length: 32 })
  deptName: string;

  @Column('varchar', { name: 'leader', length: 32 })
  leader: string;

  @Column('int', { name: 'sort' })
  sort: number;

  @Column('tinyint', {
    name: 'status',
    comment: '-1 deleted, 0 normal，1 deactivated',
  })
  @IsNotEmpty()
  status: number;

  @Column('varchar', { name: 'description', length: 512 })
  description: string;

  @Column('varchar', { name: 'created_user', length: 32 })
  createdUser: string;

  @Column('varchar', { name: 'updated_user', length: 32 })
  updatedUser: string;

  @Column('datetime', {
    name: 'created_at',
    default: () => 'CURRENT_TIMESTAMP',
  })
  createdAt: Date;

  @Column('datetime', {
    name: 'updated_at',
    default: () => 'CURRENT_TIMESTAMP',
  })
  updatedAt: Date;

  @OneToMany(() => RoleDept, (roleDept) => roleDept.dept)
  roleDepts: RoleDept[];

  @OneToMany(() => User, (user) => user.dept)
  users: User[];
}
