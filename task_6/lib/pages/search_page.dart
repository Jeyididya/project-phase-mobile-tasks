import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Search Product")),
        actions: [],

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: TextField(
                              decoration: InputDecoration(
                                label: Text("Leather"),
                                border: OutlineInputBorder(),

                                suffixIcon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            border: BoxBorder.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ),
                  _buildCardWidget(context),
                  _buildCardWidget(context),
                  // _buildCardWidget(context),

                  // IconButton(onPressed: () {}, icon: Icon(Icons.line_weight_sharp)),
                ],
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildFilterCardWidget(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCardWidget(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.zero,
          child: Image.asset(
            'assets/men_shoe.png',
            // width: 100,
            // height: 120,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Derby Leather Shoes', style: TextStyle(fontSize: 21)),
                    Text('\$120', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Men\'s shoe',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        Text("(4.0)"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFilterCardWidget(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text("Category", style: TextStyle(fontSize: 18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text("Price", style: TextStyle(fontSize: 18)),
            ),
          ),

          RangeSlider(
            values: RangeValues(0.1, 0.6),
            onChanged: (newvalues) {},
            activeColor: Colors.deepPurple,
          ),

          SizedBox(
            width: 340,
            child: OutlinedButton(
              onPressed: () {},
              child: Text("Apply", style: TextStyle(color: Colors.white)),

              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
