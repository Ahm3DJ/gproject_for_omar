// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Provider/UserSituationProvider%20.dart';
import 'package:graduation_project2/firebase/fireStore.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/pages/AddProdact.dart';
import 'package:graduation_project2/pages/Cart.dart';
import 'package:graduation_project2/pages/HomePage.dart';
import 'package:graduation_project2/pages/ProfileFarmer.dart';
import 'package:graduation_project2/pages/ProfileStore.dart';
import 'package:graduation_project2/pages/RequstedProdactFarmer.dart';
import 'package:graduation_project2/pages/notifStoreOwner.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:provider/provider.dart';

class MobileScerren extends StatefulWidget {
  const MobileScerren({Key? key}) : super(key: key);

  @override
  State<MobileScerren> createState() => _MobileScerrenState();
}

class _MobileScerrenState extends State<MobileScerren> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  Map<String, dynamic> userDate = {};
  bool isLoading = true;

  getData() async {
    // Get data from DB

    setState(() {
      isLoading = true;
    });
    try {
      userDate =
          await FireBase().getData(context: context) as Map<String, dynamic>;

//  To get posts length
      // var snapshotPosts = await FirebaseFirestore.instance
      //     .collection('postSSS')
      //     .where("uid", isEqualTo: widget.uiddd)
      //     .get();

      // postCount = snapshotPosts.docs.length;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    //userProvider.refreshUser();
    UserDete? userData = userProvider.getUser;
    print("111111111111111111omar11111111111111${userData?.situation}");

    final allDataFromDB = Provider.of<UserProvider>(context).getUser;




 String? situation = Provider.of<UserSituationProvider>(context, listen: false).getUserSituation();

    // Use the situation data here
     print('User Situationzzzzzzzzzzzzzzzzzzzzzzzz: $situation');
    // UserProvider allDataFromDB = Provider.of(context, listen: false);

    //  print("333333333333333333333333333333333333${allDataFromDB!.email}");
    //  print("4444444444444444444444444444444444444${allDataFromDB.email}");
    return isLoading
        ? const Scaffold(
            backgroundColor: scaffoldColor,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            bottomNavigationBar: CupertinoTabBar(
                backgroundColor: appbarGreen,
                onTap: (index) {
                  // navigate to the tabed page
                  _pageController.jumpToPage(index);
                  userProvider.refreshUser();
                  setState(() {
                    currentPage = index;
                    
                  });

                  // print(   "---------------    $index "  );
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: currentPage == 0 ? primaryColor : secondaryColor,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                        color: currentPage == 1 ? primaryColor : secondaryColor,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        userData!.situation == "Farmer"
                            // userDate["situation"] == "Farmer"
                            ? Icons.add_circle
                            : Icons.add_shopping_cart,
                        color: currentPage == 2 ? primaryColor : secondaryColor,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: currentPage == 3 ? primaryColor : secondaryColor,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        userData.situation == "Farmer"
                            ? Icons.request_page
                            : Icons.notification_important_rounded,
                        color: currentPage == 4 ? primaryColor : secondaryColor,
                      ),
                      label: ""),
                ]),
            body: PageView(
              onPageChanged: (index) {
                print("------- $index");
              },
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                HomePage(),
                Center(child: Text("I love YOU <3")),
                userData.situation == "Farmer" ? AddProdact() : Cart(),
                userData.situation == "Farmer"
                    ? ProfileFarmer()
                    : ProfileStoreOwner(),
                userData.situation == "Farmer"
                    ? RequsteProdact()
                    : NotifayStoreOwner(),
              ],
            ),
          );
  }
}
