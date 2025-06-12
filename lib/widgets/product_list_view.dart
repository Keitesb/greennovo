import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/cart_controller.dart';
import 'package:greennovo/models/product_model.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRefresh;

  const ProductListView({
    super.key,
    required this.products,
    this.isLoading = false,
    this.error,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    // Tratamento de estados
    if (isLoading ) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null && products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erro: $error'),
            if (onRefresh != null)
              TextButton(
                onPressed: onRefresh,
                child: const Text('Tentar novamente'),
              ),
          ],
        ),
      );

    }

    if (products.isEmpty) {
      return const Center(child: Text('Nenhum produto disponível'));
    }

    // Configuração do grid responsivo
    final crossAxisCount = _calculateCrossAxisCount(screenWidth);

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: GridView.builder(
        padding: const EdgeInsets.all(14.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.90,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(context, product, cartController);
        },
      ),
    );
  }

  int _calculateCrossAxisCount(double screenWidth) {
    if (screenWidth < 600) return 2;
    if (screenWidth < 900) return 3;
    return 4;
  }

  Widget _buildProductCard(
    BuildContext context,
    Product product,
    CartController cartController,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF6FCF97),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Icon(Icons.eco, color: Colors.white, size: 48),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product.price?.toStringAsFixed(2)} MZN',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Botão de adicionar ao carrinho
                _buildAddToCartButton(context, product, cartController),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(
    BuildContext context,
    Product product,
    CartController cartController,
  ) {
    return SizedBox(
      height: 36,
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.add_shopping_cart,
          size: 18,
          color: Colors.white,
        ),
        label: const Text(''),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6FCF97),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: const Size(48, 36),
        ),
        onPressed: () {
          cartController.addToCart(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} adicionado ao carrinho'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
