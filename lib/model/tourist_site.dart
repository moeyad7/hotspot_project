class TouristSite {
  final String id;
  final String title;
  final String description;
  final double rating;
  final List<String> category;
  final String imageUrl;
  final DateTime added;

  TouristSite({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.added,
    this.rating = 0.0,
  });
}