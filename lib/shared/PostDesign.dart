// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:graduation_project2/pages/ProdactDetails.dart';
import 'package:graduation_project2/shared/colors.dart';

import 'package:intl/intl.dart';

class PostDesign extends StatefulWidget {
  // current post
  final Map data;
  const PostDesign({Key? key, required this.data}) : super(key: key);

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  int commentCount = 0;
  bool showHeart = false;
  bool isLikeAnimating = false;

  getCommentCount() async {
    try {
      QuerySnapshot commentdata = await FirebaseFirestore.instance
          .collection("postSSS")
          .doc(widget.data["postId"])
          .collection("commentSSS")
          .get();

      setState(() {
        commentCount = commentdata.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  showmodel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            FirebaseAuth.instance.currentUser!.uid == widget.data["uid"]
                ? SimpleDialogOption(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await FirebaseFirestore.instance
                          .collection("postSSS")
                          .doc(widget.data["postId"])
                          .delete();
                    },
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "Delete post",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                : const SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Can not delete this post ✋",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  onClickekonPic() async {
    setState(() {
      isLikeAnimating = true;
    });
    await FirebaseFirestore.instance
        .collection("postSSS")
        .doc(widget.data["postId"])
        .update({
      "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCommentCount();
  // }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return

        //  Text("omarr");
        Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: contantPost, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      //  padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110),
                      ),
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: NetworkImage(
                          widget.data["profileImg"],
                          // "https://i.pinimg.com/564x/94/df/a7/94dfa775f1bad7d81aa9898323f6f359.jpg"
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      widget.data["username"],
                      // "Omar Essam",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      showmodel();
                    },
                    icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          Image.network(
            widget.data["imgPost"],
            // "assets/FlatParsley_1400x.webp",
            fit: BoxFit.cover,

            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(data: widget.data),
                            ));
                      },
                      icon: Icon(
                        Icons.inventory_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: double.infinity,
              child: Text(
                "10 Likes",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
              )),
          Row(
            children: [
              SizedBox(
                width: 9,
              ),
              Text(
                "${widget.data["username"]}",
                // "USERNAME ",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 189, 196, 199)),
              ),
              Text(
                " ${widget.data["caption"]}",
                // " Sidi Bou Said ♥",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 189, 196, 199)),
              ),
            ],
          ),
          //            GestureDetector(
          //              onTap: () {},
          //              child: Container(
          // margin: EdgeInsets.fromLTRB(10, 13, 9, 10),
          // width: double.infinity,
          // child: Text(
          //   "view all 100 comments",
          //   style: TextStyle(
          //       fontSize: 18,
          //       color: Color.fromARGB(214, 157, 157, 165)),
          //   textAlign: TextAlign.start,
          // )),
          //            ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 0, 9, 10),
              width: double.infinity,
              child: Text(
                DateFormat('MMMM d, ' 'y')
                    .format(widget.data["datePublished"].toDate()),
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                textAlign: TextAlign.start,
              )),
        ],
      ),
    );
  }
}
