// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hunger/screens/home/BottomNavigator.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:lottie/lottie.dart';

// class InternetController extends GetxController {
//   final Connectivity _connectivity = Connectivity();
//   bool isconnected = false;

//   @override
//   void onInit() async {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(internetStatus);
//   }

//   internetStatus(ConnectivityResult result) {
//     if (result == ConnectivityResult.none) {
//       isconnected = true;
//       Get.offAll(() => const NoInternet());
//       update();
//     } else {
//       isconnected = false;
//       Get.offAll(() => const Bnavv());
//     }
//   }
// }

// class NoInternet extends StatefulWidget {
//   const NoInternet({super.key});

//   @override
//   State<NoInternet> createState() => _NoInternetState();
// }

// class _NoInternetState extends State<NoInternet> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 1.4,
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//                 color: Colors.white),
//             child: LottieBuilder.asset("assets/No internet/NoInternet.json"),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 480, left: 120),
//             child: TextButton.icon(
//                 style: const ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(
//                         Color.fromARGB(255, 43, 94, 95)),
//                     shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20))))),
//                 onPressed: () {},
//                 icon:
//                     const LineIcon(Icons.wifi_find_rounded, color: Colors.red),
//                 label: const Text(
//                   "Try Again",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15),
//                 )),
//           ),
//           Container(
//             margin: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height / 1.4,
//             ),
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//             ),
//             child: const Center(
//               child: Text(
//                   "      No Internet Connection!! "
//                   "\nPlease check your connection.",
//                   style: TextStyle(color: Colors.white, fontSize: 20)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
