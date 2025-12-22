import mongoose from "mongoose";

const eventSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    heroImage: String,
    subTitle: String,
    shortDescription: String,
    description: String,
    includes: [{type: String}],
    exclude: [{type: String}],
    itinerary: [
      {
        day: Number,
        title: String,
        details: String
      }
    ],
    faqs: [{
      question: String,
      answer: String,
      isCommon: {type: Boolean, default: false},
    }],
    imageGallery: [{type: String}],
    pickupLocationIds: [{type: mongoose.Schema.Types.ObjectId, ref: "PickupLocation"}],
    dates: [{
      date: Date,
      totalSeats: {type: Number, default: 0},
      seatsBooked: {type: Number, default: 0},
      price: {type: Number, default: 0}
    }],
    price: Number,
    tags: [{type: String}],
    durationDays: Number,
    createdBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Admin",
      required: true,
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
    published: {
      type: Boolean,
      default: false,
    }
  },
  { timestamps: true }
);

const Event = mongoose.model("AdventureRecords", eventSchema);

export default Event;
