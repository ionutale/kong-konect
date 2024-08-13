import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Organization } from '../organizations/organizations.entity';

@Entity({ name: 'users', schema: 'public' })
export class User {
  @PrimaryColumn()
  id: string;

  @ManyToOne(() => Organization, (organization) => organization.id)
  @JoinColumn({
    name: 'organization_id',
  })
  organization: Organization;

  @Column({ length: 255 })
  organization_id: string;

  @Column({ length: 255 })
  name: string;

  @Column({ length: 255 })
  email: string;

  @Column({ length: 255 })
  password: string;

  @Column()
  created_at: Date;

  @Column()
  updated_at: Date;
}
