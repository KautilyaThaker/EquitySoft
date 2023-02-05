import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft/api/firebaseApi.dart';
import 'package:equitysoft/model/product.dart';
import 'package:equitysoft/products/detailScreen.dart';
import 'package:equitysoft/products/editProductPage.dart';
import 'package:equitysoft/provider/productsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addProductPage.dart';

class ShowProductPage extends StatefulWidget {
  const ShowProductPage({Key? key}) : super(key: key);

  @override
  State<ShowProductPage> createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = context.watch<ProductsProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductPage()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        // stream: FirebaseFirestore.instance.collection('Product').snapshots(),
        stream: FirebaseApi.readProduct(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            // print(snapshot.data);
            final products = snapshot.data;
            productsProvider.setProducts(products!);
          // print('snapshot.data : '+snapshot.data!.docs[0]['name'].toString());
          // final data = snapshot.data!.docs;
          // final pro = data.map((e) => Product.fromJson(e));
          return Container(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: productsProvider.products.length,
              itemBuilder: (BuildContext context, int index) {
                final products = productsProvider.products;
                final product = products[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailSceen(product: product)));
                  },
                  child: Card(
                    key: Key(product.id),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            // padding: EdgeInsets.all(20),
                            alignment: AlignmentDirectional.center,
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(10)),
                            child: product.image1==''?Text(
                              'image',
                              style: TextStyle(color: Colors.white),
                            ):
                            Image.file(
                              File(product.image1),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(product.name),
                                  Text(product.description),
                                  Text('${product.price}'),
                                  Text(product.company),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: size.width*0.25,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        fixedSize: Size(size.width * 0.15, size.height * 0.05),
                                        backgroundColor: Colors.brown,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditProductPage(product: product,)));
                                      },
                                      child: Text('Edit')),
                                ),
                                Container(
                                  width: size.width*0.25,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        fixedSize: Size(size.width * 0.15, size.height * 0.05),
                                        backgroundColor: Colors.brown,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        productsProvider.removeProduct(product);
                                      },
                                      child: Text('Delete')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        },
      ),
    );
  }
}
