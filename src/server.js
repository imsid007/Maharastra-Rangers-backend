import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import connectDB from "./config/db.js";

import eventRoutes from "./routes/event-routes.js";
import masterDataRoutes from "./routes/master-data-routes.js";
import pickupLocationRoutes from "./routes/pickup-location-routes.js";

dotenv.config();

connectDB();

const app = express();

app.use(cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type"]
}));
app.use(express.json());

app.get("/", (req, res) => {
    res.send("Backend server is running successfully");
})


/* Event Route */
app.use("/api/events", eventRoutes);

/* Master data route */
app.use("/api/masterData/", masterDataRoutes);

/* Pickup location route */
app.use("/api/pickupLocation", pickupLocationRoutes);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
})