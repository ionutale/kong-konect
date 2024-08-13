import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Service } from './services.entity';

@Entity({ name: 'versions', schema: 'public' })
export class Version {
  @PrimaryColumn()
  id: string;

  @Column()
  service_id: string;

  @ManyToOne(() => Service, (service) => service.versions)
  @JoinColumn({
    name: 'service_id',
    referencedColumnName: 'id',
    foreignKeyConstraintName: 'service_id',
  })
  service: Service;

  @Column({ length: 255 })
  version: string;

  @Column({ length: 255 })
  name: string;

  @Column('text')
  description: string;

  @Column()
  created_at: Date;

  @Column()
  updated_at: Date;
}
