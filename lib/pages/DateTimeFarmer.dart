
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateTimeFarmer extends StatefulWidget {
  const DateTimeFarmer({super.key});

  @override
  State<DateTimeFarmer> createState() => _DateTimeFarmerState();
}

class _DateTimeFarmerState extends State<DateTimeFarmer> {
  late final Stream<QuerySnapshot> _usersStream;
  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance
        .collection('notifiayYYY')
        .where("uidFarmer", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    //userProvider.refreshUser();
    UserDete? userData = userProvider.getUser;
    String DateTimeFarmerDoc = "";
    List l1 = [];

    //final classInstancee = Provider.of<DateTimeFarmer>(context);
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 141, 95),
          title: const Text("DateTimeFarmer  "),
          //  actions: [AppBarRebited()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: widthScreen > 600
                      ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
                      : const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        height: heightScreen - 250,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _usersStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }

                              return ListView.builder(
                                  //      itemCount: classInstancee.selectedProdact.length,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map<String, dynamic> data =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    DateTimeFarmerDoc =
                                        snapshot.data!.docs[index].id;
                                    return Card(
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(data["imgPost"]),
                                            // AssetImage(classInstancee
                                            //     .selectedProdact[index].pathImage),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Farmer :  ${data["usernameFarmer"]} "),
                                              Text(
                                                  "Quantity: ${data["partquntity"]} "),
                                              Text(
                                                  "Price : ${data["price"]} for 1KG  "),
                                              Text(
                                                  "Total Price: ${(double.parse(data["price"]) * double.parse(data["partquntity"])).toString()} "),
                                              Text("title: ${data["title"]} "),
                                              Text(
                                                  "Prodact Name: ${data["prodactName"]} "),
                                              Text(
                                                  "Date of purchase:  ${data["datePublished"] == null ? data["datePublished"] : DateFormat('MMMM d, ' 'y').format(data["datePublished"].toDate())} ")
                                            ],
                                          ),
                                          const SizedBox(),
                                  
                                        ],
                                      )),

                                    );
                                  });
                            }),
                      ),
                      ElevatedButton(
                        onPressed: () async {
///////////////////////////////
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(BTNgreen),
                          padding:
                              MaterialStateProperty.all(const EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: const Text(
                          "click here",
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
