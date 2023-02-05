import 'package:equitysoft/category/showCategoryPage.dart';
import 'package:equitysoft/company/showCompanyPage.dart';
import 'package:equitysoft/products/showProductsPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height*0.28;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  fixedSize: Size(size.width * 0.8, height)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowProductPage()));
              },
              child: Text('Products'),
            ),
            SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  fixedSize: Size(size.width * 0.8, height)),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowCategoryPage()));},
              child: Text('Manage Category'),
            ),
            SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  fixedSize: Size(size.width * 0.8, height)),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowCompanyPage()));},
              child: Text('Manage Company'),
            ),
          ],
        ),
      ),
    );
  }
}
