import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project2/seconderyWidgets//Onboarding_Widget_2.dart';

class OnboardingWidget extends StatelessWidget {
  OnboardingWidget({super.key});

  @override
  Widget build(BuildContext context) {
        final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
  padding: widthScreen > 600
            ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
            : const EdgeInsets.all(0),        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnboardingWidget2()),
            );
          },
          child: Container(
            height: 790,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 400,
                    ),
                    const Text(
                      'Fresh Vegetables and Fruits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 250,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 100)),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnboardingWidget2()),
                            );
                          },
                          icon: const Icon(Icons.navigate_before),
                          label: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
