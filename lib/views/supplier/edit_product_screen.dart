import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/models/product_model.dart';
import 'package:greennovo/providers/product_controller.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late String _selectedCategory;
  String? _imagePath; // Para futura integração com pickers

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.price.toStringAsFixed(2));
    _selectedCategory = widget.product.category;
    _imagePath = null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _pickImage() {
    // TODO: implementar integração real de seleção de imagem
    // Por enquanto, mockamos um caminho estático ou deixamos vazio
    setState(() {
      _imagePath = 'assets/images/placeholder.png';
    });
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
      final category = _selectedCategory;

      final updated = Product(
        id: widget.product.id,
        name: name,
        price: price,
        category: category,
      );

      Provider.of<ProductController>(context, listen: false)
          .updateProduct(updated);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allCategories =
    Provider.of<ProductController>(context, listen: false).getCategories();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Editar Produto',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Card principal
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Imagem e nome/preço
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Placeholder de imagem
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                                image: _imagePath != null
                                    ? DecorationImage(
                                    image: AssetImage(_imagePath!),
                                    fit: BoxFit.cover)
                                    : null,
                              ),
                              child: _imagePath == null
                                  ? const Icon(Icons.image, size: 40, color: Colors.grey)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Nome e preço
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                TextFormField(
                                  controller: _nameController,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Informe um nome';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Preço (MTS):',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                TextFormField(
                                  controller: _priceController,
                                  keyboardType:
                                  const TextInputType.numberWithOptions(decimal: true),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Informe um preço';
                                    }
                                    if (double.tryParse(v.trim()) == null) {
                                      return 'Valor inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Categoria (dropdown)
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            'Categoria:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              items: allCategories
                                  .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c),
                              ))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() {
                                    _selectedCategory = v;
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Escolha uma categoria';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Espaçamento inferior
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Botão Salvar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveChanges,
                  icon: const Icon(Icons.save, size: 20),
                  label: const Text(
                    'Salvar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}