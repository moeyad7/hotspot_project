import 'package:flutter/material.dart';


class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}

class TouristSite {
  final String name;
  final double rating;
  final String description;
  final List<String> category;
  final String imageUrl;

  TouristSite({
    required this.name,
    required this.rating,
    required this.description,
    required this.category,
    required this.imageUrl,
  });
}

final List<TouristSite> touristSites = [
    TouristSite(
      name: 'The Pyramids of Giza',
      rating: 4.8,
      description:
          'The Pyramids of Giza are one of the most famous landmarks in Egypt and the world. They are located on the outskirts of Cairo and are the only remaining wonder of the ancient world.',
      category: ['Historical Landmark', 'Monument'],
      imageUrl:
        "https://cdn.pixabay.com/photo/2016/09/08/21/09/pyramids-1654439_960_720.jpg",
    ),
    TouristSite(
      name: 'The Sphinx',
      rating: 4.3,
      description:
          'The Sphinx is a mythical creature with the head of a human and the body of a lion. It is located near the Pyramids of Giza and is one of the most famous landmarks in Egypt.',
      category: ['Historical Landmark', 'Monument'],
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/21/09/pyramids-1654439_960_720.jpg',
    ),
    TouristSite(
      name: 'The Egyptian Museum',
      rating: 4.5,
      description:
          'The Egyptian Museum is located in Cairo and is home to one of the largest collections of ancient Egyptian artifacts in the world.',
      category: ['Museum', 'Historical Landmark'],
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg',
    ),
    TouristSite(
      name: 'Karnak Temple Complex',
      rating: 4.0,
      description:
          'The Karnak Temple Complex is located in Luxor and is one of the largest temple complexes in the world. It was built over a period of 2000 years by many different pharaohs.',
      category: ['Historical Landmark', 'Temple'],
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg',
    ),
    TouristSite(
      name: 'Abu Simbel Temples',
      rating: 4.5,
      description:
          'The Abu Simbel Temples are two massive rock temples located in Nubia, southern Egypt. They were built during the reign of Pharaoh Ramesses II in the 13th century BC.',
      category: ['Historical Landmark', 'Temple'],
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/21/09/pyramids-1654439_960_720.jpg',
    ),
    TouristSite(
        name: "Valley of the Kings",
        rating :4.3 ,
        description : "The Valley of the Kings is located near Luxor and is home to many tombs of pharaohs from the New Kingdom period.",
        category : ["Historical Landmark", "Tomb"],
        imageUrl : "https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg",
    ),
    TouristSite(
        name : "Luxor Temple",
        rating :4.0 ,
        description : "Luxor Temple is located in Luxor and was built during the New Kingdom period.",
        category : ["Historical Landmark","Temple"],
        imageUrl : "https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg",
    ),
  ];