import express, { type Request, type Response } from 'express';

const app = express();

app.use(express.json());

app.get('/', (_req:Request, res:Response) => {
  const date = new Date();
  return res.json({
    message: 'Hello World',
    date: date.toISOString(),
  });
});

export default app
