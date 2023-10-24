
/*
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:supabase/supabase.dart';

class Konum extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  


  
}

class _HomePageState extends State<Konum> {
late String _currentAddress="";
   Position? _anKonum;
/*//supabase bağlantısı...
  final _supabase = Supabase.instance.client;
  final   _password = 'asnh!ASsdlz235';
// otomatik test kullanıcı oluşturmak.
  Future<void> _createUser(int i) async {
     final response = await _supabase.auth.signUp(
    email: 'test_$i@test.com',
    password: _password,
  ); */

  final supabase = SupabaseClient(
  'https://fxpttbodygotxogiyvde.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ4cHR0Ym9keWdvdHhvZ2l5dmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEzMzY2ODIsImV4cCI6MjAwNjkxMjY4Mn0.X12vS0eX0t-wZjjfQyGIQUwzXiA1_p-2zGfluMc27NI',
);


   // kullanıcıların server üzerinden bilgilerini almak.
   List<Map<String, dynamic>> _userLocations = []; 

//kullanıcıların databaseden kontrol edilmesi
    Future<void> getUserLocationsFromSupabase() async {
  final response = await supabase.from('konum').select('*');

  if (response.error != null) {
    print('Hata: ${response.error!.message}');
  } else {
    _userLocations = response.data as List<Map<String, dynamic>>;
    print('Kullanıcı konumları alındı: $_userLocations');
  }
}
// kullanıcının 200 metre çapında olup olmaması kontrolü
void checkUserLocationsInRadius(Position center, double radius) {
  for (var userLocation in _userLocations) {
     double latitude = userLocation['latitude'];
    double longitude = userLocation['longitude'];
    double distance = Geolocator.distanceBetween(
      center.latitude, center.longitude,
     latitude, longitude
    );

    if (distance <= radius) {
      print('${userLocation['name']} is within the radius.');
      // Burada istediğiniz işlemleri yapabilirsiniz.
    }
  }
}



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
            if(_currentAddress.isNotEmpty)Text('Enlem: ${_anKonum?.latitude }'),
              Text('Boylam: ${_anKonum?.longitude}'),
              Text('Adresi: ${_currentAddress}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: getLokasyon,
                child: const Text("Anlik Konumu bul 8")
            
            ),

            if(_anKonum != null)Text("Enlem ${_anKonum!.latitude}, Boylam: ${_anKonum!.longitude}"),
            TextButton (
              child: Text("Anlik Konum"),
              onPressed: () {
                  getLokasyon();
                  
              },
            ),
          ],
        ),
      ),
    );
  }
   getLokasyon() {
    Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true)
      .then((Position position) {
        setState(() {
          _anKonum = position;
      
          
            checkUserLocationsInRadius(_anKonum!, 200); // 200 metrelik çap
        });
      }).catchError((e) {
        print(e);
      });
  }

  void processUserLocation(Position userPosition) async {
  await getUserLocationsFromSupabase();
  checkUserLocationsInRadius(userPosition, 200); // Örnek olarak 200 metrelik bir çap
}

  
}
  */
  