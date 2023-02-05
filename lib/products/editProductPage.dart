import 'dart:io';

import 'package:equitysoft/products/addProductPage.dart';
import 'package:equitysoft/widget/productFormWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/productsProvider.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();

  String productName = '';
  String companyValue = 'Company Name';
  String categoryValue = 'Category';
  String price = '';
  String quantity = '';
  String description = '';
  List<String> imagePath=[];

  @override
  void initState() {
    productName = widget.product.name;
    description = widget.product.description;
    price = widget.product.price;
    quantity = widget.product.quantity;
    companyValue = widget.product.company;
    categoryValue = widget.product.category;
    imagePath.add(widget.product.image1);
    imagePath.add(widget.product.image2);
    imagePath.add(widget.product.image3);
    imagePath.add(widget.product.image4);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(categoryValue);
    print(companyValue);
    final productsProvider = context.read<ProductsProvider>();
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
          'Update Product',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: ProductFormWidget(
                onSelectimage1: ()async{
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type:FileType.image,
                    allowMultiple: false,
                    allowCompression:false,
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    print(file.path);
                    setState(() {
                      // path=file.path;
                      // imagePath.add(file.path);
                      if(imagePath.length>0){
                      imagePath[0]=file.path;
                      }
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                onSelectimage2: ()async{
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type:FileType.image,
                    allowMultiple: false,
                    allowCompression:false,
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    print(file.path);
                    setState(() {
                      // path=file.path;
                      // imagePath.add(file.path);
                      if(imagePath.length>1){
                        imagePath[1]=file.path;
                      }
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                onSelectimage3: ()async{
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type:FileType.image,
                    allowMultiple: false,
                    allowCompression:false,
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    print(file.path);
                    setState(() {
                      // path=file.path;
                      // imagePath.add(file.path);
                      if(imagePath.length>2){
                        imagePath[2]=file.path;
                      }
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                onSelectimage4: ()async{
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type:FileType.image,
                    allowMultiple: false,
                    allowCompression:false,
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    print(file.path);
                    setState(() {
                      // path=file.path;
                      // imagePath.add(file.path);
                      if(imagePath.length>3){
                        imagePath[3]=file.path;
                      }
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                imagePath: imagePath,
                description: description ?? '',
                price: price ?? '',
                quantity: quantity ?? '',
                productName: productName ?? '',
                companyValue: companyValue,
                categoryValue: categoryValue,
                onChangedcategory: (String? value) {
                  setState(() {
                    categoryValue = value!;
                    print(categoryValue);
                  });
                },
                onChangedname: (value) => setState(() => productName = value),
                onChangedcomapany: (String? value) {
                  setState(() {
                    companyValue = value!;
                    print(companyValue);
                  });
                },
                onChangedDescription: (value) => setState(() => description = value),
                onChangedprice: (value) => setState(() => price = value),
                onChangedquantity: (value) => setState(() => quantity = value),
                onSavedProduct: () {
                  if(_formKey.currentState!.validate())
                    {
                      print('updated');
                      productsProvider.updateProduct(widget.product, productName,
                          description, price, quantity,companyValue,categoryValue,imagePath);
                      Navigator.pop(context);
                    }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
