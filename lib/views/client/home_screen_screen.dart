import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/controllers/product_controller.dart';
import 'package:greennovo/widgets/product_list_view.dart';
import 'package:greennovo/views/client/notification_drawer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final products = productController.getProducts();
    final categories = productController.getCategories();
    final selectedCategory = productController.selectedCategory;

    return Scaffold(
      endDrawer: const NotificationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        elevation: 2,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Green',
                style: TextStyle(color: Colors.green, fontSize: 26, fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: 'Novo',
                style: TextStyle(
                  color: Color(0xFF295309),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.notifications_none_outlined, color: Colors.black87),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquise aqui...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.green[30],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) productController.setCategory(category);
                    },
                    selectedColor: const Color(0xFF6FCF97),
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: ProductListView(products: products)),
        ],
      ),
    );
  }
}