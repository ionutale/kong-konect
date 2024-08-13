import { Controller, Get, Param, UseGuards, Req, Query } from '@nestjs/common';
import { ServiceService } from './services.service';
import { Service } from './services.entity';
import { AuthGuard } from 'src/auth.guard';
import { Response } from 'src/types/response.type';
import { QueryDto } from './servicesQuery.dto';

@Controller()
export class ServiceController {
  constructor(private readonly serviceService: ServiceService) {}

  @UseGuards(AuthGuard)
  @Get()
  getAllServices(
    @Req() req,
    @Query() query: QueryDto,
  ): Promise<Response<Service>> {
    return this.serviceService.findAll(req.user, query);
  }

  @UseGuards(AuthGuard)
  @Get(':id')
  getServiceById(@Param() params: any, @Req() req): Promise<Service> {
    return this.serviceService.findById(params.id, req.user);
  }

  @UseGuards(AuthGuard)
  @Get(':id/versions/:versionId')
  getServiceVersions(@Param() params: any, @Req() req): Promise<Service> {
    return this.serviceService.findServiceVersions(
      params.id,
      params.versionId,
      req.user,
    );
  }
}
