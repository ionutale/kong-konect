import { Injectable, Inject, HttpException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { User } from './users.entity';
import { USERS_REPOSITORY } from './users.constants';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcrypt';

// i need this as a fix string. Putting it in the constants or .env file it may give a sense of "hey, let me change this for a moment" and just break everything
const saltOrRounds = 10;

@Injectable()
export class UsersService {
  constructor(
    @Inject(USERS_REPOSITORY)
    private userRepository: Repository<User>,
    private jwtService: JwtService,
    private configService: ConfigService,
  ) {}

  async findAll(): Promise<User[]> {
    return this.userRepository.find({
      select: ['id', 'name', 'email'],
      relations: ['organization'],
    });
  }

  async updatePassword(id: string, password: string): Promise<User> {
    try {
      const user = await this.userRepository.findOne({
        where: { id },
        relations: ['organization'],
      });

      if (!user) {
        return null;
      }

      const hash = await bcrypt.hash(password, saltOrRounds);
      user.password = hash;

      return this.userRepository.save(user);
    } catch (error) {
      throw new HttpException('Bad request', 400);
    }
  }

  async login(
    id: string,
    password: string,
  ): Promise<{
    access_token: string;
    user: User;
  }> {
    try {
      const user = await this.userRepository.findOne({
        where: { id },
      });

      if (!user) {
        throw new HttpException('Bad request', 400);
      }

      const match = await bcrypt.compare(password, user.password);
      if (!match) {
        throw new HttpException('Bad request', 400);
      }

      const payload = {
        id: user.id,
        username: user.name,
        organization_id: user.organization_id,
      };
      const token = this.jwtService.sign(payload);
      console.log('payload', payload, 'token', token);

      delete user.password;

      return {
        access_token: token,
        user,
      };
    } catch (error) {
      throw new HttpException('Bad request', 400);
    }
  }
}
