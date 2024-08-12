import { DataSource } from 'typeorm';
import { Service } from './service.entity';
import { DATA_SOURCE } from 'src/database/database.constants';
import { SERVICE_REPOSITORY } from './service.constants';

export const serviceProviders = [
  {
    provide: SERVICE_REPOSITORY,
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Service),
    inject: [DATA_SOURCE],
  },
];