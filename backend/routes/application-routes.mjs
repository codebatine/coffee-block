import express from 'express';

import {
  listApplications,
  createApplicationInfo,
  updateApplicationStatus,
  listApplication,
  updateApplication,
} from '../controllers/application-contoller.mjs';

export const applicationRouter = express.Router();

applicationRouter.route('/').get(listApplications);
applicationRouter.route('/submit').post(createApplicationInfo);
applicationRouter.route('/change/:id').put(updateApplication);
applicationRouter.route('/application/:id').get(listApplication);
applicationRouter.route('/publish/:id').patch(updateApplicationStatus);
