import 'package:equitysoft/api/firebaseApi.dart';
import 'package:equitysoft/model/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier{
  List<CategoryModel> _categoryList= [];

  List<CategoryModel> get categoryList{
    return _categoryList;
  }

  void addCategory(CategoryModel category){
    // _categoryList.add(category);
    FirebaseApi.createCategory(category);
    print('add complete');
    // notifyListeners();
  }

  void setCategory(List<CategoryModel> category){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _companyList.addAll(company);
      // print(_companyList);
      _categoryList=category;
      notifyListeners();
    });
  }


  void removeCategory(CategoryModel category){
    FirebaseApi.deleteCategory(category);
    print('remove sucessfull');
    // _categoryList.remove(category);
    // print('remove category');
    // notifyListeners();
  }

}