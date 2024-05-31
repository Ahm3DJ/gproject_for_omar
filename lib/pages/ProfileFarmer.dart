
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

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    UserProvider userProvider = Provider.of(context, listen: false);
  //   userProvider.refreshUser();
    //  Future<int> count = ViewProfilePictures().getCounterPost();
    return isLoading
        ? const Scaffold(
            backgroundColor: scaffoldColor,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
            actions: [Container(
            width: 55,
            
              child: Stack(
                children: [
                  Positioned(child: Text("\$",style: TextStyle(fontSize: 20),),),
                  Positioned(child: Text("${allDataFromDB!.balance}"),
                  bottom: 14,
                  right: 10,)
                ],
              ),
            )

            ],
              backgroundColor: appbarGreen,
              title: Text(allDataFromDB.username) //Text(userDate["username"])
              ,
            ),
            body: Padding(
              padding: widthScreen > 600
                  ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
                  : const EdgeInsets.all(0),
              child: Column(
                children: [
                  Container(
                    color: Colors.green[50],
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(22, 15, 0, 0),
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(125, 78, 91, 110),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(allDataFromDB.profileImg),

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
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Prodact",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 17,
                                  ),
                                  const SizedBox(
                                    width: 17,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const DateTimeFarmer()),
                                  );
                                },
                                icon: const Icon(
                                  Icons.history,
                                  color: Color.fromARGB(168, 3, 65, 27),
                                  size: 26,
                                ),
                              ),

                              // Text(widget.prodacts.location),
                              const Text("History")
                            ],
                          ),
                        )

                        //  Text(userDate["title"]))
                        ,
                        const SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: widthScreen > 600 ? 0.06 : 0.43,
                        ),
                        const SizedBox(
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
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              label: const Text(
                                "Edit Profile Farmer",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(0, 90, 103, 223)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: widthScreen > 600 ? 19 : 10,
                                        horizontal: 15)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(109, 255, 255, 255),
                                        // width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.logout,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Log out",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
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
                        const SizedBox(
                          height: 9,
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: widthScreen > 600 ? 0.06 : 0.43,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
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
            ),
          );
  }
}
