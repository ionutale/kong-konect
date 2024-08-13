import { Controller, Get } from '@nestjs/common';
import { OrganizationsService } from './organizations.service';
import { Organization } from './organizations.entity';

@Controller()
export class OrganizationsController {
  constructor(private readonly organizationsService: OrganizationsService) {}

  @Get()
  getAllOrganizations(): Promise<Organization[]> {
    return this.organizationsService.findAll();
  }
}
