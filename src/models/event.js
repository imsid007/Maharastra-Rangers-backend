import mongoose from "mongoose";

const eventSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    heroImage: String,
    subTitle: String,
    description: String,
    includes: [{ type: String }],
    exclude: [{ type: String }],
    category: { type: String, required: true },
    itinerary: [
      {
        day: Number,
        title: String,
        details: [
          {
            type: String
          }
        ]
      }
    ],
    thingsToCarry: [
      { type: String }
    ],
    faqs: [{
      question: String,
      answer: String
    }],
    imageGallery: [{ type: String }],
    pickupLocationIds: [{ type: mongoose.Schema.Types.ObjectId, ref: "PickupLocation" }],
    dates: [{
      date: Date,
      totalSeats: { type: Number, default: 0 },
      seatsBooked: { type: Number, default: 0 },
      price: { type: Number, default: 0 }
    }],
    price: Number,
    tags: [{ type: String }],
    durationDays: Number,
    published: {
      type: Boolean,
      default: false,
    }
  },
  { timestamps: true }
);

const Event = mongoose.model("AdventureRecords", eventSchema);

export default Event;
