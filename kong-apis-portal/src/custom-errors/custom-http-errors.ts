import { HttpStatus, HttpException } from '@nestjs/common';

export class NotFoundException extends HttpException {
  constructor() {
    super('Forbidden', HttpStatus.BAD_REQUEST);
  }
}
