import 'package:flutter/material.dart';
import 'package:flutter_application_1/GoogleHarita.dart';
import 'package:flutter_application_1/app.service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as provider;
import 'HaritaArayuz.dart';
import 'chat_page.dart';
import 'home_page.dart';
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Supabase.initialize(
  url:'https://fxpttbodygotxogiyvde.supabase.co'
,anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ4cHR0Ym9keWdvdHhvZ2l5dmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEzMzY2ODIsImV4cCI6MjAwNjkxMjY4Mn0.X12vS0eX0t-wZjjfQyGIQUwzXiA1_p-2zGfluMc27NI');

  runApp(provider.MultiProvider(providers: [
    provider.ChangeNotifierProvider<AppService>(create: (_)=>AppService(),)
    
  ],
  child: const MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

 
  // This widget is the root of your application.
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
      routes: {
        '/chat': (_) => const ChatPage(),
        '/GoogleHarita':(_)=>const GoogleHarita(),
      },
    );
  }
}


