import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: SizedBox(
                  height: 200,
                  width: 400,
                  child: Card(
                    color: Colors.grey[70],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined),
                        Text("Upload Image"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("name"),
              SizedBox(
                height: 46,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[70],
                    filled: true,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("category"),
              SizedBox(
                height: 46,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[70],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("price"),
              SizedBox(
                height: 46,
                child: TextField(
                  decoration: InputDecoration(
                    // suffix: Icon(Icons.money),
                    suffixText: "\$",
                    fillColor: Colors.grey[70],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("description"),

              SizedBox(
                height: 170,
                child: TextField(
                  minLines: 6,
                  maxLines: 12,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[70],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                child: OutlinedButton(
                  onPressed: () {},

                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("ADD", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                width: 500,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("DELETE"),

                  style: OutlinedButton.styleFrom(
                    overlayColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.red,
                    // colo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
