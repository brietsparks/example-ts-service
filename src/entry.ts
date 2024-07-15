import express from 'express';
import { config as configEnv } from 'dotenv';

configEnv();

const port = process.env.PORT;
if (!port) {
  throw new Error('PORT is missing')
}

const exampleVar = process.env.EXAMPLE_VAR;
if (!exampleVar) {
  throw new Error('EXAMPLE_VAR is missing');
}

const server = express();

server.get('/hello/:name', (req, res) => {
  const name = req.params.name;
  res.json({ message: `Hello, ${name}!!@!@!` });
});

server.get('/example', (_, res) => {
  res.json(exampleVar);
});

server.listen(port, () => console.log(`listening on port ${port}`));