import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String companyValue;
  final ValueChanged<String?> onChangedcomapany;
  final List<String> list;
  const Dropdown({Key? key, required this.onChangedcomapany, required this.list, required this.companyValue}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  // String companyValue='ufcuf';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical:4,horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          //   color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey[200],
        focusColor: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        value: widget.companyValue,
        icon: const Icon(Icons.arrow_drop_down,color: Colors.black,),
        elevation: 16,
        isExpanded: true,
        underline: Container(height: 0),
        // onChanged: (String? value) {
        //   setState(() {
        //     print(value);
        //     companyValue = value!;
        //   });
        // },
        onChanged: widget.onChangedcomapany,
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(color: Colors.black54),),
          );
        }).toList(),
      ),
    );
  }
}
