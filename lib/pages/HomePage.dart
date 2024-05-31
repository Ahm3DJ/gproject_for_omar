
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/Notifecation.dart';
import 'package:graduation_project2/Provider/Req.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/Controller/fireStore.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/pages/Cart.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/pages/ProfileFarmer.dart';
import 'package:graduation_project2/pages/ProfileStore.dart';
import 'package:graduation_project2/pages/RequstedProdactFarmer.dart';
import 'package:graduation_project2/pages/notifStoreOwner.dart';
import 'package:graduation_project2/shared/PostDesign.dart';
import 'package:graduation_project2/shared/colors.dart';
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

  getDate() async {
    // Get data from DB

    setState(() {
      isLoading = true;
    });
    userDate = await FireBase().getData(context: context) as Map<String, dynamic>;

    setState(() {
      isLoading = false;
    });
  }

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
        //     ?  const Scaffold(
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
            const Text(
                '                                                                              '),
            IconButton(
              onPressed: () {
                print(
                    "++++++++++++++++++++dddd++++++++++++++${classInstancee.getCount()}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => userData?.situation == "Farmer"
                          ? const RequsteProdact()
                          : NotifayStoreOwner(),
                    ));
              },
              icon: const Icon(
                Icons.notification_important_rounded,
              ),
            ),
            Positioned(
              left: 11,
              top: 11,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  userData?.situation == "Farmer"
                      ? '${reqProvider.getCountREQ()}'
                      : '${counter}',
                  style: const TextStyle(
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
          const Text("     "),
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
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(userData.profileImg),
                    ),
                  ),
                  accountName: Text(
                    userData.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    userData.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 53, 137, 78),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black45,
                        BlendMode.darken,
                      ),
                      image: AssetImage(
                        "assets/nathan-dumlao-bRdRUUtbxO0-unsplash-1536x1024.jpeg",
                      ),
                    ),
                  ),
                ),
                    ListTile(
                    title: const Text("Home", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
                    leading: const Icon(Icons.home,color: Colors.green),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    }),
                ListTile(
                    title: const Text("My products",        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
                    leading: const Icon(Icons.add_shopping_cart, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userData.situation == "Farmer"
                                ? const RequsteProdact()
                                : const Cart(),
                          ));
                    }),
                ListTile(
                    title: const Text("Profile Page "  ,      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
                    leading: const Icon(Icons.person, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userData.situation == "Farmer"
                                ? const ProfileFarmer()
                                : const ProfileStoreOwner(),
                          ));
                    }),
                ListTile(
                    title: const Text("About",        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
                    leading: const Icon(Icons.help_center, color: Colors.green),
                    onTap: () {}),
                ListTile(
                    title: const Text("Logout"     ,   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
                    leading: const Icon(Icons.exit_to_app, color: Colors.green),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      //  Navigator.pop(context);

                      // FirebaseAuth.instance.signOut();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                    }),
              ],
            ),
            const Row(
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
        child:CustomScrollView(
  slivers: [
    SliverToBoxAdapter(
      child: SizedBox(
        height: 250,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/annie-spratt-m1t-RJ1iCIU-unsplash.jpg",
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              bottom: 100,
              left: 50,
              child: Text(
                "Welcome ....",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 40,
              child: Container(
                width: widthScreen / 10 * 8,
                child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: "Search....",
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: BTNgreen,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: contantPost,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
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
                  fruitProdact ? Colors.white : Colors.black,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  fruitProdact ? Colors.green : Colors.transparent,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
              child: const Text("Fruits"),
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
                  vegetableProdact ? Colors.white : Colors.black,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  vegetableProdact ? Colors.green : Colors.transparent,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
              child: const Text("Vegetables"),
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
                  anotherProdact ? Colors.white : Colors.black,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  anotherProdact ? Colors.green : Colors.transparent,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
              child: const Text("Other"),
            ),
          ],
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      sliver: StreamBuilder<QuerySnapshot>(
        stream: FireBase().getDataBasedTypeProdact(
          fruit: fruitProdact,
          vegetable: vegetableProdact,
          another: anotherProdact,
        ),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: showSnackBar(context, "Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return PostDesign(data: data);
              },
              childCount: snapshot.data!.docs.length,
            ),
          );
        },
      ),
    ),
  ],
)
),
    );
  }
}
