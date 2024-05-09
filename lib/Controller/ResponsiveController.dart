import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project2/shared/Timer.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ResponsiveController {
  late Map data;

  whatsAppMessage() {
    final Uri phoneNumber = Uri.parse("tel:0775218832");
    final Uri whatsApp = Uri.parse("https://wa.me/+962${data["phoneNumber"]}");
    launchUrl(whatsApp);
  }

  StoreOwnerCheckDelivery({required data, required doc ,required context }) async {
    late DocumentSnapshot documentSnapshot;

    await FirebaseFirestore.instance
        .collection('notifiayYYY')
        .doc(doc)//snapshot.data!.docs[index].id
        .update({"storeOwnerCheckDelivery": true});
    documentSnapshot = await FirebaseFirestore.instance
        .collection('RequstedDDD')
        .doc(data["requstedProdactUID"])
        .get();

    if (data["storeOwnerCheckDelivery"] &&
        documentSnapshot.get('farmerCheckDelivery')) {
      showSnackBar(context, "Delevdeliveryary is Done ......");

      DeleteItem(
          notifiyProdactUid:doc,
          requstedProdactUid: data["requstedProdactUID"],
          seconds: 1);
    } else if (data["storeOwnerCheckDelivery"] &&
        documentSnapshot.get('farmerCheckDelivery') == false) {
      showSnackBar(context, "Farmer  is not check delivery ");
    }
  }
}
