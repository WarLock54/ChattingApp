import 'package:flutter/material.dart';
import 'package:flutter_application_1/Konum_Service.dart';
import 'konum.dart';
enum KonumSaglayiciDurum{
Ilk,
Yukleniyor,
Basarili,
Hata
}
class KonumSaglayici extends ChangeNotifier {
  late Konum _konum;
  KonumServis konumServis=KonumServis();
 final  KonumSaglayiciDurum _konumDurum= KonumSaglayiciDurum.Ilk;
 // dışarıdan okunabilmesini sağlar.
 Konum get konum=>_konum;
 KonumSaglayiciDurum get konumDurum=>_konumDurum;

Future<void> getLokasyon() async{
  try{
 GuncelleDurum(KonumSaglayiciDurum.Basarili);
 _konum=await konumServis.getSimdikiKonum();
  GuncelleDurum(KonumSaglayiciDurum.Hata);
  }
  catch(e){
    print(e);
   GuncelleDurum(KonumSaglayiciDurum.Hata);
  }
}
void GuncelleDurum(KonumSaglayiciDurum durum)async{
if(konumDurum!=durum){
  konumDurum==durum;
  notifyListeners();
}
}
}