import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft/model/category.dart';
import 'package:equitysoft/model/company.dart';
import 'package:equitysoft/model/product.dart';
import 'package:equitysoft/utils.dart';


class FirebaseApi{

  static Future<String> createPrduct(Product product)async{
    final doc = FirebaseFirestore.instance.collection('Product').doc();
    product.id=doc.id;
    await doc.set(product.toJson());
    return doc.id;
  }

  static Stream<List<Product>> readProduct(){
    return FirebaseFirestore.instance
        .collection('Product').snapshots().transform(Utils.transformer((json) => Product.fromJson(json)));
  }
  static Future updateProduct(Product product)async{
    final doc = FirebaseFirestore.instance.collection('Product').doc(product.id);
    await doc.update(product.toJson());
  }
  static Future deleteProduct(Product product)async{
    final doc = FirebaseFirestore.instance.collection('Product').doc(product.id);
    await doc.delete();
  }
  static Future<String> createCompany(Company company)async{
    final doc = FirebaseFirestore.instance.collection('Company').doc();
    company.id=doc.id;
    await doc.set(company.toJson());
    return doc.id;
  }

  static Stream<List<Company>> readCompany(){
      return FirebaseFirestore.instance
          .collection('Company').snapshots().transform(Utils.transformer((json) => Company.fromJson(json)));
  }

  static Future deleteCompany(Company company)async{
    final doc = FirebaseFirestore.instance.collection('Company').doc(company.id);
    await doc.delete();
  }

  static Future<String> createCategory(CategoryModel category)async{
    final doc = FirebaseFirestore.instance.collection('Category').doc();
    category.id=doc.id;
    await doc.set(category.toJson());
    return doc.id;
  }

  static Stream<List<CategoryModel>> readCategory(){
    return FirebaseFirestore.instance.collection('Category').snapshots().transform(Utils.transformer((json) => CategoryModel.fromJson(json)));
  }

  static Future deleteCategory(CategoryModel category)async{
    final doc = FirebaseFirestore.instance.collection('Category').doc(category.id);
    await doc.delete();
  }
}