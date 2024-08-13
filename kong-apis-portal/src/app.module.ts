import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ServiceModule } from './modules/services/services.module';
import { RouterModule, Routes } from '@nestjs/core';
import { UsersModule } from './modules/users/users.module';
import { OrganizationsModule } from './modules/organizations/organizations.module';
import { ConfigModule } from '@nestjs/config';
import { AuthGuard } from './auth.guard';

const routes: Routes = [
  {
    path: 'api/v1',
    children: [
      {
        path: '/services',
        module: ServiceModule,
      },
      {
        path: '/users',
        module: UsersModule,
      },
      {
        path: '/organizations',
        module: OrganizationsModule,
      },
    ],
  },
];

@Module({
  imports: [
    RouterModule.register(routes),
    ServiceModule,
    UsersModule,
    OrganizationsModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
  ],
  controllers: [AppController],
  providers: [AppService, AuthGuard],
})
export class AppModule {}
