import express from "express";
import { createEvent } from "../controllers/event/create-event.js";
import { getAllEvents } from "../controllers/event/get-all-events.js";
import { getEvent } from "../controllers/event/get-event.js";
import { updateEvent } from "../controllers/event/update-event.js";
import { deleteEvent } from "../controllers/event/delete-event.js";
import { createMasterData } from "../controllers/masterData/create-master-data.js";

const router = express.Router();

router.post("/create", createEvent);
router.get("/get-all", getAllEvents);
router.get("/get/:id", getEvent);
router.put("/update/:id", updateEvent);
router.delete("/delete/:id", deleteEvent);

export default router;