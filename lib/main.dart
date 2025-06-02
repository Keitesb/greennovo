import 'package:flutter/material.dart';
import 'package:greennovo/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/controllers/auth_controller.dart';
import 'package:greennovo/controllers/cart_controller.dart';
import 'package:greennovo/controllers/product_controller.dart';
import 'package:greennovo/views/auth/login.dart';
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
        // Defina as rotas nomeadas
        routes: {
          '/': (context) => const AuthWrapper(),
          '/main': (context) => const MainAppScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return authController.isLoggedIn
        ? const MainAppScreen()
        : SplashScreen();
  }
}