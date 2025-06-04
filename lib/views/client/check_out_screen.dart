import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/cart_controller.dart';
import 'package:greennovo/providers/auth_provider.dart';

class CheckoutScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController contactoController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();
  final TextEditingController metodoPagamentoController = TextEditingController();

  CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Formulário ocupará no máximo 600px, ou 90% da tela se for menor
    final double formWidth =
    screenWidth > 600 ? 600 : screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Concluir Pedido"),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2D722A),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: formWidth,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  _buildInput(
                    "Endereço",
                    "Av. Angola 1568 R/C",
                    enderecoController,
                    Icons.location_on,
                        (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe o endereço";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    "Contacto",
                    "8x xxx xxxx",
                    contactoController,
                    Icons.phone,
                        (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe o contacto";
                      }
                      if (!RegExp(r'^[0-9]{7,11}$')
                          .hasMatch(value.trim())) {
                        return "Contacto inválido";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    "Horário de preferência",
                    "14:30",
                    horarioController,
                    Icons.access_time,
                        (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe o horário";
                      }
                      if (!RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$')
                          .hasMatch(value.trim())) {
                        return "Formato inválido (HH:MM)";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    "Observações",
                    "Ex: Deixar na portaria",
                    observacoesController,
                    Icons.notes,
                        (value) => null,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    "Método de pagamento",
                    "M-Pesa",
                    metodoPagamentoController,
                    Icons.payment,
                        (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe o método de pagamento";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        final cart = Provider.of<CartController>(context,
                            listen: false);
                        if (cart.items.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text("Carrinho vazio. Adicione produtos."),
                            ),
                          );
                          return;
                        }
                        final auth = Provider.of<AuthProvider>(context,
                            listen: false);
                        cart.checkout(
                          customer: auth.currentUser!,
                          notes: observacoesController.text.trim(),
                          paymentMethod:
                          metodoPagamentoController.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Pedido concluído com sucesso!"),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D722A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "Concluir",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
      String label,
      String hint,
      TextEditingController controller,
      IconData icon,
      String? Function(String?) validator, {
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green.shade700),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}