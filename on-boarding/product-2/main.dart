import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String newName) => _name = newName;
  set description(String newDescription) => _description = newDescription;
  set price(double newPrice) => _price = newPrice;

  void display() {
    print('\nName: $_name');
    print('Description: $_description');
    print('Price: \$${_price.toStringAsFixed(2)}');
  }
}

class ProductManager {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('\nNo products found.');
    } else {
      print('\nProducts:');
      for (var i = 0; i < _products.length; i++) {
        print('\nProduct ${i + 1}');
        _products[i].display();
      }
    }
  }

  void viewSingleProduct(int id) {
    if (id < 0 || id >= _products.length) {
      print('\nInvalid product id.');
    } else {
      print('\nProduct info:');
      _products[id].display();
    }
  }

  void editProduct(int id, String name, String description, double price) {
    if (id < 0 || id >= _products.length) {
      print('\nInvalid id.');
    } else {
      _products[id].name = name;
      _products[id].description = description;
      _products[id].price = price;
      print('\nProduct updated');
    }
  }

  void deleteProduct(int id) {
    if (id < 0 || id >= _products.length) {
      print('\nInvali id.');
    } else {
      print('\nProduct deleted');
      _products.removeAt(id);
    }
  }
}

void main() {
  final manager = ProductManager();

  while (true) {
    print('''
1. Add Product
2. View All Products
3. View Single Product
4. Edit Product
5. Delete Product
6. Exit

Enter your choice:
''');

    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        var name = stdin.readLineSync() ?? '';

        stdout.write('Enter description: ');
        var description = stdin.readLineSync() ?? '';

        stdout.write('Enter price: ');
        var priceInput = stdin.readLineSync() ?? '0';
        var price = double.tryParse(priceInput) ?? 0;

        manager.addProduct(Product(name, description, price));
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        stdout.write('Enter id: ');
        var id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        manager.viewSingleProduct(id - 1);
        break;

      case '4':
        stdout.write('Enter id to edit: ');
        var id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

        stdout.write('Enter new name: ');
        var name = stdin.readLineSync() ?? '';

        stdout.write('Enter new description: ');
        var desc = stdin.readLineSync() ?? '';

        stdout.write('Enter new price: ');
        var price = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

        manager.editProduct(id - 1, name, desc, price);
        break;

      case '5':
        stdout.write('Enter id to delete: ');
        var id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        manager.deleteProduct(id - 1);
        break;

      case '6':
        return;

      default:
        print('\n Invalid choice.');
    }
  }
}
