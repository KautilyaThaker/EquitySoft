import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/productsProvider.dart';
import 'editProductPage.dart';

class DetailSceen extends StatefulWidget {
  final Product product;
  const DetailSceen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailSceen> createState() => _DetailSceenState();
}

class _DetailSceenState extends State<DetailSceen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();
    final urlImages = [
      widget.product.image1 ?? '',
      widget.product.image2 ?? '',
      widget.product.image3 ?? '',
      widget.product.image4 ?? ''
    ];
    final images = urlImages.where((element) => element != '');
    Size size = MediaQuery.of(context).size;
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
          'Detail Screen',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: images.isEmpty
                      ? Container(
                    child: Center(child: Text('No Images',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),),
                  )
                      : CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = urlImages[index];
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              color: Colors.grey,
                              child: Image.file(
                                File(urlImage),
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            height: size.height * 0.25,
                            autoPlay: true,
                            // enableInfiniteScroll: false,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 3),
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 22),
                        ),
                        Text('Price: ' + widget.product.price,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    Container(
                      // color: Colors.green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.company,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 22)),
                          Text('QTY: ' + widget.product.quantity,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 22)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text('Description:', style: TextStyle(fontSize: 22)),
                Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.product.description,
                    maxLines: 10,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size(size.width * 0.4, size.height * 0.05),
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProductPage(product: widget.product,)));
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size(size.width * 0.4, size.height * 0.05),
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    productsProvider.removeProduct(widget.product);
                    Navigator.pop(context);
                  },
                  child: Text('Delete',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
