import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
                  controller: _nameController,
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
                  controller: _categoryController,
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
                  controller: _priceController,
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
                  controller: _descriptionController,
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
                  onPressed: () {
                    print(_nameController.text);
                    Navigator.pushNamed(
                      context,
                      "/",
                      arguments: {
                        'name': _nameController.text,
                        'price': _priceController.text,
                        'category': _categoryController.text,
                        'description': _descriptionController.text,
                      },
                    );
                    _nameController.clear();
                  },

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
