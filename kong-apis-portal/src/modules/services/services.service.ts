import { Injectable, Inject } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Service } from './services.entity';
import { SERVICE_REPOSITORY } from './services.constants';
import { User } from '../users/users.entity';
import { Response } from 'src/types/response.type';

@Injectable()
export class ServiceService {
  constructor(
    @Inject(SERVICE_REPOSITORY)
    private serviceRepository: Repository<Service>,
  ) {}

  async findAll(user: User, query): Promise<Response<Service>> {
    const _page = query.page || 1;
    const _size = query.size || 10;
    const _search = query.search || '';
    console.log('query', query);

    // sorting can be massively improved, but it requires more time to invest in it
    const _sort = () => {
      if (!query.sort) {
        return 'name DESC';
      }

      if (query.sort.startsWith('-')) {
        return `${query.sort.substring(1)} DESC`;
      }
      return `${query.sort} ASC`;
    };

    const total = await this.serviceRepository.query(
      `
    select 
      count(*) as total
    from 
      services s
    where 
      s.organization_id = $1
      and (s.name ilike $2 or s.description ilike $2)`,
      [user.organization_id, `%${_search}%`],
    );

    const items = await this.serviceRepository.query(
      `
    select 
      s.id as id,
      s.name as name,
      s.description as description,
      s.created_at as created_at,
      s.updated_at as updated_at,
      count(v.id) as versionsCount
    from 
      services s,
      versions v
    where 
      s.organization_id = $1
      and s.id = v.service_id 
      and (s.name ilike $2 or s.description ilike $2)
      group by v.service_id, s.name, s.description, s.created_at, s.updated_at, s.id
      order by ${_sort()}
      limit $3 offset $4
        `,
      [user.organization_id, `%${_search}%`, _size, (_page - 1) * _size],
    );

    /* 
      sort didn't work as expected, so I embeded into the query.
      this kind of embeding is not recommended for security conserns, but i need it to finish the task.
    */

    return {
      total,
      items,
    };
  }

  const random = Math.floor(Math.random() * 1000000);

  async findById(id: string, user: User): Promise<Service> {
    return this.serviceRepository
      .createQueryBuilder('services')
      .leftJoin('services.versions', 'versions')
      .select([
        'services.id',
        'services.organization_id',
        'services.name',
        'services.description',
        'services.created_at',
        'services.updated_at',
        'versions.id',
        'versions.version',
      ])
      .where(
        'services.id = :id AND services.organization_id = :organization_id',
        {
          id,
          organization_id: user.organization_id,
        },
      )
      .getOne();
  }

  async findServiceVersions(
    id: string,
    versionId: string,
    user: User,
  ): Promise<Service> {
    return this.serviceRepository
      .createQueryBuilder('services')
      .leftJoinAndMapMany('services.versions', 'services.versions', 'versions')
      .where(
        'services.id = :id AND versions.id = :versionId AND services.organization_id = :organization_id',
        {
          id,
          versionId,
          organization_id: user.organization_id,
        },
      )
      .getOne();
  }
}
