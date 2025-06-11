// import 'package:flutter/material.dart';

// class OrderPage extends StatefulWidget {
//   const OrderPage({Key? key}) : super(key: key);

//   @override
//   State<OrderPage> createState() => _OrderPageState();
// }

// class _OrderPageState extends State<OrderPage> {
//   final List<Map<String, dynamic>> _orders = [
//     {
//       'orderId': '#ORD001',
//       'date': '2024-03-20',
//       'status': 'Delivered',
//       'total': '\$150.00',
//       'items': 3,
//     },
//     {
//       'orderId': '#ORD002',
//       'date': '2024-03-19',
//       'status': 'Processing',
//       'total': '\$75.50',
//       'items': 2,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Orders'),
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search orders...',
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           color: Colors.grey,
//                         ),
//                         border: InputBorder.none,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.filter_list, color: Colors.grey),
//                     onPressed: () {
//                       // TODO: Implement filter functionality
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: _orders.length,
//         itemBuilder: (context, index) {
//           final order = _orders[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             elevation: 2,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         order['orderId'],
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: order['status'] == 'Delivered'
//                               ? Colors.green.withOpacity(0.1)
//                               : Colors.orange.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           order['status'],
//                           style: TextStyle(
//                             color: order['status'] == 'Delivered'
//                                 ? Colors.green
//                                 : Colors.orange,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Date: ${order['date']}',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       Text(
//                         'Items: ${order['items']}',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total Amount',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         order['total'],
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       OutlinedButton(
//                         onPressed: () {
//                           // TODO: Implement view details functionality
//                         },
//                         style: OutlinedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text('View Details'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // TODO: Implement track order functionality
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text('Track Order'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
