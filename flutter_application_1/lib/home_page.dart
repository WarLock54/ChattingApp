import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.service.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

Future<void> _loginUser(AppService appService,int i )async{
  await appService.signIn(i);
  setState(() {
    
  });
}
Future<void> _signOut(AppService appService) async{
await appService.signOut();
setState(() {});
// bu işlemi yaparak her seferinde sayfa güncellemiş olur
}

  @override
  Widget build(BuildContext context) {
    final appServices=context.read<AppService>();

    return Scaffold(
      appBar: AppBar(title: Text(appServices.isAuthentificated()?appServices.getCurrentUserEmail():'Chat'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15.0,),
            ElevatedButton(onPressed: appServices.createUsers, child: Text('Üye ol')),
            const SizedBox(height: 15.0,),
            ElevatedButton(onPressed:()=> _loginUser(appServices,1), child:const  Text('Kullanıcı Giriş')),
            const SizedBox(height: 15.0,),
              ElevatedButton(onPressed:()=> _loginUser(appServices,2), child:const  Text('Kullanıcı Giriş')),
              const SizedBox(height: 15.0,),
               ElevatedButton(onPressed:()=> _signOut(appServices), child:const  Text('Çıkış')),
               const SizedBox(height: 15.0,),
               ElevatedButton(onPressed:()=> Navigator.of(context).pushNamed('/chat'), child:const  Text('Konuşmaya Başla')),
          ],
        ),
      ),
    );
    
  }
}