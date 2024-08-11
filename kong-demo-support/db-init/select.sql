select 
  s.name as service_name,
  v.version as version
 from 
	services s,
	versions v,
where 
  s.name = 'FX Rate'
  s.id = v.service_id
