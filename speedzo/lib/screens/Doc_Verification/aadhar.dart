import 'package:flutter/material.dart';
import 'package:k/screens/Doc_Verification/data.dart';

class Aadhar extends StatefulWidget {
  const Aadhar({super.key});

  @override
  State<Aadhar> createState() => _AadharState();
}

class _AadharState extends State<Aadhar> {
  final GlobalKey<FormState> aadharkey = GlobalKey();
  TextEditingController aadharController = TextEditingController();
  bool isloading = false;

  void saveUserData() async {
    String aadhar = aadharController.text;
    await UserInfoStorage.setnumber(aadhar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 1, 35, 255),
        leading: BackButton(
          onPressed: () {},
        ),
        title: const Text("Verify Aadhar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 300,
                width: 312,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage("assets/aadhar/aadhar.webp"),
                        fit: BoxFit.fitHeight)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: aadharkey,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Aadhar Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(225, 1, 35, 255)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Number";
                    }
                    if (value.length < 12) {
                      return "Enter valid Number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(276, 40)),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
                  elevation: MaterialStatePropertyAll(15),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(225, 1, 35, 255))),
              onPressed: () {
                if (aadharkey.currentState!.validate()) {
                  setState(() {
                    isloading = true;
                  });
                  Future.delayed(
                    const Duration(seconds: 4),
                    () {
                      setState(() {
                        isloading = false;
                      });
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const Otp()));
                    },
                  );
                }
              },
              child: isloading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            "",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                            semanticsLabel: "ll",
                          ),
                        ])
                  : const Text(
                      "Verify",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
