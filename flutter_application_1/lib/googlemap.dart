

/*
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
  class GoogleMap extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GoogleMap> {
Position? _anKonum;


   Location location = Location();
    
 StreamSubscription<LocationData>? _locationSubscription;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konum"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: [
                  Image.network(
                     'https://maps.googleapis.com/maps/api/staticmap?center=${_anKonum?.latitude},${_anKonum?.longitude}&zoom=12&size=300x300&key=YOUR_API_KEY',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  // You can add additional widgets here, such as markers or overlays
                ],
              ),
            ),
            if(_anKonum != null)Text("Enlem ${_anKonum!.latitude}, Boylam: ${_anKonum!.longitude}"),
            TextButton (
              child: Text("Anlik Konum Sonnnn"),
              onPressed: () {
                  getLokasyon();
                  
              },
            ),
          ],
        ),
      ),
    );
  }
  void _startLocationTracking() {
  _locationSubscription =
      location.onLocationChanged.listen((LocationData currentLocation) {
    print(currentLocation.latitude); // Enlem
    print(currentLocation.longitude); // Boylam
  });
}

void _stopLocationTracking() {
  _locationSubscription?.cancel();
  _locationSubscription = null;
}
  Future<void> _getLocationPermission() async {
  var permission = await location.requestPermission();
  if (permission != PermissionStatus.granted) {
    // Kullanıcı izni vermedi
  }
}
 Future<void> _getCurrentLocation() async {
  var currentLocation = await location.getLocation();
  print(currentLocation.latitude); // Enlem
  print(currentLocation.longitude); // Boylam
}
  getLokasyon() {
    Geolocator
      .getCurrentPosition()
      .then((Position position) {
        setState(() {
          _anKonum = position;
         
          
        });
      }).catchError((e) {
        print(e);
      });
  }
}
  */