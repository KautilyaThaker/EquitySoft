import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft/api/firebaseApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [
    // Product(
    //   name: 'LQ LCO Monitor',
    //   description: 'description description',
    //   price: '15000',
    //   quantity: '2',
    //   company: 'Company Name',
    //   category: 'Category',
    //   image1: '',
    //   image2: '',
    //   image3: '',
    //   image4: '',
    // ),
    // Product(
    //   name: 'Iphone XR',
    //   description: 'IphoneXR description',
    //   price: '55000',
    //   quantity: '4',
    //   company: 'Company Name',
    //   category: 'Category',
    //   image1: '',
    //   image2: '',
    //   image3: '',
    //   image4: '',
    // ),
  ];

  List<Product> get products {
    return _products;
  }

  void addProduct(Product product) {
    // _products.add(product);
    // print('add complete');
    // notifyListeners();
    FirebaseApi.createPrduct(product);
  }

  void setProducts(List<Product> p){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _products=p;
      notifyListeners();
    });
  }
  void removeProduct(Product product) {
    // _products.remove(product);
    FirebaseApi.deleteProduct(product);
    print('remove complete complete');
    // notifyListeners();
  }

  void updateProduct(Product product, String name, String des, String price,
      String qty, String companyName, String category, List<String> imagePath) {
    product.name = name;
    product.description = des;
    product.price = price;
    product.quantity = qty;
    product.company = companyName;
    product.category = category;
    product.image1 = imagePath.length > 0 ? imagePath[0] : '';
    product.image2 = imagePath.length > 1 ? imagePath[1] : '';
    product.image3 = imagePath.length > 2 ? imagePath[2] : '';
    product.image4 = imagePath.length > 3 ? imagePath[3] : '';

    FirebaseApi.updateProduct(product);
    // notifyListeners();
  }
}
