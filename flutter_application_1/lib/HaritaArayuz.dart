import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Konum_Saglayici.dart';
import 'package:flutter_application_1/Konum_Service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'konum.dart';

const double cameraZoom = 15;
const double cameraTilt = 50;
const double cameraBearing = 30;

class HaritaArayuz extends StatefulWidget {
  const HaritaArayuz({super.key});

  @override
  State<HaritaArayuz> createState() => _HaritaArayuzState();
}

class _HaritaArayuzState extends State<HaritaArayuz> {

  Position? position;
 GoogleMapController?  haritaKontrol;
   Completer<GoogleMapController> kontrol = Completer();
   @override
   void dispose() {
    KonumServis().konumKapat();
    super.dispose();
  }
 
 


  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Consumer(builder: (context,KonumSaglayici saglayici,_){
              if(saglayici.konumDurum==KonumSaglayiciDurum.Yukleniyor||saglayici.konumDurum==KonumSaglayiciDurum.Ilk){
                //kullanıcılara bir işlem gerçekleştirildiğini ve sonucun bekleniyor 
return Center(child: CircularProgressIndicator());
              }
              else if(saglayici.konumDurum==KonumSaglayiciDurum.Basarili){
                var KonumSaglayici=Provider.of<Konum>(context);
                CameraPosition kameraPozisyon=CameraPosition(
                  zoom: cameraZoom,
                  target: 
                  LatLng(KonumSaglayici.enlem,KonumSaglayici.boylam)
                );
           

              // iç içe widgetları sırayla koyabilirsin.
              return Stack(
                children: [
GoogleMap(initialCameraPosition:kameraPozisyon,
  myLocationButtonEnabled: true,
  mapToolbarEnabled:  true,
  mapType: MapType.normal,
  myLocationEnabled: true,
  onMapCreated: (GoogleMapController _kontrol){
kontrol.complete(_kontrol);
                },
                 ),
                ]
                );
                  }
   else{
    return Center(child: Text("Konumuna uluşılamıyor."));
   }
            }
            ),
               );
  }
}
