import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';
import '../models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }

  PlaceModel findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final pickedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);

    final newPlace = PlaceModel(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: pickedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_long': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DbHelper.getData('user_places');
    _items = data
        .map(
          (item) => PlaceModel(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              longitude: item['loc_long'],
              latitude: item['loc_lat'],
              address: item['address'],
            ),
          ),
        )
        .toList();
  }
}
