import express from 'express';

import {
  listApplications,
  addApplicationInfo,
  updateApplicationStatus,
} from '../controllers/application-contoller.mjs';

export const applicationRouter = express.Router();

applicationRouter.route('/').get(listApplications);
applicationRouter.route('/submit').post(addApplicationInfo);
applicationRouter.route('/publish/:id').patch(updateApplicationStatus);
