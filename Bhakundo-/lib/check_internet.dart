// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'core/common/provider/internet_connectivity.dart';

// class InternetCheck extends StatelessWidget {
//   const InternetCheck({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Check Internet Status'),
//       ),
//       body: Center(
//         child: Consumer(
//           builder: (context, ref, child) {
//             final connectivityStatus = ref.watch(connectivityStatusProvider);

//             if (connectivityStatus == ConnectivityStatus.isConnected) {
//               return const Text(
//                 'Connected to the Internet.',
//                 style: TextStyle(fontSize: 24),
//               );
//             } else {
//               return const Text(
//                 'No Internet!',
//                 style: TextStyle(fontSize: 24),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
