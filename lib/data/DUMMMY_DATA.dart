
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
  final DateTime added;

  TouristSite({
    required this.name,
    required this.rating,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.added,
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
          "https://i.natgeofe.com/n/535f3cba-f8bb-4df2-b0c5-aaca16e9ff31/giza-plateau-pyramids.jpg?w=374&h=249",
      added: DateTime.now()),
  TouristSite(
      name: 'The Sphinx',
      rating: 4.3,
      description:
          'The Sphinx is a mythical creature with the head of a human and the body of a lion. It is located near the Pyramids of Giza and is one of the most famous landmarks in Egypt.',
      category: ['Historical Landmark', 'Monument'],
      imageUrl:
          'https://bpb-us-e1.wpmucdn.com/sites.psu.edu/dist/1/9283/files/2014/03/Great_Sphinx_of_Giza_-_20080716a.jpg',
      added: DateTime.now()),
  TouristSite(
      name: 'The Egyptian Museum',
      rating: 4.5,
      description:
          'The Egyptian Museum is located in Cairo and is home to one of the largest collections of ancient Egyptian artifacts in the world.',
      category: ['Museum', 'Historical Landmark'],
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg',
      added: DateTime.now()),
  TouristSite(
      name: 'Karnak Temple Complex',
      rating: 4.0,
      description:
          'The Karnak Temple Complex is located in Luxor and is one of the largest temple complexes in the world. It was built over a period of 2000 years by many different pharaohs.',
      category: ['Historical Landmark', 'Temple'],
      imageUrl:
          'http://3.bp.blogspot.com/-Gwh8OoxnByQ/UW0MrPlslpI/AAAAAAAAOR4/2qlS5YFU2bQ/s1600/Karnak+Temple+(3).jpg',
      added: DateTime.now()),
  TouristSite(
      name: 'Abu Simbel Temples',
      rating: 4.5,
      description:
          'The Abu Simbel Temples are two massive rock temples located in Nubia, southern Egypt. They were built during the reign of Pharaoh Ramesses II in the 13th century BC.',
      category: ['Historical Landmark', 'Temple'],
      imageUrl:
          'https://th.bing.com/th/id/R.4bf6e801846af53d5088c7af0d2d9b96?rik=1nXEY38t6W8IUg&riu=http%3a%2f%2ffamouswonders.com%2fwp-content%2fuploads%2f2009%2f04%2fabu-simbel.jpg&ehk=mWpevgWXHChk%2f9uaI1XVg9gw2lRU8TtlI4E5EDDRv2I%3d&risl=&pid=ImgRaw&r=0',
      added: DateTime.now()),
  TouristSite(
      name: "Valley of the Kings",
      rating: 4.3,
      description:
          "The Valley of the Kings is located near Luxor and is home to many tombs of pharaohs from the New Kingdom period.",
      category: ["Historical Landmark", "Tomb"],
      imageUrl:
          "https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg",
      added: DateTime.now()),
  TouristSite(
      name: "Luxor Temple",
      rating: 4.0,
      description:
          "Luxor Temple is located in Luxor and was built during the New Kingdom period.",
      category: ["Historical Landmark", "Temple"],
      imageUrl:
          "https://cdn.pixabay.com/photo/2017/01/28/02/24/museum-2019132_960_720.jpg",
      added: DateTime.now()),
];
