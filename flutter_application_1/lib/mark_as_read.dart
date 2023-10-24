

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.service.dart';
import 'package:provider/provider.dart';

import 'message.dart';

class MarkAsRead extends StatelessWidget {
  final Message message;
  const MarkAsRead({Key? key, required this.message}) : super(key: key);

// okundu olarak işaretlendi.
  final _markOkundu=const Icon(
    Icons.mark_chat_read,
    color: Colors.indigo,
    size: 18.0,
  );

  final _markOkunmadi=const Icon(
    Icons.mark_as_unread,
    color: Colors.grey,
    size: 18.0,
  );
  Future<Widget> _getIsaret(BuildContext context) async{
    if(message.isMine==false){
      if(message.Okundu==false){
        final appService=context.read<AppService>();
        // okundu işareti eklemek...
        await appService.markAsRead(message.Id);
      }
      return const SizedBox.shrink();
    }
    if(message.isMine==true){
      if(message.Okundu==true){
        return _markOkundu;
      }else{
        return _markOkunmadi;
      }
    }
    return const SizedBox.shrink();
  }
  //Widget build -->widget'ın arayüzünü oluşturmak ve döndürmektir.
  //future builder--> çıktısının arayüzünün oluşturur.
//snapshot veri içerip içermediğini kontrol eder.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
future: _getIsaret(context),
builder: (ctx,snapshot){
  if(snapshot.hasData){
    return snapshot.data as Widget;
  }
  return const SizedBox.shrink();
},
    );
  }
}