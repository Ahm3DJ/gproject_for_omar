// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/Notifecation.dart';
import 'package:graduation_project2/Provider/Req.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/firebase/fireStore.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/pages/Cart.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/pages/ProfileFarmer.dart';
import 'package:graduation_project2/pages/ProfileStore.dart';
import 'package:graduation_project2/pages/RequstedProdactFarmer.dart';
import 'package:graduation_project2/pages/notifStoreOwner.dart';
import 'package:graduation_project2/shared/PostDesign.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/constant.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> userDate = {};
  //  Future<Map> userDate =  FireBase().getData();

  bool isLoading = true;

  // getDate() async {
  //   // Get data from DB

  //   setState(() {
  //     isLoading = true;
  //   });
  //   userDate = await FireBase().getData(context: context) as Map<String, dynamic>;

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  bool fruitProdact = false;
  bool vegetableProdact = false;
  bool anotherProdact = false;

  @override
  void initState() {
    fruitProdact = false;
    vegetableProdact = false;
    anotherProdact = false;
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    final searchController = TextEditingController();
    //  final allDataFromDB = Provider.of<UserProvider>(context);
    UserProvider userProvider = Provider.of(context, listen: false);
    //userProvider.refreshUser();

    UserDete? userData = userProvider.getUser;

    final classInstancee = Provider.of<Notificationn>(context);
    final reqProvider = Provider.of<RequstedProvider>(context);

    int counter = classInstancee.getCount();
    int counterREQ = reqProvider.getCountREQ();
    setState(() {
      print(
          "++++++++++++++++++++dddd++++++++++++++${classInstancee.getCount()}");
      print(
          "++++++++++++++++++++aaaaaaaa++++++++++++++${reqProvider.getCountREQ()}");
    });
    print("++++++++++++++++++++dddd++++++++++++++${classInstancee.getCount()}");
    print(
        "++++++++++++++++++++aaaaaaaa++++++++++++++${reqProvider.getCountREQ()}");

    return
        // isLoading
        //     ?  Scaffold(
        //         backgroundColor: scaffoldColor,
        //         body: Center(
        //             child: CircularProgressIndicator(
        //           color: Colors.white,
        //         )),
        //       )
        //     :
        Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: appbarGreen,
        actions: [
          Stack(children: <Widget>[
            Text(
                '                                                                              '),
            IconButton(
              onPressed: () {
                print(
                    "++++++++++++++++++++dddd++++++++++++++${classInstancee.getCount()}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => userData?.situation == "Farmer"
                          ? RequsteProdact()
                          : NotifayStoreOwner(),
                    ));
              },
              icon: Icon(
                Icons.notification_important_rounded,
              ),
            ),
            Positioned(
              left: 11,
              top: 11,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  userData?.situation == "Farmer"
                      ? '${reqProvider.getCountREQ()}'
                      : '${counter}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
          CircleAvatar(
            backgroundImage: NetworkImage(userData!.profileImg),
          ),
          Text("     "),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     userData.situation == "Farmer"
          //         ? Icons.request_page
          //         : Icons.notification_important_rounded,
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userData!.profileImg),
                  ),
                  accountName: Text(userData.username),
                  // Text(allDataFromDB.getUser!.username),
                  //  currentAccountPicture: GetImagFromFireBase(),
                  // accountName:GetDataTest(documentId: userInfo.uid, returnData: 'username',)

                  // Text(userInfo.displayName!=null?userInfo.displayName!:"Omar Quraan"),
                  accountEmail: //Text("sadada"),
                      Text(userData.email),

                  // ,  accountEmail: Text(userInfo.email! ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 53, 137, 78),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/nathan-dumlao-bRdRUUtbxO0-unsplash-1536x1024.jpeg"))),
                ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userData.situation == "Farmer"
                                ? RequsteProdact()
                                : Cart(),
                          ));
                    }),
                ListTile(
                    title: Text("Profile Page "),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userData.situation == "Farmer"
                                ? ProfileFarmer()
                                : ProfileStoreOwner(),
                          ));
                    }),
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      //  Navigator.pop(context);

                      // FirebaseAuth.instance.signOut();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Developed by Omar Essam Quraan ",
                  style: TextStyle(fontSize: 10),
                ),
                Icon(
                  Icons.copyright,
                  size: 15,
                ),
                Text(
                  "2024",
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: widthScreen > 600
            ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
            : const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                // width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                        // height: 300,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/annie-spratt-m1t-RJ1iCIU-unsplash.jpg",
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                        bottom: 100,
                        left: 50,
                        child: Text(
                          "Welcome ....",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        )),
                    Positioned(
                        bottom: 50,
                        right: 40,
                        child: Container(
                          width: widthScreen / 10 * 8,
                          child: TextField(
                              controller: searchController,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "Search....",
                                prefixIcon: Icon(Icons.search),
                                // To delete borders
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: BTNgreen,
                                  ),
                                ),
                                // fillColor: Colors.red,
                                filled: true,
                                contentPadding: EdgeInsets.all(8),
                              )),
                        )),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: contantPost,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          fruitProdact = true;
                          vegetableProdact = false;
                          anotherProdact = false;
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            fruitProdact ? Colors.white : Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            fruitProdact ? Colors.green : Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side:
                                BorderSide(color: Colors.green), // Border color
                          ),
                        ),
                      ),
                      child: Text("Fruits"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          fruitProdact = false;
                          vegetableProdact = true;
                          anotherProdact = false;
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            vegetableProdact ? Colors.white : Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            vegetableProdact
                                ? Colors.green
                                : Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side:
                                BorderSide(color: Colors.green), // Border color
                          ),
                        ),
                      ),
                      child: Text("Vegetables"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          fruitProdact = false;
                          vegetableProdact = false;
                          anotherProdact = true;
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            anotherProdact ? Colors.white : Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            anotherProdact ? Colors.green : Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side:
                                BorderSide(color: Colors.green), // Border color
                          ),
                        ),
                      ),
                      child: Text("Other"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: heightScreen - 220,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBase().getDataBasedTypeProdact(fruit: fruitProdact, vegetable: vegetableProdact, another: anotherProdact),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return showSnackBar(context, "Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return
                            // Text("data");

                            PostDesign(
                          data: data,
                        );
                      }).toList(),
                    );

                    //  Text("data");

                    //     SizedBox(
                    //   height: 500,
                    //   child: Expanded(
                    //     child: ListView(
                    //       children: snapshot.data!.docs
                    //           .map((DocumentSnapshot document) {
                    //         Map<String, dynamic> data =
                    //             document.data()! as Map<String, dynamic>;
                    //         print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ");

                    //         return

                    //               Text("omar");
                    //         //     PostDesign(
                    //         //   data: data,
                    //         // );
                    //       }).toList(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              )

              // // // AssetImage("assets/smiley-4832492_960_720.png"),
            ],
          ),
        ),
      ),
    );
  }
}
