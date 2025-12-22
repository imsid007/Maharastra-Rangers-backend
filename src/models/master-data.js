import mongoose from "mongoose";

const masterDataSchema = new mongoose.Schema({
    type: {
            type: String,
            enum: ["include", "exclude"], 
            required: true
        },
    title: {
            type: String,
            required: true
        },
    isActive: {
            type: Boolean,
            default: true
        }
})

const MasterData = mongoose.model("MasterData", masterDataSchema);

export default MasterData;  