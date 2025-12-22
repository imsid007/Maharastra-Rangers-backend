import express from 'express'
import { addPickupLocation } from '../controllers/pickup-locations/add-ocation.js';
import { updateLocation } from '../controllers/pickup-locations/update-location.js';
import { deleteLocation } from '../controllers/pickup-locations/delete-location.js';
import { getLocation } from '../controllers/pickup-locations/get-loaction.js';
import { getAllLocations } from '../controllers/pickup-locations/get-all-locations.js';


const route = express.Router();

route.post('/add', addPickupLocation);
route.put('/update/:id', updateLocation);
route.delete("/delete/:id", deleteLocation);
route.get("/get/:id", getLocation);     
route.get("/getAll", getAllLocations);

export default route;