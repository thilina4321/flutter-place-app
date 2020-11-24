import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gtplace/helper/db_helper.dart';
import 'package:gtplace/model/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  addPlace(title, image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: null);

    _places.add(newPlace);

    notifyListeners();
    DBHelper.insert({
      'id': newPlace.id,
      'image': newPlace.image.path,
      'title': newPlace.title,
      'location': newPlace.location
    });
  }

  Future<void> fetchAndSetData() async {
    try {
      final placesList = await DBHelper.get();
      _places = placesList
          .map(
            (e) => Place(
              id: e['id'].toString(),
              title: e['title'],
              image: File(e['image']),
              location: null,
            ),
          )
          .toList();
      notifyListeners();
    } catch (e) {
      print('there is an error');
      print(e);
      throw e;
    }
  }

  Future<void> deleteData(id) async {
    int dataId = int.parse(id);
    try {
      await DBHelper.delete(id);
      _places.removeWhere((place) => place.id == id);
      print('object');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
