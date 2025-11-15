import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/shoe_detail.png',
                    // width: 100,
                    // height: 320,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(height: 19),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27.0),
                  child: Column(
                    spacing: 7,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mens's show",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),

                          Text(
                            "⭐(4.0)",
                            style: TextStyle(fontSize: 19, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Derby Leather", style: TextStyle(fontSize: 26)),
                          Text("\$120", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Size:", style: TextStyle(fontSize: 21)),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("39", style: TextStyle(fontSize: 26)),

                    Text("40", style: TextStyle(fontSize: 26)),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "41",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Text("42", style: TextStyle(fontSize: 26)),
                    Text("43", style: TextStyle(fontSize: 26)),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 13.0),
                  child: Column(
                    children: [
                      Text(
                        "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
                        style: TextStyle(
                          fontSize: 15,
                          decorationColor: Colors.amber,
                          color: const Color.fromARGB(255, 143, 141, 141),
                          // backgroundColor: Colors.limeAccent,
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  overlayColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor: Colors.red,
                                  // colo,
                                ),
                                child: Text("Delete"),
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  overlayColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  // colo,
                                ),
                                child: Text("Update"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 25,
              left: 25,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
