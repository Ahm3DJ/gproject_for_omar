// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/Notifecation.dart';
import 'package:graduation_project2/Provider/Req.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Provider/UserSituationProvider%20.dart';
import 'package:graduation_project2/firebase_options.dart';
import 'package:graduation_project2/pages/HomePage.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/pages/registration.dart';
import 'package:graduation_project2/responsive/mobile.dart';
import 'package:graduation_project2/responsive/responsive.dart';
import 'package:graduation_project2/responsive/web.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
    'LoginPage_Case1',
    (WidgetTester tester) async {
      //Email and Password are correct
      //The test will build the homepage widget if successful
      final emailTextFiled = find.byKey(const ValueKey('Email_TextFormField'));
      final passwordTextFiled =
          find.byKey(const ValueKey('Password_TextFormField'));
      final signin_ElevatedButton =
          find.byKey(const ValueKey('signin_ElevatedButton'));

      await tester.pumpWidget(MaterialApp(home: Login()));

      expect(emailTextFiled, findsOneWidget);
      expect(passwordTextFiled, findsOneWidget);

      await tester.enterText(emailTextFiled, 'ahmad@gmail.com');
      await tester.enterText(passwordTextFiled, '.qQ1qqqq');

      await tester.tap(signin_ElevatedButton);

      await tester.pump();

      expect(find.text('Vegetables'), findsOneWidget);
    },
  );

  testWidgets('Homepage_Farmer', (WidgetTester tester) async {
    //testing the different pages
    await tester.pumpWidget(MultiProvider(
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
      child: const MaterialApp(
        home: HomePage(),
      ),
    ));

    await tester.pump();
  });
}
