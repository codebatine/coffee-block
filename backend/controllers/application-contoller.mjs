import { v4 as uuidv4 } from 'uuid';
import applications from '../data/applications.json' with {type: "json"}
import { writeFile } from '../utilities/fileHandlers.mjs';

const folder = "data";
const file = "applications.json"

export const listApplications = (req, res, next) => {
  try {
    res.send(applications);
  } catch (error) {
    console.error('Error reading data', error);
    res.status(500).send('Server error');
  }
};

export const addApplicationInfo = (req, res, next) => {
  const id = uuidv4().replaceAll('-', '');
  req.body.id = id;
  const application = req.body;
  applications.push(application);

  try {
    writeFile(folder, file, applications);
    res.send('Data saved successfully');
  } catch (error) {
    console.error('Error saving data', error);
    res.status(500).send('Server error');
  }
};

export const updateApplicationStatus = (req, res, next) => {
  console.log("update function");
  
  const application = getApplication(req, res, next);

  if (application) {
    application.published = req.body.published ?? application.published;

    fileHandler(folder, file, applications);
    res.status(204).end();
  }
};

const getApplication = (req, res, next) => {
  const application = applications.find((appli) => appli.id === req.params.id);

  if (!application) {
    return next(
      new ErrorResponse(`Kunde inte hitta någon kund med id: ${req.params.id}`)
    );
  }

  return application;
};