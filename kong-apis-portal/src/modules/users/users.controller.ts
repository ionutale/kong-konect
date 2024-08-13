import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from './users.entity';

@Controller()
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  // WARNING: This is for demo purposes only, as it makes it easy to get the user's id and organization id
  @Get()
  getAllUsers(): Promise<User[]> {
    return this.usersService.findAll();
  }

  @Post(':id/password')
  updateUserPassword(@Param() params: any, @Body() body: any): Promise<User> {
    return this.usersService.updatePassword(params.id, body.password);
  }

  @Post(':id/login')
  login(
    @Param() params: any,
    @Body() body: any,
  ): Promise<{ access_token: string; user: User }> {
    return this.usersService.login(params.id, body.password);
  }
}
