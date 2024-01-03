import 'package:pbl6_aircnc/models/property.dart';

var propertyJson = {
  "id": 1,
  "type": "Room",
  "bedCount": 1,
  "bedroomCount": 6,
  "bathroomCount": 3,
  "maxAdultCount": 1,
  "maxChildCount": 7,
  "latitude": 12.421099662780762,
  "longitude": 105.45220184326172,
  "address": "7712 Gislason Lodge",
  "city": "Bắc Ninh",
  "isFavorite": false,
  "hostId": 6,
  "hostName": "Cathrine Windler",
  "rating": 2.833333333333333,
  "numberOfReviews": 4,
  "title": "Amet et aut facilis non dolore labore et.",
  "description":
      "Optio quam dolor voluptas voluptas sint a. Nostrum voluptates et debitis amet. Architecto consequuntur et ab. Quia qui veritatis error vel aut ut quidem nemo.",
  "pricePerNight": 6991000,
  "cleaningFee": 64000,
  "propertyImages": [
    {
      "id": 1,
      "url":
          "https://a0.muscache.com/im/pictures/3efc49b7-d1e6-4267-87ef-3e42b96e81bd.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 2,
      "url":
          "https://a0.muscache.com/im/pictures/b17a98ce-517f-4ca8-9261-0f47b96be6b8.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 3,
      "url":
          "https://a0.muscache.com/im/pictures/0b3e565d-3618-49a9-b11e-82406f94bdcc.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 4,
      "url":
          "https://a0.muscache.com/im/pictures/64927b50-c1fd-4be7-9d4e-47a93ed2afc2.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 5,
      "url":
          "https://a0.muscache.com/im/pictures/0d0f29d6-a55b-42f5-bc95-477afb58741e.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 6,
      "url":
          "https://a0.muscache.com/im/pictures/3efc49b7-d1e6-4267-87ef-3e42b96e81bd.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 7,
      "url":
          "https://a0.muscache.com/im/pictures/b17a98ce-517f-4ca8-9261-0f47b96be6b8.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 8,
      "url":
          "https://a0.muscache.com/im/pictures/0b3e565d-3618-49a9-b11e-82406f94bdcc.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 9,
      "url":
          "https://a0.muscache.com/im/pictures/64927b50-c1fd-4be7-9d4e-47a93ed2afc2.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 10,
      "url":
          "https://a0.muscache.com/im/pictures/0d0f29d6-a55b-42f5-bc95-477afb58741e.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 11,
      "url":
          "https://a0.muscache.com/im/pictures/e9ac58a0-22c4-4094-9fdb-56fe0b1128df.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 12,
      "url":
          "https://a0.muscache.com/im/pictures/bcdc3115-1094-4c75-a7dd-365755b6555f.jpg?im_w=720",
      "propertyId": 1
    },
    {
      "id": 13,
      "url":
          "https://a0.muscache.com/im/pictures/a6a57371-87b0-4e35-a697-788a70f91ebd.jpg?im_w=720",
      "propertyId": 1
    }
  ],
  "propertyUtilities": [],
  "cancellationPolicyType": "Strict",
  "status": "Approved",
  "rejectionReason": null
};

Property propertyTest = Property.fromJson(propertyJson);
