import 'package:flutter/material.dart';
import 'package:flutter_application_1/Konum_Saglayici.dart';
import 'package:flutter_application_1/Konum_Service.dart';
import 'package:provider/provider.dart';

import 'konum.dart';

class GoogleHarita extends StatefulWidget {
  const GoogleHarita({super.key});

  @override
  State<GoogleHarita> createState() => _GoogleHaritaState();
}

class _GoogleHaritaState extends State<GoogleHarita> {

// başlangıç harita kapalı...

@override
void dispose(){
  KonumServis().konumKapat();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
      var konumSaglayici=Provider.of<KonumSaglayici>(context);
      print(konumSaglayici.konum);


    return Scaffold(
      appBar: AppBar(),
      body: StreamProvider<Konum>(
        initialData: konumSaglayici.konum,
        create: (context)=>KonumServis().konumCanli,
        //child: HaritaArayuz,
      ),
    );
  }
}