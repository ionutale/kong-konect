import { Module } from '@nestjs/common';
import { DatabaseModule } from '../../database/database.module';
import { serviceProviders } from './services.providers';
import { ServiceService } from './services.service';
import { ServiceController } from './services.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [ServiceController],
  providers: [...serviceProviders, ServiceService],
})
export class ServiceModule {}
