import { Module } from '@nestjs/common';
import { DatabaseModule } from '../../database/database.module';
import { organizationProviders } from './organizations.providers';
import { OrganizationsService } from './organizations.service';
import { OrganizationsController } from './organizations.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [OrganizationsController],
  providers: [...organizationProviders, OrganizationsService],
})
export class OrganizationsModule {}
