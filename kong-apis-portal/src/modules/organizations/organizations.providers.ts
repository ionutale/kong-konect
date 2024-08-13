import { DataSource } from 'typeorm';
import { Organization } from './organizations.entity';
import { DATA_SOURCE } from 'src/database/database.constants';
import { ORGANIZATIONS_REPOSITORY } from './organizations.constants';

export const organizationProviders = [
  {
    provide: ORGANIZATIONS_REPOSITORY,
    useFactory: (dataSource: DataSource) =>
      dataSource.getRepository(Organization),
    inject: [DATA_SOURCE],
  },
];
