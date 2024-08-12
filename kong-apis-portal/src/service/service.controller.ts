import { Controller, Get } from '@nestjs/common';
import { ServiceService } from './service.service';
import { Service } from './service.entity';

@Controller('services')
export class ServiceController {
  constructor(private readonly serviceService: ServiceService) { }

  @Get()
  getAllServices(): Promise<Service[]> {
    return this.serviceService.findAll();
  }
}