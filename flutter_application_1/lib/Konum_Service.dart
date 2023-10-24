import 'dart:async';

import 'package:geolocator/geolocator.dart';


import 'konum.dart';

class KonumServis{
  late Konum konum;
 late  Position _kullaniciKonum;
  Geolocator geo=  Geolocator();
   StreamSubscription<Position>? gercekZamanKonum;

StreamController<Konum> _KonumKontrol =
      StreamController<Konum>();
  Stream<Konum> get konumCanli => _KonumKontrol.stream;

KonumServis(){
  gercekZamanKonum=Geolocator.getPositionStream().listen((konum){
    _KonumKontrol.add(Konum(konum.latitude,konum.longitude));
  });
}
void konumKapat(){
 
    gercekZamanKonum!.cancel();
    _KonumKontrol.close();
    gercekZamanKonum=null;
}



Future<Konum> getSimdikiKonum() async{

try{
  var servisOnay=await Geolocator.isLocationServiceEnabled();

  if(!servisOnay){
    servisOnay=await Geolocator.isLocationServiceEnabled();
      if(!servisOnay){
throw Exception("Konum açma izni verildi");
      }
  }
  var onayliMi=await Geolocator.checkPermission();
  if(onayliMi==LocationPermission.denied||
    onayliMi==LocationPermission.deniedForever){
onayliMi=await Geolocator.requestPermission();
    }
    if(onayliMi==LocationPermission.denied||onayliMi==LocationPermission.deniedForever){
      throw Exception("Konum açma izni verilmedi");
    }
  if(servisOnay&& servisOnay==LocationPermission.always||servisOnay==LocationPermission.whileInUse){
    _kullaniciKonum=await Geolocator.getCurrentPosition().timeout(
      Duration(
        days:1 
      ),
      onTimeout: () {
        throw Exception("PREMİNİUM HESABIN YOKSA GÜNDE 1 KERE KULLANABİLİRSİN.");
      },
    );
    konum=Konum(_kullaniciKonum.latitude, _kullaniciKonum.longitude);
    return konum;
  }
  else{
    throw Exception("Konum Serivis onay verilmedi");
  }
  
  }on TimeoutException catch(_){

    // hata yakalanır ama içeriğine ulaşmıyorsun.
print(_);
throw _;
  }
  catch(e){
    print(e);
    throw Exception(e);
  }
  
  
}
}


  /*
  try{
    _kullaniciKonum=await Geolocator.getCurrentPosition();
    konum=Konum(enlem:_kullaniciKonum.latitude, boylam: _kullaniciKonum.longitude);
    return  konum;
  }
  catch(e){
print(e);
throw (e);
  }*/
