// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/Notifecation.dart';
import 'package:graduation_project2/Provider/Req.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Provider/UserSituationProvider%20.dart';
import 'package:graduation_project2/firebase_options.dart';
import 'package:graduation_project2/responsive/mobile.dart';
import 'package:graduation_project2/responsive/responsive.dart';
import 'package:graduation_project2/responsive/web.dart';
import 'package:provider/provider.dart';
import 'shared/showSnackBar.dart';
import 'package:graduation_project2/seconderyWidgets/Onboarding_Widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCObmHctQtBVel7qe5xSR3ow4MwpRJj_ng",
            authDomain: "graduation-project-6d506.firebaseapp.com",
            projectId: "graduation-project-6d506",
            storageBucket: "graduation-project-6d506.appspot.com",
            messagingSenderId: "296290464946",
            appId: "1:296290464946:web:df64371986e6a1984185ab"));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getDataFromDB() async {
    //   UserProvider userProvider = Provider.of(context, listen: false);
    //   await userProvider.refreshUser();
    // }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        // Add more providers as needed
        ChangeNotifierProvider<UserSituationProvider>(
          create: (context) => UserSituationProvider(),
        ),
        ChangeNotifierProvider<Notificationn>(
          create: (context) => Notificationn(),
        ),
        ChangeNotifierProvider<RequstedProvider>(
          create: (context) => RequstedProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
            //   return OnboardingWidget();
            //   //  Login();
            //   //   Register();
            //   // HomePage();
            //   ///////////////////
            return  Resposive(
                myMobileScreen: MobileScerren(),
                myWebScreen: WebScerren(),
              );
            } else {
              return OnboardingWidget();
            }
          },
        ),
        // home: Resposive(
        //   myMobileScreen: MobileScerren(),
        //   myWebScreen: WebScerren(),
        // ),
      ),
    );
  }
}
