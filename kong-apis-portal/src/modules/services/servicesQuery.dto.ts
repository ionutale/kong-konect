import {
  IsNotEmpty,
  IsAlphanumeric,
  IsNumberString,
  ValidateIf,
  Matches,
} from 'class-validator';

export class QueryDto {
  @IsNotEmpty()
  @IsNumberString(
    {},
    {
      message: 'Page must be a number',
    },
  )
  page: number;

  @IsNotEmpty()
  @IsNumberString(
    {},
    {
      message: 'Size must be a number',
    },
  )
  size: number;

  @ValidateIf((o) => o.search)
  @IsAlphanumeric()
  search: string | null;

  @ValidateIf((o) => o.orderby)
  @Matches(/^(-)?[a-z0-9_]*$/i, {
    message:
      'OrderBy must be alphanumeric with underscore, and can have a - (dash) prefix: Example -name or name.',
  })
  orderby: string | null;
}
