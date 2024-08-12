import { Module } from '@nestjs/common';
import { DatabaseModule } from '../database/database.module';
import { serviceProviders } from './service.providers';
import { ServiceService } from './service.service';
import { ServiceController } from './service.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [ServiceController],
  providers: [
    ...serviceProviders,
    ServiceService,
  ],
})
export class ServiceModule { }