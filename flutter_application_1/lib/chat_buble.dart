
import 'package:flutter/material.dart';
import 'mark_as_read.dart';
import 'message.dart';

//durumu değişmeyen (stateless) widget'lardır. Yani oluşturulduktan sonra 
//içerdikleri veri veya durum değişmez. Bu tür widget'lar genellikle kullanıcı arayüzünün statik kısımlarını oluştur

class ChatBubble extends StatelessWidget {
 final Message message;

//constructor ı gibi düşünülebilir.
const ChatBubble({Key? key,required this.message }):super(key: key);

  Widget build(BuildContext context) {

var chatContents=[
  const SizedBox(width: 12.0),
  Flexible(child: Container(
padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),
decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(8),
      color:message.isMine? Colors.blueGrey[600]: Colors.indigo[400]
),
child: Text(
message.Konu,
style: const TextStyle(color: Colors.white),
),
  )

  ),
  const SizedBox(width: 12),
  Text(message.OlusturulmaTarih.toString(),
  style: const TextStyle(color: Colors.grey,fontSize: 12)),
   MarkAsRead(message: message),
      const SizedBox(width: 60),
  const SizedBox(width: 60)

];



    return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 18),
    child: Row(
mainAxisAlignment: message.isMine ? MainAxisAlignment.end:MainAxisAlignment.start,
children: chatContents,
    ),
    
    );
  }
}