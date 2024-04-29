// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project2/shared/colors.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  // late Prodact prodacts;
  // Details({required this.prodacts});

  @override
  State<Detail> createState() => _DetailsState();
}

class _DetailsState extends State<Detail> {
  bool showMore = true;
  final addQuantityControllar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 141, 95),
        title: Text("Details Item "),
        actions: [
          // AppBarRebited()
        ],
      ),
      body: Padding(
        padding: widthScreen > 600
            ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
            : const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset(widget.prodacts.pathImage),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ClipRRect(
                    child: Image.asset("assets/FlatParsley_1400x.webp"),
                    borderRadius: BorderRadius.circular(40)),
              ),

              Container(
                height: 600,
                decoration: BoxDecoration(
                  color: scaffoldColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color.fromARGB(255, 133, 114, 107), width: 3),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          // " \$${widget.prodacts.price}",
                          "Prodact Name ",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          // " \$${widget.prodacts.price}",
                          "\$5 ",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              height: 25,
                              width: 30,
                              child: Text("New"),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 129, 129),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 255, 191, 0),
                              size: 26,
                            ),
                            Icon(Icons.star,
                                color: Color.fromARGB(255, 255, 191, 0),
                                size: 26),
                            Icon(Icons.star,
                                color: Color.fromARGB(255, 255, 191, 0),
                                size: 26),
                            Icon(Icons.star,
                                color: Color.fromARGB(255, 255, 191, 0),
                                size: 26),
                            Icon(Icons.star,
                                color: Color.fromARGB(255, 255, 191, 0),
                                size: 26),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit_location,
                              color: Color.fromARGB(168, 3, 65, 27),
                              size: 26,
                            ),
                            // Text(widget.prodacts.location),
                            Text("location")
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        width: double.infinity,
                        child: Text(
                          "Details : ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.start,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(

                        color: Color.fromARGB(255, 73, 114, 87),
                        borderRadius: BorderRadius.circular(20)

                      ),
                      
                      child: Text(
                        "A flower, also known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers consist of a combination of vegetative organs – sepals that enclose and protect the developing flower, petals that attract pollinators, and reproductive organs that produce gametophytes, which in flowering plants produce gametes. The male gametophytes, which produce sperm, are enclosed within pollen grains produced in the anthers. The female gametophytes are contained within the ovules produced in the carpels.",
                        style: TextStyle(fontSize: 15),
                        maxLines: showMore ? 3 : null,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            showMore = !showMore;
                          });
                        },
                        child:
                            showMore ? Text("Show more") : Text("Show less")),
                    TextField(
                        controller: addQuantityControllar,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                
                          hintText: "Add quantity ",
                          prefixIcon: Icon(Icons.production_quantity_limits),
                          // To delete borders
                          enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: BTNgreen,
                            ),
                          ),
                          // fillColor: Colors.red,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        )),
                        SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10,horizontal: 30)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                      ),
                      child: Text(
                        "Add to Cart ",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
