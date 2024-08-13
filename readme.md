## How to run it

1. Run the following command in the terminal, from the root of the project (not )

```bash

docker network create kong-network
docker compose -f kong-demo-support/docker-compose.yml up -d

```

2. Import the Kong collection in Postman
3. "Run Folder" users in Postman
   this will set password for the 2 users,
   generate the JWT token for the 2 users,
   and set the JWT token in the collection variables

4. Manually run the Services folders in postman
