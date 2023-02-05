import 'dart:io';

import 'package:equitysoft/provider/companyProvider.dart';
import 'package:equitysoft/widget/dropdown.dart';
import 'package:equitysoft/widget/pickImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../provider/categoryProvider.dart';

class ProductFormWidget extends StatelessWidget {
  final String productName;
  final String companyValue;
  final String categoryValue;
  final String description;
  final String price;
  final String quantity;
  final List<String> imagePath;
  final ValueChanged<String> onChangedname;
  final ValueChanged<String?> onChangedcomapany;
  final ValueChanged<String?> onChangedcategory;
  final ValueChanged<String> onChangedprice;
  final ValueChanged<String> onChangedquantity;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedProduct;
  final VoidCallback onSelectimage1;
  final VoidCallback onSelectimage2;
  final VoidCallback onSelectimage3;
  final VoidCallback onSelectimage4;
  const ProductFormWidget({
    Key? key,
     this.productName='',
    required this.companyValue,//='Company Name',
    required this.categoryValue,//='Category',
     this.description='',
     this.price='',
     this.quantity='',
    this.imagePath=const[],
    required this.onChangedname,
    required this.onChangedcomapany,
    required this.onSelectimage1,
    required this.onSelectimage2,
    required this.onSelectimage3,
    required this.onSelectimage4,
    required this.onChangedcategory,
    required this.onChangedprice,
    required this.onChangedquantity,
    required this.onChangedDescription,
    required this.onSavedProduct,
  }) : super(key: key);

    // List<String> comp = ['Company Name'];
  @override
  Widget build(BuildContext context) {
    final companyProvider = context.read<CompanyProvider>();
    final categoryProvider = context.read<CategoryProvider>();
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*required';
                }
                return null;
              },
              onChanged: onChangedname,
              initialValue: productName,
              decoration: _buildInputDecoration('Product Name'),
            ),
          ),
          Dropdown(onChangedcomapany: onChangedcomapany, list: companyList(companyProvider.companyList.map((e) => e.companyName.toString()).toList()),companyValue: companyValue),
          Dropdown(onChangedcomapany: onChangedcategory, list: categoryList(categoryProvider.categoryList.map((e) => e.categoryName.toString()).toList()),companyValue: categoryValue),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: TextFormField(
              onChanged: onChangedDescription,
              initialValue: description,
              maxLines: 4,
              decoration: _buildInputDecoration('Description'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty ) {
                  return '*required';
                }
                return null;
              },
              onChanged: onChangedprice,
              initialValue: price,
              decoration: _buildInputDecoration('Price'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*required';
                }
                return null;
              },
              onChanged: onChangedquantity,
              initialValue: quantity,
              decoration: _buildInputDecoration('Qty'),
            ),
          ),
          Text('Uploade Images:'),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PickImage(onSelectimage: onSelectimage1,path: (imagePath.length>0)?imagePath[0]:''),
                PickImage(onSelectimage: onSelectimage2,path: (imagePath.length>1)?imagePath[1]:''),
                PickImage(onSelectimage: onSelectimage3,path: (imagePath.length>2)?imagePath[2]:''),
                PickImage(onSelectimage: onSelectimage4,path: (imagePath.length>3)?imagePath[3]:''),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                fixedSize: Size(size.width * 0.95, 30)),
            onPressed: onSavedProduct,
            child: Text(
              'Save',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  InputDecoration _buildInputDecoration(String text) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      labelText: text ?? 'label',
      hintText: text ?? 'hint',
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10.0)),
    );
  }
  List<String> companyList(List<String> company){

    final List<String> list = ['Company Name'];
    print(company);
    list.addAll(company);
    print('comapny list :'+list.toString());
    return list;
  }
  List<String> categoryList(List<String> category){

    final List<String> list = ['Category'];
    print(category);
    list.addAll(category);
    print('category list :'+list.toString());
    return list;
  }
}
