
/////////////////////////////post//////////////////////////////////////
///

// Container(
                    //   decoration: BoxDecoration(
                    //       color: contantPost,
                    //       borderRadius: BorderRadius.circular(30)),
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 16, horizontal: 13),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   //  padding: EdgeInsets.all(1),
                    //                   decoration: BoxDecoration(
                    //                     shape: BoxShape.circle,
                    //                     color: Color.fromARGB(125, 78, 91, 110),
                    //                   ),
                    //                   child: CircleAvatar(
                    //                     radius: 33,
                    //                     backgroundImage: NetworkImage(
                    //                         // widget.snap["profileImg"],
                    //                         "https://i.pinimg.com/564x/94/df/a7/94dfa775f1bad7d81aa9898323f6f359.jpg"),
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 17,
                    //                 ),
                    //                 Text(
                    //                   // widget.snap["username"],
                    //                   "Omar Essam",
                    //                   style: TextStyle(fontSize: 15),
                    //                 ),
                    //               ],
                    //             ),
                    //             IconButton(
                    //                 onPressed: () {},
                    //                 icon: Icon(Icons.more_vert)),
                    //           ],
                    //         ),
                    //       ),
                    //       Image.asset(
                    //         // widget.snap["postUrl"],
                    //         "assets/FlatParsley_1400x.webp",
                    //         fit: BoxFit.cover,

                    //         height: MediaQuery.of(context).size.height * 0.35,
                    //         width: double.infinity,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 11),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 IconButton(
                    //                   onPressed: () {},
                    //                   icon: Icon(Icons.favorite_border),
                    //                 ),
                    //                 IconButton(
                    //                   onPressed: () {},
                    //                   icon: Icon(
                    //                     Icons.comment_outlined,
                    //                   ),
                    //                 ),
                    //                 IconButton(
                    //                   onPressed: () {},
                    //                   icon: Icon(
                    //                     Icons.send,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             IconButton(
                    //               onPressed: () {},
                    //               icon: Icon(Icons.bookmark_outline),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //           margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    //           width: double.infinity,
                    //           child: Text(
                    //             "10 Likes",
                    //             textAlign: TextAlign.start,
                    //             style: TextStyle(
                    //                 fontSize: 18,
                    //                 color: Color.fromARGB(214, 157, 157, 165)),
                    //           )),
                    //       Row(
                    //         children: [
                    //           SizedBox(
                    //             width: 9,
                    //           ),
                    //           Text(
                    //             // "${widget.snap["username"]}",
                    //             "USERNAME ",
                    //             textAlign: TextAlign.start,
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 color: Color.fromARGB(255, 189, 196, 199)),
                    //           ),
                    //           Text(
                    //             // " ${widget.snap["description"]}",
                    //             " Sidi Bou Said ♥",
                    //             textAlign: TextAlign.start,
                    //             style: TextStyle(
                    //                 fontSize: 18,
                    //                 color: Color.fromARGB(255, 189, 196, 199)),
                    //           ),
                    //         ],
                    //       ),
                    //       //            GestureDetector(
                    //       //              onTap: () {},
                    //       //              child: Container(
                    //       // margin: EdgeInsets.fromLTRB(10, 13, 9, 10),
                    //       // width: double.infinity,
                    //       // child: Text(
                    //       //   "view all 100 comments",
                    //       //   style: TextStyle(
                    //       //       fontSize: 18,
                    //       //       color: Color.fromARGB(214, 157, 157, 165)),
                    //       //   textAlign: TextAlign.start,
                    //       // )),
                    //       //            ),
                    //       Container(
                    //           margin: EdgeInsets.fromLTRB(10, 0, 9, 10),
                    //           width: double.infinity,
                    //           child: Text(
                    //             "10June 2022",
                    //             style: TextStyle(
                    //                 fontSize: 18,
                    //                 color: Color.fromARGB(214, 157, 157, 165)),
                    //             textAlign: TextAlign.start,
                    //           )),
                    //     ],
                    //   ),
                    // ),














// class UserInformation extends StatefulWidget {
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   late final Stream<QuerySnapshot> _usersStream;

//   @override
//   void initState() {
//     super.initState();
//     _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (BuildContext context, int index) {
//             Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//             return ListTile(
//               title: Text(data['full_name']),
//               subtitle: Text(data['company']),
//             );
//           },
//         );
//       },
//     );
//   }
// }












// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> moveData() async {
//   // Retrieve data from the source collection
//   QuerySnapshot sourceSnapshot = await FirebaseFirestore.instance.collection('sourceCollection').get();

//   // Iterate through each document in the source collection
//   for (QueryDocumentSnapshot document in sourceSnapshot.docs) {
//     // Get the data of the document
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;

//     // Create a new document in the destination collection with the same data
//     await FirebaseFirestore.instance.collection('destinationCollection').add(data);

//     // Optionally, delete the original document from the source collection
//     // await document.reference.delete();
//   }
// }

// // Call the function to move data
// moveData();

