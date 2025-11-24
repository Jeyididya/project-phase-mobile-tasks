import 'package:flutter/material.dart';
import 'package:task_6/pages/add_product.dart';
import 'package:task_6/pages/product_detail.dart';
import 'package:task_6/pages/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.name,
    this.category,
    this.price,
    this.desciption,
  });

  final String? name;
  final String? category;
  final String? price;
  final String? desciption;

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    Map<String, String>? cardArgs;

    if (args != null && args.isNotEmpty) {
      cardArgs = args;
    } else if (name != null ||
        category != null ||
        price != null ||
        desciption != null) {
      cardArgs = {
        'name': name ?? '',
        'category': category ?? '',
        'price': price ?? '',
        'description': desciption ?? '',
      };
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey,
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(""),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('July 14, 2023', style: TextStyle(fontSize: 12)),
                SizedBox(height: 5),
                Text('Hello, Yohannes', style: TextStyle(fontSize: 19)),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(Icons.notifications_outlined, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Available products", style: TextStyle(fontSize: 26)),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: SizedBox(
                        height: 38,
                        width: 38,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/search');
                          },
                          icon: Icon(Icons.search),
                          color: Colors.grey,
                          style: ButtonStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (cardArgs != null) _buildCardWidget(context, cardArgs),

                _buildCardWidget(context),
                _buildCardWidget(context),
                _buildCardWidget(context),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
  }
}

Widget _buildCardWidget(BuildContext context, [Map<String, String>? args]) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/detail', arguments: args);
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset('assets/men_shoe.png', fit: BoxFit.fitWidth),
          ),
          SizedBox(height: 10),
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
                      Text(
                        args?['name'] ?? 'Derby Leather Shoes',
                        style: TextStyle(fontSize: 21),
                      ),
                      Text(
                        '\$${args?['price'] ?? '120'}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        args?['category'] ?? 'Men\'s shoe',
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
    ),
  );
}
