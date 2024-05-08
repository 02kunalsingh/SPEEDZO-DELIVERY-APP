import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k/screens/Login/googlesignin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k/screens/Login/mobile.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(225, 1, 35, 255),
          centerTitle: true,
          title: Text("SPEEDZO",
              style: GoogleFonts.nosifer(
                fontSize: 28,
              )),
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: LottieBuilder.asset("assets/login/login.json")),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200, top: 20),
              child: Text(
                "Welcome",
                style: GoogleFonts.kalam(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            const Mobile(), //enter phone number and button.

            const SizedBox(
              height: 10,
            ),
            const Text(
              "------- OR -------",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 125,
                ),
                InkWell(
                  onTap: () {
                    Authmethod().signInWithGoogle(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            image: AssetImage("assets/login/google.webp"),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Authmethod().signInWithApple();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            image: AssetImage("assets/login/ios.jpg"),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // InkWell(
                //   onTap: () {
                //     auth.signOut().then((value) => Navigator.of(context).pop(
                //         MaterialPageRoute(builder: (ctx) => const Onboard())));
                //   },
                //   child: Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //         color: Colors.black,
                //         borderRadius: BorderRadius.circular(50),
                //         image: const DecorationImage(
                //             image: AssetImage("assets/login/ios.jpg"),
                //             fit: BoxFit.fitHeight)),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
