import 'package:Hotspot/model/tourist_site.dart';

class Arguments {
  final TouristSite touristSite;
  final bool seen;
  final bool saved;
  final double rating;

  Arguments(this.touristSite, this.seen, this.saved, this.rating);
}
