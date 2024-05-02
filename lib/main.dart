// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/firebase_options.dart';
import 'package:graduation_project2/pages/HomePage.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/pages/registration.dart';
import 'package:graduation_project2/responsive/mobile.dart';
import 'package:graduation_project2/responsive/responsive.dart';
import 'package:graduation_project2/responsive/web.dart';
import 'package:provider/provider.dart';
import 'shared/showSnackBar.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

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

    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
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
              return
              //  Login(); 
                // Register();
              // HomePage();
              Resposive(
                myMobileScreen: MobileScerren(),
                myWebScreen: WebScerren(),
              );
            } 
            else {
              return Login();
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
