import 'dart:io';

import 'package:equitysoft/model/product.dart';
import 'package:equitysoft/widget/productFormWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/productsProvider.dart';

class AddProductPage extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String quantity;
  final bool isEdit;
  AddProductPage(
      {Key? key,
      this.name = '',
      this.description = '',
      this.price = '',
      this.quantity = '',
      this.isEdit = false})
      : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String description = '';
  String price = '';
  String quantity = '';
  List<String> imagePath = [];
  String companyValue='Company Name';
  String categoryValue='Category';

  @override
  void initState() {
    productName = widget.name;
    description = widget.description;
    price = widget.price;
    quantity = widget.quantity;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.read<ProductsProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                Form(
                    key: _formKey,
                    child: ProductFormWidget(
                      onChangedname: (value) => setState(() =>productName=value),
                      companyValue: companyValue,
                      onChangedcomapany: (String? value) {
                        setState(() {
                          print(value);
                          companyValue = value!;
                        });
                      },
                      categoryValue: categoryValue,
                      onChangedcategory: (String? value) {
                        setState(() {
                          print(value);
                          categoryValue = value!;
                        });
                      },
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
                            imagePath.add(file.path);
                            // imagePath[0]=file.path;
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
                            imagePath.add(file.path);
                            // imagePath[1]=file.path;
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
                            imagePath.add(file.path);
                            // imagePath[2]=file.path;
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
                            imagePath.add(file.path);
                            // imagePath[3]=file.path;
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      imagePath: imagePath,
                      onChangedDescription: (value) => setState(() =>description=value),
                      onChangedprice: (value) => setState(() =>price=value),
                      onChangedquantity: (value) => setState(() =>quantity=value),
                      onSavedProduct: () {
                        final valid = _formKey.currentState!.validate();
                        if (widget.isEdit == false) {
                          if (valid) {
                            print('added');
                            final product = Product(
                              image1: imagePath.length>0?imagePath[0]:'',
                              image2: imagePath.length>1?imagePath[1]:'',
                              image3: imagePath.length>2?imagePath[2]:'',
                              image4: imagePath.length>3?imagePath[3]:'',
                              company: companyValue,
                                category: categoryValue,
                                name: productName,
                                description: description,
                                price: price,
                                quantity: quantity);
                            productsProvider.addProduct(product);
                            Navigator.pop(context);
                          }
                        }
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
