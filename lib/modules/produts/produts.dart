import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // CarouselSlider(
          //   options: CarouselOptions(height: 200.0),
          //   items: [1,2,].map((i) {
          //     return Builder( builder: (BuildContext context) =>
          //          Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: MediaQuery.of(context).size.height* 0.1,
          //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
          //             decoration: const BoxDecoration(
          //               color: Colors.green
          //             ),
          //             child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
          //         ),
          //
          //     );
          //   }).toList(),
          // ),
          CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height* .2,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                reverse: false,
                autoPlayAnimationDuration:const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal
              ) ,
              items:const[
                Image(image: AssetImage('assets/images/3776133.jpg')),
                Image(image: AssetImage('assets/images/4058271.jpg')),
                Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
                Image(image: AssetImage('assets/images/3859310.jpg'),)
              ]
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children:const [
                Image(image: AssetImage('assets/images/3859310.jpg')),
                Image(image: AssetImage('assets/images/3776133.jpg')),
                Image(image: AssetImage('assets/images/4058271.jpg')),
                Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
                Image(image: AssetImage('assets/images/3859310.jpg'),),
                Image(image: AssetImage('assets/images/3859310.jpg')),
                Image(image: AssetImage('assets/images/3776133.jpg')),
                Image(image: AssetImage('assets/images/4058271.jpg')),
                Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
                Image(image: AssetImage('assets/images/3859310.jpg'),),      Image(image: AssetImage('assets/images/3859310.jpg')),
                Image(image: AssetImage('assets/images/3776133.jpg')),
                Image(image: AssetImage('assets/images/4058271.jpg')),
                Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
                Image(image: AssetImage('assets/images/3859310.jpg'),),
                Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
