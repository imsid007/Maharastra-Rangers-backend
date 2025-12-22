import express from "express";
import { createMasterData } from "../controllers/masterData/create-master-data.js";
import { editMasterData } from "../controllers/masterData/edit-master-data.js";
import { deleteMasterData } from "../controllers/masterData/delete-master-data.js";
import { masterData } from "../controllers/masterData/get-master-data.js";

const router = express.Router();

router.post('/create', createMasterData);
router.put('/edit/:id', editMasterData);
router.delete('/delete/:id', deleteMasterData)
router.get('/get', masterData);

export default router;