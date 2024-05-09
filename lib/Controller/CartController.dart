import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:path/path.dart';

class CartController {
  sendProdactToFarmer({required context}) async {
    QuerySnapshot sourceSnapshot = await FirebaseFirestore.instance
        .collection('cartSSS')
        .where("uidStorOwner",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    for (QueryDocumentSnapshot document in sourceSnapshot.docs) {
      // Get the data of the document
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      String currentQuantity = "";

      try {
        DocumentReference docRefUser = FirebaseFirestore.instance
            .collection(
                "userSSS") // Replace "your_collection" with your actual collection name
            .doc(data["uidFarmer"]);
        DocumentSnapshot docSnapshotUser = await docRefUser.get();
        Map<String, dynamic>? dataUSER =
            docSnapshotUser.data() as Map<String, dynamic>?;
        dynamic specificDataUser = dataUSER!['balance'];
        // Reference to the document you want to retrieve data from
        DocumentReference docRef = FirebaseFirestore.instance
            .collection(
                "postSSS") // Replace "your_collection" with your actual collection name
            .doc(data[
                "postUid"]); // Replace "your_document_id" with your actual document ID
        print("postUid  Data: ${data["postUid"]}");

        // Fetch the document snapshot
        DocumentSnapshot docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          // Access specific fields from the document snapshot
          Map<String, dynamic>? dataa =
              docSnapshot.data() as Map<String, dynamic>?;
          if (dataa != null) {
            dynamic specificData = dataa['quntity'];
            currentQuantity = specificData
                .toString(); // Replace "specific_field" with the field you want to retrieve
            print("currentQuantity: $currentQuantity");

            if (int.parse(currentQuantity) == 0) {
              showSnackBar(
                  context, "The product  ${data["prodactName"]} is sold");
            } else if (int.parse(currentQuantity) <
                int.parse(data["partquntity"])) {
              showSnackBar(context,
                  "Please reorder the product From Home page ${data["prodactName"]}");
            } else if (int.parse(currentQuantity) == 0 ||
                int.parse(currentQuantity) < int.parse(data["partquntity"])) {
              await FirebaseFirestore.instance
                  .collection('cartSSS')
                  .doc(document.id)
                  .delete();
            } else {
              int newQuantity =
                  int.parse(currentQuantity) - int.parse(data["partquntity"]);

              await FirebaseFirestore.instance
                  .collection("postSSS")
                  .doc(data["postUid"])
                  .update({"quntity": newQuantity.toString()});

              await FirebaseFirestore.instance
                  .collection('userSSS')
                  .doc(data["uidStorOwner"])
                  .update({
                "balance": specificDataUser -
                    (double.parse(data["price"]) *
                        double.parse(data["partquntity"]))
              });
            }
          } else {
            print('Document data is null');
          }
        } else {
          print('Document does not exist');
        }
      } catch (error) {
        print('Error fetching data: $error');
      }

      // Create a new document in the destination collection with the same data
      await FirebaseFirestore.instance.collection('RequstedDDD').add(data);

      await FirebaseFirestore.instance
          .collection('cartSSS')
          .doc(document.id)
          .delete();
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///
    ///
    ///
    ///
    ///
    ///
  }

  deleteItemFromCart({required doc}) async {
    await FirebaseFirestore.instance
        .collection("cartSSS")
        .doc(doc)//snapshot.data!.docs[index].id
        .delete();
  }



  late Stream<QuerySnapshot> usersStream;

  void initializeStream() {
    usersStream = FirebaseFirestore.instance
        .collection('cartSSS')
        .where("uidStorOwner", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }








}
