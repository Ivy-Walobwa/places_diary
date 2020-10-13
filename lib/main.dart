import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places_provider.dart';
import './screens/places_list_screen.dart';
import './screens/add_places_screen.dart';
import './screens/places_details_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx)=> AddPlaceScreen(),
          PlacesDetailsScreen.routeName: (ctx)=> PlacesDetailsScreen(),
        },
      ),
    );
  }
}

