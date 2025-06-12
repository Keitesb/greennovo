// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:greennovo/views/supplier/edit_product_screen.dart';
// import 'package:greennovo/views/supplier/supplier_home_screen.dart';
//
// import '../../providers/product_controller.dart';
//
// class ProdutosScreen extends StatelessWidget {
//   const ProdutosScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final productController = Provider.of<ProductController>(context);
//     final products = productController.getProducts();
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: const Text(
//           'Produtos',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black54),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
//             );
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
//             child: Container(
//               height: 45,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: const InputDecoration(
//                         hintText: 'Pesquisar...',
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (query) {
//                         // Implementar filtragem por nome (se desejado)
//                         productController.setCategory(query);
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {
//                       productController.setCategory('');
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.only(bottom: 20),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final produto = products[index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.03),
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       leading: Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF4CAF50).withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.eco,
//                           size: 32,
//                           color: Color(0xFF4CAF50),
//                         ),
//                       ),
//                       title: Text(
//                         produto.name,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text('${produto.price.toStringAsFixed(2)} mts'),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.grey),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => EditProductScreen(
//                                 product: produto,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }