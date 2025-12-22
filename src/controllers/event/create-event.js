import Event from "../../models/event.js";

export const createEvent = async (req, res) => {
  try {
    const event = await Event.create(req.body);

    res.status(201).json({
      message: "Event created successfully",
      event,
    });
  } catch (error) {
    console.log("Something went wrong while creating event", error.message);
    res.status(500).json({
      message: "Something went wrong while creating event",
      error: error.message,
    });
  }
};
