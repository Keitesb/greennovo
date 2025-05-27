// views/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:greennovo/views/main_app_screen.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/controllers/auth_controller.dart';
import 'package:greennovo/models/user_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userType = ValueNotifier<String>('client');

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira seu email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<String>(
                valueListenable: _userType,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: 'client',
                        groupValue: value,
                        onChanged: (newValue) {
                          _userType.value = newValue!;
                        },
                      ),
                      const Text('Cliente'),
                      Radio<String>(
                        value: 'supplier',
                        groupValue: value,
                        onChanged: (newValue) {
                          _userType.value = newValue!;
                        },
                      ),
                      const Text('Fornecedor'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulando login bem-sucedido
                    final user = User(
                      id: '1234',
                      name: 'Keite',
                      email: _emailController.text,
                      type: _userType.value,
                    );
                    authController.login(user);

                    // Navega para a tela principal apropriada
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainAppScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}