import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import 'add_places_screen.dart';
import 'places_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<PlacesProvider>(context).fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlacesProvider>(
                  child: Center(
                    child: Text('Got no places yet'),
                  ),
                  builder: (ctx, places, ch) => places.items.length <= 0
                      ? ch
                      : ListView.builder(
                          itemBuilder: (ctx, i) => ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlacesDetailsScreen.routeName,
                                arguments: places.items[i].id,
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                places.items[i].image,
                              ),
                            ),
                            title: Text(
                              places.items[i].title,
                            ),
                            subtitle: Text(places.items[i].location.address),
                          ),
                          itemCount: places.items.length,
                        ),
                ),
        ),
      ),
    );
  }
}
