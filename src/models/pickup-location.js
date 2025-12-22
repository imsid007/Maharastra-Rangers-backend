import mongoose from "mongoose";

 const pickupLocation = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    city: {
        type: String
    },
    isActive: {
        type: Boolean,
        default: true
    }
})


const PickupLocation = mongoose.model('PickupLocation', pickupLocation);

export default PickupLocation;