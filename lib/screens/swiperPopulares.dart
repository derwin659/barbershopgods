

import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class swiperPopulares extends StatelessWidget {

  final controller =PageController(
  initialPage: 1,
    viewportFraction: 2

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return PageView(
            children: [
                Text('Cortes más Populares')
            ],
          );

        },
        itemCount: 2,
      ),
    );
  }
}
