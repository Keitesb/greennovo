// lib/views/supplier/order_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/vendor_order_provider.dart';
import '../../models/order_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    final order = context.read<VendorOrderProvider>().getOrderById(widget.orderId);
    _selectedStatus = _mapStatusToDropdown(order?.status ?? 'pending');
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<VendorOrderProvider>();
    final order = orderProvider.getOrderById(widget.orderId);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes da encomenda')),
        body: const Center(child: Text('Encomenda não encontrada.')),
      );
    }

    final dateFormat = DateFormat('dd/MM/yyyy');
    final formattedDate = dateFormat.format(order.date);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Detalhes da encomenda'),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        _row('Pedido:', order.id),
                        _row('Cliente:', order.customer.name),
                        _row('Data:', formattedDate),
                        _row('Endereço:', order.customer.address),
                        _row('Contacto:', order.customer.phone),
                        if (order.notes.isNotEmpty)
                          _row('Observações:', order.notes),
                        _row('Método de pagamento:', order.paymentMethod),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('Total', style: TextStyle(color: Colors.grey)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Text('MZN', style: TextStyle(color: Colors.grey)),
                                  const SizedBox(width: 8),
                                  Text(
                                    order.total.toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mudar estado',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        _StatusDropdown(
                          value: _selectedStatus,
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27632A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    orderProvider.updateVendorOrderStatus(
                      order.id,
                      _mapDropdownToStatus(_selectedStatus),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Submeter',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 38,
        color: const Color(0xFFA6D86D),
        alignment: Alignment.center,
        child: Container(
          width: 60,
          height: 3,
          color: Colors.white,
        ),
      ),
    );
  }

  TableRow _row(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _mapStatusToDropdown(String status) {
    switch (status) {
      case 'pending':
        return 'Pendente';
      case 'preparing':
        return 'Pronto';
      case 'shipped':
        return 'Enviado';
      case 'delivered':
        return 'Entregue';
      default:
        return 'Pendente';
    }
  }

  String _mapDropdownToStatus(String value) {
    switch (value) {
      case 'Pendente':
        return 'pending';
      case 'Pronto':
        return 'preparing';
      case 'Enviado':
        return 'shipped';
      case 'Entregue':
        return 'delivered';
      default:
        return 'pending';
    }
  }
}

class _StatusDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  const _StatusDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: const [
        DropdownMenuItem(child: Text('Pendente'), value: 'Pendente'),
        DropdownMenuItem(child: Text('Pronto'), value: 'Pronto'),
        DropdownMenuItem(child: Text('Enviado'), value: 'Enviado'),
        DropdownMenuItem(child: Text('Entregue'), value: 'Entregue'),
      ],
      onChanged: onChanged,
      underline: const SizedBox(),
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      dropdownColor: const Color(0xFFA6D86D),
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF27632A)),
      selectedItemBuilder: (context) {
        return ['Pendente', 'Pronto', 'Enviado', 'Entregue'].map((status) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFA6D86D),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 7),
            child: Text(
              status,
              style: const TextStyle(
                color: Color(0xFF27632A),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}