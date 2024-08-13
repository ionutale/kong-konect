import { DataSource } from 'typeorm';
import { User } from './users.entity';
import { DATA_SOURCE } from 'src/database/database.constants';
import { USERS_REPOSITORY } from './users.constants';

export const userProviders = [
  {
    provide: USERS_REPOSITORY,
    useFactory: (dataSource: DataSource) => dataSource.getRepository(User),
    inject: [DATA_SOURCE],
  },
];
