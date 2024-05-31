import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/pages/registration.dart';

class OnboardingWidget2 extends StatelessWidget {
  OnboardingWidget2({super.key});

  @override
  Widget build(BuildContext context) {
        final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
padding: widthScreen > 600
            ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
            : const EdgeInsets.all(0),           child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: Container(
            height: 790,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_image2.jpg'),
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
                      'Delivered to your doorstep!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 100)),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          icon: const Icon(Icons.navigate_before),
                          label: const Text(
                            '!Sign In',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
        
                  
                                      Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 100)),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );
                          },
                          icon: const Icon(Icons.navigate_before),
                          label: const Text(
                            '!Sign Up',
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
