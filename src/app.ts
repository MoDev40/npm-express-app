import express, { type Request, type Response } from 'express';

const app = express();

app.use(express.json());

app.get('/', (_req:Request, res:Response) => {
  const date = new Date();
  return res.json({
    message: 'Hello World',
    data:{
      items:[1,2,3,4,5],
      total:5,
      page:1,
      totalPages:2
    },
    date: date.toISOString(),
  });
});

export default app
