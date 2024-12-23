import 'package:flutter/material.dart';
import 'package:kiosk_flutter/screen/home_screen.dart';
import 'package:kiosk_flutter/store/cart.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
      ChangeNotifierProvider(create: (context)=>Cart(),
       child:  const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        "/home":(context)=>HomeScreen(),
      },
    );
  }
}
