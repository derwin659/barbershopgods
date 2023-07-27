
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cloud_firestore/banner_ref.dart';
import '../cloud_firestore/lookbook_ref.dart';
import '../model/ListCategoria.dart';
import '../model/image_model.dart';

class GridCategory extends StatefulWidget {
  const GridCategory({Key? key}) : super(key: key);

  @override
  State<GridCategory> createState() => _GridCategoryState();
}

class _GridCategoryState extends State<GridCategory> {

  final numbers=List.generate(3, (index) => '$index');
  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      appBar: AppBar(
        title: Text('Catalogo'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.black,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(

              Icons.home,
              color: Colors.red,
            ),
            Icon(Icons.book_online, color: Colors.red),
            Icon(Icons.history, color: Colors.red)
          ],
        )
    ,
      body: FutureBuilder(
          future: getLookbook(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var banners = snapshot.data as List<ImageModel>;

              return GridView.builder(

              padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                itemCount: banners.length,
                itemBuilder: (context,index){

                  return Container(
                    color:Colors.blueGrey,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(image: NetworkImage(banners[index].image),fit: BoxFit.cover))
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                    crossAxisCount: 2,crossAxisSpacing: 10,
                childAspectRatio: 1),
              );
            }
          })

    );
  }




}
