// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Controller/ProfileFarmerController.dart';
import 'package:graduation_project2/pages/DateTimeFarmer.dart';
import 'package:graduation_project2/pages/EditeProfilePage.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:provider/provider.dart';

class ProfileFarmer extends StatefulWidget {
  const ProfileFarmer({Key? key}) : super(key: key);

  @override
  State<ProfileFarmer> createState() => _ProfileFarmerState();
}

class _ProfileFarmerState extends State<ProfileFarmer> {
  Map userDate = {};
  bool isLoading = false;
  int countProdact = 0;
  // getData() async {
  //   // Get data from DB

  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //         .instance
  //         .collection('userSSS')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();

  //     userDate = snapshot.data()!;

  //     followers = userDate["followers"].length;
  //     following = userDate["following"].length;
  //   } catch (e) {
  //     print(e.toString());
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // @override
  // // void initState() {
  // //   // TODO: implement initState
  // //   super.initState();
  // //    getData();//////////////////////////////////
  // // }
/////////////
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    UserProvider userProvider = Provider.of(context, listen: false);
    // userProvider.refreshUser();
  //  Future<int> count = ViewProfilePictures().getCounterPost();
    return isLoading
        ? Scaffold(
            backgroundColor: scaffoldColor,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: appbarGreen,
              title: Text(allDataFromDB!.username) //Text(userDate["username"])
              ,
            ),
            body: Column(
              children: [
                Container(
                  color: scaffoldColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(22, 15, 0, 0),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(125, 78, 91, 110),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(allDataFromDB.profileImg),

                              // backgroundImage: NetworkImage(userDate["ProfileFarmerImg"]),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${ViewProfilePictures.count}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Prodact",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 17,
                                ),
                                SizedBox(
                                  width: 17,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DateTimeFarmer()),
                                );
                              },
                              icon: Icon(
                                Icons.history,
                                color: Color.fromARGB(168, 3, 65, 27),
                                size: 26,
                              ),
                            ),

                            // Text(widget.prodacts.location),
                            Text("History")
                          ],
                        ),
                      )

                      //  Text(userDate["title"]))
                      ,
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: widthScreen > 600 ? 0.06 : 0.43,
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditeProfiePage()),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            label: Text(
                              "Edit Profile Farmer",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(0, 90, 103, 223)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: widthScreen > 600 ? 19 : 10,
                                      horizontal: 15)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(
                                      color: Color.fromARGB(109, 255, 255, 255),
                                      // width: 1,
                                      style: BorderStyle.solid),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.logout,
                              size: 24.0,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Log out",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: widthScreen > 600 ? 19 : 10,
                                      horizontal: 33)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: widthScreen > 600 ? 0.06 : 0.43,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Padding(
                      padding: widthScreen > 600
                          ? const EdgeInsets.all(66.0)
                          : const EdgeInsets.all(3.0),
                      child: ViewProfilePictures()
                          .StreamBuilderPictureFarmer(context)),
                ),
              ],
            ),
          );
  }
}
