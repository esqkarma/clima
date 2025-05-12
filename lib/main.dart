import 'package:clima/Provider/newsProvider.dart';
import 'package:clima/Provider/weatherDataProvider.dart';
import 'package:clima/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (context)=>WeatherDataProvider() ),
        ChangeNotifierProvider(create: (context)=>NewsProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
