import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat_buble.dart';

import 'app.service.dart';
import 'package:provider/provider.dart';
import 'message.dart';



//durumu değişebilen (stateful) widget'lardır. Yani içerdikleri veri veya durum zamanla değişebilir.
// Bu tür widget'lar, kullanıcı girdisi, zaman, 
//dış veri kaynakları vb. gibi dinamik verileri işlemek ve bu verilere göre arayüzü güncellemek için kullanılır.
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key }):super(key: key);

 // createState -->Stateful widget'larla çalışır
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final appService=context.read<AppService>();
 final _formKey = GlobalKey<FormState>();
 // kullanıcının metin alanlarına girilen verileri yönetmek için kullanılır. 
  final _msgController = TextEditingController();

//bellek sızıntılarını önlemek ve gereksiz kaynak kullanımını önlemek için önemlidir.
  @override 
  void dispose(){
    _msgController.dispose();
    super.dispose();
  }

Future<void> _submit(AppService appService) async{
final yazi=_msgController.text;
if(yazi.isEmpty){
  return;
}
if(_formKey.currentState!=null&& _formKey.currentState!.validate()){
  _formKey.currentState!.save();
  await appService.saveMessage(yazi);
  _msgController.text='';

}
}


// uygulamanın tasarımını tanımlar 
    return Scaffold(
      appBar: AppBar(
        title:  Text("Konuşma Odası"),
      ),
      body: StreamBuilder<List<Message>>(
stream: appService.getMessages(),
builder: (context,snapshot)
{
  if(snapshot.hasData){
  final messages=snapshot.data!;

  // margin ile EdgeInsets aynı işlemi sağlar.
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Expanded(child: ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: ((context, index) {
              final message = messages[index];
                        return ChatBubble(message: message);
          }
        )
        )
          ),
          SafeArea(child: Padding(

            padding: const EdgeInsets.all(8.0),
            child: Form( 
            key: _formKey,
            child: TextFormField(
              controller: _msgController,
              decoration: InputDecoration(
                labelText: 'Mesaj',
                suffixIcon: IconButton(
                  onPressed: ()=>_submit(appService),
                  icon: const Icon(
                    Icons.send_rounded,
                    color:Colors.blueGrey,

                  ),
                )
              ),            ),
            ),
          )
          ),
          const SizedBox(height: 40.0,)
      ],
    ),

    );
  }
  return const Center(
    child: CircularProgressIndicator(),
  );
},
      ),
    );
  }
}