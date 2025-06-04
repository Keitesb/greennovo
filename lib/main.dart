// main.dart
import 'package:flutter/material.dart';
import 'package:greennovo/providers/auth_provider.dart';
import 'package:greennovo/providers/supplier_home_controller.dart';
import 'package:greennovo/providers/vendor_order_provider.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/cart_controller.dart';
import 'package:greennovo/providers/product_controller.dart';
import 'package:greennovo/views/auth/login_screen.dart';
import 'package:greennovo/views/main_app_screen.dart';
import 'package:greennovo/providers/order_provider.dart';
import 'package:greennovo/providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => SupplierHomeController()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => VendorOrderProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GreenNovo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authController, child) {
            return authController.isAuthenticated
                ? const MainAppScreen()
                :  LoginScreen();
          },
        ),
      ),
    );
  }
}