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

  @ValidateIf((o) => o.sort)
  @Matches(/^(-)?[a-z0-9_]*$/i, {
    message:
      'Sort must be alphanumeric with underscore, and can have a - (dash) prefix: Example -name or name.',
  })
  sort: string | null;
}
