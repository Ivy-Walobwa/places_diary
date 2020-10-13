import 'package:flutter/foundation.dart';
import 'dart:io';

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  PlaceModel({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}
