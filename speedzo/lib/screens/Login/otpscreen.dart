import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k/screens/BottomaNavigator/bottomnavigator.dart';
import 'package:k/screens/Login/login.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import '../../widgets/pallets.dart';
import 'mobileauth.dart';

// class Otp extends StatefulWidget {
//   const Otp({super.key});

//   @override
//   State<Otp> createState() => _OtpState();
// }

// double getheight(BuildContext context) {
//   return MediaQuery.of(context).size.height;
// }
// class _OtpState extends State<Otp> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   GlobalKey<FormState> pinkey = GlobalKey();
//   bool isloading = false;
//   bool isresendagain = false;
//   bool isverified = false;
//   String code = "";
//   bool isvalid = false;

//   // late Timer = _timer;
//   // int _start = 60;
//   void resend() {
//     setState(() {
//       isresendagain = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthWithNumber controller = Get.find();

//     var mediaQuery = MediaQuery.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pushReplacement(
//                   CupertinoPageRoute(builder: (ctx) => const Login()));
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new_outlined,
//               color: Colors.white,
//             )),
//       ),
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Container(
//           height: getheight(context) * 0.9,
//           width: mediaQuery.size.width,
//           padding: const EdgeInsets.only(bottom: 140),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 10, top: 0, left: 10),
//                 child: Text(
//                   "CO\nDE",
//                   style: otp,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 40, left: 30, right: 20),
//                 child: Text(
//                   "Enter the OTP sent to number",
//                   style: or,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                 child: Form(
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   key: pinkey,
//                   child: Pinput(
//                     validator: (otp) {
//                       if (otp!.isEmpty) {
//                         return "Please Enter Otp!";
//                       }
//                       if (otp.length < 6) {
//                         return "Enter valid otp!";
//                       }
//                       return null;
//                     },
//                     pinAnimationType: PinAnimationType.slide,
//                     controller: controller.otp,
//                     animationCurve: Curves.bounceIn,
//                     androidSmsAutofillMethod:
//                         AndroidSmsAutofillMethod.smsRetrieverApi,
//                     closeKeyboardWhenCompleted: true,
//                     length: 6,
//                     onCompleted: (value) {
//                       code;
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 41,
//                 width: 150,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (pinkey.currentState!.validate()) {
//                       controller.verifyNumber();
//                       setState(() {
//                         isloading = true;
//                       });
//                       Future.delayed(
//                         const Duration(seconds: 4),
//                         () {
//                           setState(() {
//                             isloading = false;
//                           });
//                         },
//                       );
//                     }
//                   },
//                   child: isloading
//                       ? const CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : isverified
//                           ? const Icon(
//                               Icons.check_circle,
//                               color: Colors.white,
//                               size: 20,
//                             )
//                           : const Text(
//                               "NEXT",
//                               style: kHeading2,
//                             ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 60,
//               ),
//               Column(
//                 children: [
//                   const Text(
//                     "Didnt receive code ?",
//                     style: or,
//                     textAlign: TextAlign.right,
//                   ),
//                   TextButton(
//                       onPressed: () {
//                         if (isresendagain) return;
//                         resend();
//                       },
//                       child: const Text(
//                         "Resend",
//                         style: TextStyle(color: Colors.blue, fontSize: 18),
//                       )),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> otpkey = GlobalKey();
  bool isload = false;
  bool isresend = false;
  bool isverify = false;
  bool isvalid = false;
  String code = "";

  void resend() {
    setState(() {
      isresend = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AuthWithNumber(TextEditingController()));
    AuthWithNumber controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "VERIFY",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (ctx) => const Login()));
            },
            icon: const Icon(
                size: 35,
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 80,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: LottieBuilder.asset(
                    "assets/Otp/otp.json",
                    fit: BoxFit.contain,
                  )),
            ),
            const SizedBox(
              height: 0,
            ),
            const Text(
              "OTP has been sent on number",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: otpkey,
              child: Pinput(
                validator: (otp) {
                  if (otp!.isEmpty) {
                    return "Please Enter Otp!";
                  }
                  if (otp.length < 6) {
                    return "Enter valid otp!";
                  }
                  return null;
                },
                length: 6,
                animationCurve: Curves.decelerate,
                closeKeyboardWhenCompleted: true,
                controller: controller.otp,
                autofocus: true,
                // androidSmsAutofillMethod:
                //     AndroidSmsAutofillMethod.smsUserConsentApi,
                onCompleted: (value) {
                  code;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 41,
              width: 150,
              //button next..
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(225, 1, 35, 255))),
                onPressed: () async {
                  if (otpkey.currentState!.validate()) {
                    controller.verifyNumber();
                    setState(() {
                      isload = true;
                    });
                    Future.delayed(
                      const Duration(seconds: 4),
                      () {
                        setState(() {
                          isload = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BottomNavigatorScreen()));
                      },
                    );
                  }
                },
                child: isload
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : isverify
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          )
                        : const Text(
                            "NEXT",
                            style: kHeading2,
                          ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Column(
              children: [
                const Text(
                  "Didnt receive code ?",
                  style: or,
                  textAlign: TextAlign.right,
                ),
                TextButton(
                    onPressed: () {
                      if (isresend) return;
                      resend();
                    },
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                          color: Color.fromARGB(225, 1, 35, 255), fontSize: 18),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
