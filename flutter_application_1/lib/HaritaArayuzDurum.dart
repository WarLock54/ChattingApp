import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Konum_Saglayici.dart';
import 'package:flutter_application_1/Konum_Service.dart';
import 'package:flutter_application_1/konum.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'HaritaArayuz.dart';

class HaritaArayuzDurum extends State<HaritaArayuz> {
 late Position position;
late  GoogleMapController haritaKontroller;
  Completer<GoogleMapController> kontrol=Completer();
late  LatLng lastposition;
   final Set<Marker> isaretler={};
   
   @override 
   void dispose(){
    KonumServis().konumKapat();
    super.dispose();

   }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, KonumSaglayici provider, _) {
      if (provider.konumDurum == KonumSaglayiciDurum.Yukleniyor ||
          provider.konumDurum == KonumSaglayiciDurum.Ilk) {
        return Center(child: CircularProgressIndicator());
      } else if (provider.konumDurum == KonumSaglayiciDurum.Basarili) {
        var locationProvider = Provider.of<Konum>(context);

        CameraPosition initialCameraPosition = CameraPosition(
            zoom: cameraZoom,
            target:
                LatLng(locationProvider.enlem, locationProvider.boylam));

        HaritaGorunumu(
            lat: locationProvider.enlem, lng: locationProvider.boylam);

        return Stack(children: [
          GoogleMap(
            markers: isaretler,
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              kontrol.complete(controller);

              isaretler.add(olusturIsaret(
                  locationProvider.enlem, locationProvider.boylam));
            },
          ),
        ]);
      } else {
        return Center(child: Text("We can't reach your location"));
      }
    }));
    
  }
  void HaritaGorunumu({double lat=0.0, double lng=0.0}) async {
    CameraPosition cPosition = CameraPosition(
      zoom: cameraZoom,
      target: LatLng(lat, lng),
    );
    final GoogleMapController controller = await kontrol.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }
  Marker olusturIsaret(double lat, double lng) {
    return Marker(
      markerId: MarkerId('<MARKER_ID>'),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
title: "Gittiğin yerde ruh ikizini bulabilirsin.",
      ),
      draggable: false,
    );
  }
}
