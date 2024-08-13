import { Entity, Column, PrimaryColumn, OneToMany, JoinColumn } from 'typeorm';
import { Version } from './versions.entity';

@Entity({ name: 'services', schema: 'public' })
export class Service {
  @PrimaryColumn()
  id: string;

  @Column()
  organization_id: string;

  @OneToMany(() => Version, (version) => version.service)
  @JoinColumn({
    referencedColumnName: 'service_id',
  })
  versions: Version[];

  versionCount: number;

  @Column({ length: 255 })
  name: string;

  @Column('text')
  description: string;

  @Column()
  created_at: Date;

  @Column()
  updated_at: Date;
}
