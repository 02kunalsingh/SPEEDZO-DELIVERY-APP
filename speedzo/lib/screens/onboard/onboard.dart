import 'package:flutter/material.dart';
import 'package:k/screens/Login/login.dart';
import 'package:lottie/lottie.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<String> lottiePaths = [
    "assets/onboard/delivery2.json",
    "assets/onboard/delivery1.json",
  ];

  final List<String> titles = [
    "Fast Delivery",
    "Good Service",
  ];

  final List<String> descriptions = [
    "Get your order delivered to your doorstep quickly!",
    "Our delivery partners ensure that your food is delivered fast and fresh.",
  ];

  final _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: lottiePaths.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                      _pageIndexNotifier.value = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildPage(lottiePaths[index], "", "");
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: CirclePageIndicator(
                    selectedDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    itemCount: lottiePaths.length,
                    currentPageNotifier: _pageIndexNotifier,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              titles[_currentPageIndex],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              descriptions[_currentPageIndex],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Get Started"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(225, 1, 35, 255),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }

  Widget _buildPage(String lottiePath, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Lottie.asset(lottiePath,
              height: 300, fit: BoxFit.cover // Adjust the height as needed
              ),
        ),
        const SizedBox(height: 0),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 0), //moves upward
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
