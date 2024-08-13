import { Injectable, Inject } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Organization } from './organizations.entity';
import { ORGANIZATIONS_REPOSITORY } from './organizations.constants';

@Injectable()
export class OrganizationsService {
  constructor(
    @Inject(ORGANIZATIONS_REPOSITORY)
    private organizationRepository: Repository<Organization>,
  ) {}

  async findAll(): Promise<Organization[]> {
    return this.organizationRepository.find();
  }
}
