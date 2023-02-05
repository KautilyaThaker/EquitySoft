import 'package:equitysoft/model/company.dart';
import 'package:flutter/cupertino.dart';
import '../api/firebaseApi.dart';

class CompanyProvider extends ChangeNotifier{
  List<Company> _companyList= [];

  List<Company> get companyList{
    return _companyList;
  }

  void addCompany(Company company){
    // _companyList.add(company);
    FirebaseApi.createCompany(company);
    print('add complete');
    // notifyListeners();
  }

  void setCompany(List<Company> company){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _companyList.addAll(company);
      // print(_companyList);
      _companyList=company;
      notifyListeners();
    });
  }
  void removeCompany(Company company){
    // _companyList.remove(company);
    // print('remove Company complete');
    // notifyListeners();
    FirebaseApi.deleteCompany(company);
  }

}