import Event from "../../models/event.js";

export const getEvent = async (req, res) => {
    try {
        const {id} = req.params;
        const event = await Event.findById(id);

        if(!event) {
            return res.status(404).json({
                message: "Event not found"
            })
        }

        res.status(200).json({
            message: "Event fetched successfully",
            event
        })
    } catch (error) {
        console.log("Something went wrong while getting event", error.message)
        res.status(400).json({
            message: "Something went wrong while getting event",
            error: error.message
        })
    }
}