import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ name: 'services', schema: 'public' })
export class Service {
  @PrimaryColumn()
  id: string;

  @Column({ length: 255 })
  name: string;

  @Column('text')
  description: string;

  @Column()
  created_at: Date;

  @Column()
  updated_at: Date;
}