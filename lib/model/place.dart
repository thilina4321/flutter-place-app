import 'dart:io';

class PlaceLocation {
  double latitude;
  double longitude;
  double address;
}

class Place {
  String id;
  String title;
  PlaceLocation location;
  File image;

  Place({this.id, this.title, this.location, this.image});
}
