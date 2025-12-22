import PickupLocation from "../../models/pickup-location.js";


export const addPickupLocation = async (req, res) => {

    try {
        const {name, city, isActive} = req.body;
        const location = await PickupLocation.create({name, city, isActive});

        res.status(201 ).json({
            message: "Pickup location added successfully",
            location
        })
    } catch(error) {
        console.log("Something went wrong while adding pickup location", error.message);
        
        res.status(500).json({
            message: "Something went wrong while adding pickup location",
            error: error.message
        })

    }
}       