import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k/screens/Login/otpscreen.dart';
import 'package:k/widgets/pallets.dart';

import 'mobileauth.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  // final phoneController = TextEditingController();
  final countrycode = TextEditingController();
  //final auth = FirebaseAuth.instance;
  bool isloading = false;
  bool isverified = false;
  Country selectedcountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  String verifyId = "";

  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthWithNumber controller =
        Get.put(AuthWithNumber(TextEditingController()));
    return Column(
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  validator: (number) {
                    if (number == null) {
                      return "Enter number";
                    }
                    if (number.length < 10) {
                      return "Enter valid number";
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.number,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      "Enter Phone Number",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            countryListTheme: const CountryListThemeData(
                                flagSize: 30, bottomSheetHeight: 650),
                            showPhoneCode: true,
                            searchAutofocus: true,
                            context: context,
                            onSelect: (value) {
                              setState(() {
                                selectedcountry = value;
                              });
                            },
                          );
                        },
                        child: Text(
                          "${selectedcountry.flagEmoji} + ${selectedcountry.phoneCode} |",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  // style: kHeading1,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 41,
                width: 150,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 1, 54, 225))),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      controller.numberLogin();
                      setState(() {
                        isloading = true;
                      });
                      Future.delayed(
                        const Duration(seconds: 4),
                        () {
                          setState(() {
                            isloading = false;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Otp()));
                        },
                      );
                    }
                  },
                  child: isloading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                "Wait .. ",
                                style: or,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ])
                      : Text(
                          "Send OTP",
                          style: GoogleFonts.lilitaOne(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
