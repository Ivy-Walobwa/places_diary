import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _getLocationPreview(lat, long) async {
    try {
      final staticImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: lat, longitude: long);
      setState(() {
        _previewImageUrl = staticImageUrl;
      });
    } catch (err){
      return;
    }
  }

  Future<void> _getCurrentLocation() async {
    final location = await Location().getLocation();
    _getLocationPreview(location.latitude, location.longitude);
    widget.onSelectPlace(location.latitude, location.longitude);

  }

  Future<void> _selectPlace() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) =>
            MapScreen(
              isSelecting: true,
            ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }
    _getLocationPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text(
            'No Location provided',
            textAlign: TextAlign.center,
          )
              : Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
              textColor: Theme
                  .of(context)
                  .primaryColor,
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            RaisedButton.icon(
              textColor: Theme
                  .of(context)
                  .primaryColor,
              onPressed: _selectPlace,
              icon: Icon(Icons.map),
              label: Text('Location on Map'),
            )
          ],
        ),
      ],
    );
  }
}
