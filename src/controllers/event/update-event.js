import Event from "../../models/event.js";

export const updateEvent = async (req, res) => {
    try {
        const {id} = req.params;
        const event = await Event.findByIdAndUpdate(id, req.body, {new: true});

        if(!event) {
            return res.status(404).json({
                message: "Event not found"
            })
        }

        res.status(200).json({
            message: "Event updated successfully",
            event
        })
    } catch (error) {
        console.log("Something went wrong while updating event", error.message)
        res.status(400).json({
            message: "Something went wrong while updating event",
            error: error.message
        })
    }
}
