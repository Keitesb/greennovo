import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/controllers/cart_controller.dart';

class CheckoutScreen extends StatelessWidget {
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController contactoController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();
  final TextEditingController metodoPagamentoController = TextEditingController();

  CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Concluir pedido"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildInput("Endereço", "Av. Angola 1568 R/C", enderecoController),
            const SizedBox(height: 15),
            _buildInput("Contacto", "8x xxx xxxx", contactoController),
            const SizedBox(height: 15),
            _buildInput("Horário de preferência", "14:30", horarioController),
            const SizedBox(height: 15),
            _buildInput("Observações", "...", observacoesController),
            const SizedBox(height: 15),
            _buildInput("Método de pagamento", "M-Pesa", metodoPagamentoController),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D722A),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final cart = Provider.of<CartController>(context, listen: false);

                if (cart.items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Carrinho vazio. Adicione produtos.")),
                  );
                  return;
                }

                cart.checkout();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pedido concluído com sucesso!")),
                );

                Navigator.pop(context);
              },
              child: const Text(
                "Concluir",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 10,
        color: const Color(0xFFA0CF56), // verde claro
      ),
    );
  }

  Widget _buildInput(String label, String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}