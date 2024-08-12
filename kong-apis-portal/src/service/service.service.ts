import { Injectable, Inject } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Service } from './service.entity';
import { SERVICE_REPOSITORY } from './service.constants';

@Injectable()
export class ServiceService {
  constructor(
    @Inject(SERVICE_REPOSITORY)
    private serviceRepository: Repository<Service>,
  ) { }

  async findAll(): Promise<Service[]> {
    return this.serviceRepository.find();
  }
}