import 'package:flutter/material.dart';
import 'package:trialapp/screens/location.dart';
import 'package:trialapp/screens/location_screen.dart';
import 'screens/history/custom.dart';
import 'screens/signin.dart';
import 'screens/welcomescreen/welcomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.cyan[900],
        accentColor: Colors.green[400],
      ),
      home: WelcomeScreen(),
      initialRoute: '/',
      routes: {
        LocationScreen.routeName: (ctx) => LocationScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        CustomDatabase.routeName: (ctx) => CustomDatabase(),
        Location.routeName: (ctx) => Location(),
      },
    );
  }
}
