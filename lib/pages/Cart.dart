
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Controller/CartController.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/model/User.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late final Stream<QuerySnapshot> _usersStream;
  @override
  void initState() {
    super.initState();
    _usersStream = CartController().streamCart(collectionn: "cartSSS", uid: "uidStorOwner");

    //  FirebaseFirestore.instance
    //     .collection('cartSSS')
    //     .where("uidStorOwner",
    //         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    //userProvider.refreshUser();
    UserDete? userData = userProvider.getUser;
    String cartDoc = "";
    List l1 = [];

    //final classInstancee = Provider.of<Cart>(context);
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 141, 95),
          title: const Text("Cart  "),
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
                          child: CartController().StreamBuilderCart(context, uid: "uidStorOwner", collectionn: "cartSSS")

                        

                          ),
                      ElevatedButton(
                        onPressed: () async {
////////////////////////////////////get data ffrom cart in fire base and send it to  requsted prodact to firebase and delete item from cart in fire base
                          CartController().sendProdactToFarmer(context: context);
                        
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
                          "Send Order To farmer ",
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
