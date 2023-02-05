import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickImage extends StatefulWidget {
  final VoidCallback onSelectimage;
  final String path;
  const PickImage({Key? key, required this.onSelectimage, required this.path}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onSelectimage,
      child: Container(
        height: size.height*0.07,
        width: size.width*0.18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black,width: 0.5)
        ),
        child: widget.path==''?Icon(Icons.add):Image.file(
            File(widget.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
