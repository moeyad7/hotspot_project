class TouristSite {
  final String id;
  final String title;
  final String description;
  final List<dynamic> ratings;
  final List<String> category;
  final String imageUrl;
  final DateTime added;

  TouristSite({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.added,
    required this.imageUrl,
    required this.ratings,
  });
}
