import { Column, Entity, Index, JoinColumn, ManyToOne } from 'typeorm';
import { Dept } from './dept.entity';
import { Role } from './role.entity';

@Index('role_dept_role_id_foreign', ['roleId'], {})
@Index('role_dept_dept_id_foreign', ['deptId'], {})
@Entity('role_dept', { schema: 'lmc' })
export class RoleDept {
  @Column('bigint', { primary: true, name: 'role_id', unsigned: true })
  roleId: string;

  @Column('bigint', { primary: true, name: 'dept_id', unsigned: true })
  deptId: string;

  @ManyToOne(() => Dept, (dept) => dept.roleDepts, {
    onDelete: 'CASCADE',
    onUpdate: 'RESTRICT',
  })
  @JoinColumn([{ name: 'dept_id', referencedColumnName: 'deptId' }])
  dept: Dept;

  @ManyToOne(() => Role, (role) => role.roleDepts, {
    onDelete: 'CASCADE',
    onUpdate: 'RESTRICT',
  })
  @JoinColumn([{ name: 'role_id', referencedColumnName: 'roleId' }])
  role: Role;
}
