import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '20s', target: 1000 },
    { duration: '20s', target: 2000 },
    { duration: '20s', target: 3000 },
    { duration: '20s', target: 4000 },
    { duration: '20s', target: 5000 },
    { duration: '20s', target: 6000 },
    { duration: '20s', target: 7000 },
    { duration: '20s', target: 8000 },
    { duration: '20s', target: 9000 },
    { duration: '1m', target: 10000 },
    { duration: '2m', target: 10000 },
    { duration: '1m', target: 0 },
  ],

};

export default function () {
//   curl --location 'http://localhost:3001/api/v1/services?page=1&size=20&orderby=s.name' \
// --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiIzNGM1NmM0MC1kNDdlLTQwYzMtYjUzOS1lNmMzMjVkZWFjZjAiLCJ1c2VybmFtZSI6ImphbmUuZG9lQG1haWwuY29tIn0.jNsh4Kz-wYST_sApwXkuZsgOneOs2EiYs7FgLtB8FR0'
  const res = http.get('http://kong-api-golang:3000/api/v1/services?page=1&size=20&orderby=s.name', {
    headers: {
      Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiIzNGM1NmM0MC1kNDdlLTQwYzMtYjUzOS1lNmMzMjVkZWFjZjAiLCJ1c2VybmFtZSI6ImphbmUuZG9lQG1haWwuY29tIn0.jNsh4Kz-wYST_sApwXkuZsgOneOs2EiYs7FgLtB8FR0',
    },
  });
  check(res, { 'status was 200': (r) => r.status == 200 });
  sleep(1);
}

