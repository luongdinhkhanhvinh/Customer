///////////////////////////////////////////////////////////////////////////////
//
// notification data
//
final mapMarkers = [
  MapMarkers(title: "Le Bouclard", id: "1", lat: 48.888121, lng: 2.329773),
  MapMarkers(title: "Le Sancerre", id: "2", lat: 48.885541, lng: 2.336982),
  MapMarkers(title: "Le Basilic", id: "3", lat: 48.886648, lng: 2.334182),
  MapMarkers(title: "Le Cinq", id: "4", lat: 48.869884, lng: 2.300196),
  MapMarkers(title: "Can Alegria Paris", id: "5", lat: 48.881916, lng: 2.336729),
];

//
//
//
///////////////////////////////////////////////////////////////////////////////


class MapMarkers {
  final String id;
  final String title;
  final double lat;
  final double lng;
  MapMarkers({this.id, this.title, this.lat, this.lng});
}
