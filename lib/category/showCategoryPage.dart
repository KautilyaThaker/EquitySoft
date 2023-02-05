import 'package:equitysoft/api/firebaseApi.dart';
import 'package:equitysoft/model/category.dart';
import 'package:equitysoft/provider/categoryProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCategoryPage extends StatefulWidget {
  const ShowCategoryPage({Key? key}) : super(key: key);

  @override
  State<ShowCategoryPage> createState() => _ShowCategoryPageState();
}

class _ShowCategoryPageState extends State<ShowCategoryPage> {
  String categoryName = '';
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormFieldState>();
    final categoryProvider = context.watch<CategoryProvider>();
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
          'Category',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                key: _formKey,
                validator: (value){
                  if(value == null ||value.isEmpty){
                    return 'Category Must be filled';
                  }else return null;
                },
                controller: _controller,
                onChanged: (value) => setState(() => categoryName = value),
                decoration: _buildInputDecoration('Category Name'),
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
                if(_formKey.currentState!.validate())
                  {
                    final category = CategoryModel(categoryName: categoryName);
                    categoryProvider.addCategory(category);
                    setState(() {
                      categoryName = '';
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

            SizedBox(height: 40),
            Container(
              child: Text('List of Categories'),
            ),
            Expanded(
              child: StreamBuilder<List<CategoryModel>>(
                stream: FirebaseApi.readCategory(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    final category = snapshot.data;
                    categoryProvider.setCategory(category!);
                    return Container(
                      padding: EdgeInsets.only(top: 12),
                      child: ListView.separated(
                        shrinkWrap: true,
                        // primary: false,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 5);
                        },
                        itemCount: categoryProvider.categoryList.length,
                        itemBuilder: (context, index) {
                          final companies = categoryProvider.categoryList;
                          final category = companies[index];
                          return  Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${category.categoryName}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    categoryProvider.removeCategory(category);
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
                    return Center(child: Text('Empty Category'));
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
