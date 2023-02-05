import 'package:equitysoft/api/firebaseApi.dart';
import 'package:equitysoft/model/company.dart';
import 'package:equitysoft/provider/companyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCompanyPage extends StatefulWidget {
  const ShowCompanyPage({Key? key}) : super(key: key);

  @override
  State<ShowCompanyPage> createState() => _ShowCompanyPageState();
}

class _ShowCompanyPageState extends State<ShowCompanyPage> {
  String companyName = '';
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormFieldState>();
    final companyProvider = context.watch<CompanyProvider>();
    final Size size = MediaQuery.of(context).size;
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
          'Company',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                key: _formkey,
                validator: (value){
                  if(value==null||value.isEmpty){
                    return 'Company Name must be filled';
                  }else {return null;}
                },
                controller: _controller,
                onChanged: (value) => setState(() => companyName = value),
                decoration: _buildInputDecoration('Company Name'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  fixedSize: Size(size.width * 0.95, 30)),
              onPressed: () {
                if(_formkey.currentState!.validate()){
                  final company = Company(companyName: companyName);
                  companyProvider.addCompany(company);
                  setState(() {
                    companyName = '';
                    _controller.text = '';
                  });
                }
              },
              child: Text(
                'Add',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text('List of Companies'),
            ),
            Expanded(
              child: StreamBuilder<List<Company>>(
                stream: FirebaseApi.readCompany(),
                builder: (context,snapshot){
                    // print(snapshot.data);
                  if(snapshot.hasData){
                    final companies = snapshot.data;
                    companyProvider.setCompany(companies!);
                    return Container(
                      padding: EdgeInsets.only(top: 12),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 5);
                        },
                        itemCount: companyProvider.companyList.length,
                        itemBuilder: (context, index) {
                          // print(companyProvider.companyList.length);
                          final companies = companyProvider.companyList;
                          final company = companies[index];
                          return Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${company.companyName}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    companyProvider.removeCompany(company);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )),
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
            )
          ],
        ),
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
}
