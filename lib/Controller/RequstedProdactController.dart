import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project2/shared/Timer.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:url_launcher/url_launcher.dart';

class RequstedProdactConrtoller {
  late Map data;

  AcceptedRequst({required data, required doc}) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('notifiayYYY').add(data);
    String NotifayUid = docRef.id;

    await FirebaseFirestore.instance
        .collection("RequstedDDD")
        .doc(doc) //snapshot.data!.docs[index].id
        .set({
      "NotifiyProdactUid": NotifayUid,
      "requstedProdactUID": doc, //snapshot.data!.docs[index].id
      "farmerAcceptedRequest": true,
      "datePublished": DateTime.now()
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection("notifiayYYY")
        .doc(NotifayUid)
        .set({
      "requstedProdactUID": doc, //snapshot.data!.docs[index].id
      "NotifiyProdactUid": NotifayUid,
      'farmerAcceptedRequest': true,
      'farmerRejectedRequest': false,
      "datePublished": DateTime.now(),
    }, SetOptions(merge: true));

    DeleteItem(
        notifiyProdactUid: NotifayUid,
        hour: 12,
        seconds: 0,
        requstedProdactUid: doc);
  }

  RejectRequst({required data, required doc}) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('notifiayYYY').add(data);

    String NotifayUid = docRef.id;

    await FirebaseFirestore.instance
        .collection("RequstedDDD")
        .doc(doc) //snapshot.data!.docs[index].id
        .set({
      "NotifiyProdactUid": NotifayUid,
      "farmerRejectedRequest": true,
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection("notifiayYYY")
        .doc(NotifayUid)
        .set({
      "requstedProdactUID": doc, //snapshot.data!.docs[index].id
      "NotifiyProdactUid": NotifayUid,
      "farmerRejectedRequest": true,
    }, SetOptions(merge: true));

    String currentQuantity = "";

    DocumentReference docRefPost =
        FirebaseFirestore.instance.collection("postSSS").doc(data["postUid"]);

    DocumentSnapshot docSnapshotPost = await docRefPost.get();

    if (docSnapshotPost.exists) {
      // Access specific fields from the document snapshot
      Map<String, dynamic>? dataa =
          docSnapshotPost.data() as Map<String, dynamic>?;
      if (dataa != null) {
        dynamic specificData = dataa['quntity'];
        currentQuantity = specificData
            .toString(); // Replace "specific_field" with the field you want to retrieve
        print("currentQuantity: $currentQuantity");

        await FirebaseFirestore.instance
            .collection("postSSS")
            .doc(data["postUid"])
            .update({
          "quntity":
              (int.parse(currentQuantity) + int.parse(data["partquntity"]))
                  .toString()
        });

        DocumentReference docRefUser = FirebaseFirestore.instance
            .collection(
                "userSSS") // Replace "your_collection" with your actual collection name
            .doc(data["uidFarmer"]);
        DocumentSnapshot docSnapshotUser = await docRefUser.get();
        Map<String, dynamic>? dataUSER =
            docSnapshotUser.data() as Map<String, dynamic>?;
        dynamic specificDataUser = dataUSER!['balance'];

        await FirebaseFirestore.instance
            .collection('userSSS')
            .doc(data["uidStorOwner"])
            .update({
          "balance": specificDataUser +
              (double.parse(data["price"]) * double.parse(data["partquntity"]))
        });
      } else {
        print('Document data is null');
      }
    } else {
      print('Document does not exist');
    }

    // await FirebaseFirestore
    //     .instance
    //     .collection("postSSS")
    //     .doc(data["postUid"])
    //     .update({"quntity":});

    await FirebaseFirestore.instance
        .collection("RequstedDDD")
        .doc(doc) //snapshot.data!.docs[index].id
        .delete();

    DeleteItem(
        notifiyProdactUid: NotifayUid,
        hour: 12,
        seconds: 0,
        requstedProdactUid: doc); //snapshot.data!.docs[index].id
  }

  FarmerCheckDelivery({required data, required doc, required context}) async {
    late DocumentSnapshot documentSnapshot;

    await FirebaseFirestore.instance
        .collection('RequstedDDD')
        .doc(doc) //snapshot.data!.docs[index].id
        .set({"farmerCheckDelivery": true}, SetOptions(merge: true));

    //  await FirebaseFirestore
    //     .instance
    //     .collection(data[
    //         "NotifiyProdactUid"])
    //     .get();

    documentSnapshot = await FirebaseFirestore.instance
        .collection('notifiayYYY')
        .doc(data["NotifiyProdactUid"])
        .get();

    if (data["farmerCheckDelivery"] &&
        documentSnapshot.get('storeOwnerCheckDelivery')) {
      showSnackBar(context, "Delevary is Done ......");
    } else if (data["farmerCheckDelivery"] &&
        documentSnapshot.get('storeOwnerCheckDelivery') == false) {
      showSnackBar(context, "Store Owner is not check delivery ");
    }
  }

  whatsAppDelivery() {
    final Uri phoneNumber = Uri.parse("tel:0775218832");
    final Uri whatsApp = Uri.parse("https://wa.me/+962${data["phoneNumber"]}");
    launchUrl(whatsApp);
  }
}
