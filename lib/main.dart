import 'package:flutter/material.dart';
import 'package:gtplace/provider/place_provider.dart';
import 'package:gtplace/screen/add_place.dart';
import 'package:gtplace/screen/place_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlaceProvider(),
      child: MaterialApp(
        home: PlaceListScreen(),
        routes: {AddPlaceScreen.routeName: (ctx) => AddPlaceScreen()},
      ),
    );
  }
}
