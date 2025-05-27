// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/controllers/auth_controller.dart';
import 'package:greennovo/controllers/cart_controller.dart';
import 'package:greennovo/controllers/product_controller.dart';
import 'package:greennovo/views/auth/login_screen.dart';
import 'package:greennovo/views/main_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GreenNovo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Consumer<AuthController>(
          builder: (context, authController, child) {
            return authController.isLoggedIn
                ? const MainAppScreen()
                :  LoginScreen();
          },
        ),
      ),
    );
  }
}