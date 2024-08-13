import { DataSource } from 'typeorm';
import { Service } from './services.entity';
import { DATA_SOURCE } from 'src/database/database.constants';
import { SERVICE_REPOSITORY } from './services.constants';

export const serviceProviders = [
  {
    provide: SERVICE_REPOSITORY,
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Service),
    inject: [DATA_SOURCE],
  },
];
