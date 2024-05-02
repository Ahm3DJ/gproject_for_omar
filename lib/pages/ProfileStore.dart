// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:graduation_project2/pages/EditeProfilePage.dart';
import 'package:graduation_project2/shared/colors.dart';

class ProfileStoreOwner extends StatefulWidget {
  const ProfileStoreOwner({Key? key}) : super(key: key);

  @override
  State<ProfileStoreOwner> createState() => _ProfileStoreOwnerState();
}

class _ProfileStoreOwnerState extends State<ProfileStoreOwner> {
  Map userDate = {};
  bool isLoading = false;
  int followers = 0;
  int following = 0;

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

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //    getData();//////////////////////////////////
  // }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return isLoading
        ? Scaffold(
            backgroundColor: scaffoldColor,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            backgroundColor: scaffoldColor,
            appBar: AppBar(
              backgroundColor: appbarGreen,
              title: Text("UserName")//Text(userDate["username"])
              ,
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB( 22,15,0,0),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/graduation-project-6d506.appspot.com/o/profileIMG%2F3344330106ef075-6f26-4784-bb51-84aa0b9749518720246045768845641.jpg?alt=media&token=c7a9af9f-05a6-4eb9-8d8f-d15835ec14c9"),

                        // backgroundImage: NetworkImage(userDate["ProfileStoreOwnerImg"]),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "1",
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
                              Icon(
                                Icons.edit_location,
                                color: Color.fromARGB(168, 3, 65, 27),
                                size: 26,
                              ),
                              // Text(widget.prodacts.location),
                              Text("location")
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
                        "Edit Profile Store",
                        style: TextStyle(fontSize: 17,color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(0, 90, 103, 223)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
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
                        style: TextStyle(fontSize: 17,color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.green),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
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
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: widthScreen > 600
                        ? const EdgeInsets.all(66.0)
                        : const EdgeInsets.all(3.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://cdn1-m.alittihad.ae/store/archive/image/2021/10/22/6266a092-72dd-4a2f-82a4-d22ed9d2cc59.jpg?width=1300",
                              // height: 333,
                              // width: 100,

                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
  }
}
