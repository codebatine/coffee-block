import express from 'express';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import cors from 'cors';
import { applicationRouter } from './routes/application-routes.mjs';

const app = express();
const port = 3001;

const filename = fileURLToPath(import.meta.url);
const dirname = path.dirname(filename);

global.__appdir = dirname;

app.use(express.json());
app.use(cors());

// app.post('/submit', (req, res) => {
// const data = req.body;

// const filePath = path.join(__appdir, 'data', 'data.json');

// fs.writeFile(filePath, JSON.stringify(data, null, 2), (err) => {
//   if (err) {
//     console.log('Error writing to file', err);
//     return res.status(500).send('Server error');
//   }
//   res.send('Data saved successfully');
// });
// });

app.use('/api/v1/applications', applicationRouter);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
