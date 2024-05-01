import 'package:flutter/material.dart';
import 'package:graduation_project2/Provider/UserProvider.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';
import 'package:provider/provider.dart';

class Resposive extends StatefulWidget {
  final Widget myMobileScreen;
  final Widget myWebScreen;

  const Resposive(
      {Key? key, required this.myMobileScreen, required this.myWebScreen})
      : super(key: key);

  @override
  State<Resposive> createState() => _ResposiveState();
}

class _ResposiveState extends State<Resposive> {
  // To get data from DB using provider
  getDataFromDB() async {
    try {
      UserProvider userProvider = Provider.of(context, listen: false);
      await userProvider.refreshUser();
      // print("222222222222222222222222222222222222${userProvider.getUser!.email}");
    } catch (e) {
      showSnackBar(
        context,"provider "
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
      if (boxConstraints.maxWidth > 600) {
        return widget.myWebScreen;
      } else {
        return widget.myMobileScreen;
      }
    });
  }
}
