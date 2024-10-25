import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:codelab2/home_screen.dart';
import 'package:codelab2/app_color.dart';
import 'package:codelab2/login_screen.dart';
import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppColor appColor = AppColor();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appColor.colorPrimary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: appColor.colorSecondary,
          tertiary: appColor.colorTertiary,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2.0,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        ),
      ),
      home: StreamBuilder(
        stream: _authService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return HomeScreen();
          }

          return LoginScreen();
        },
      ),
    );
  }
}
