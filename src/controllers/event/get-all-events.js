import Event from "../../models/event.js";

export const getAllEvents = async (req, res) => {

    try {
        const events = await Event.find()
            .select("title description heroImage subTitle shortDescription price tags durationDays")

        res.status(200).json({
            message: "Events fetched successfully",
            events
        })
    } catch (error) {
        console.log("Something went wrong while getting events", error.message)
        res.status(500).json({
            message: "Something went wrong while getting events",
            error: error.message
        })
    }
}