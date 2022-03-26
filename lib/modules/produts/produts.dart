import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/home/HomeModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (BuildContext context) => productsBuilder(cubit.homeModel),
          fallback: (BuildContext context) => Column(
            children: [
              Center(
                child: Image.asset('assets/images/loading1.gif'),
              ),
              Text('Loading...' , style: Theme.of(context).textTheme.bodyText1,)
            ],
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel homeModel) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                height: 200,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics (),
              childAspectRatio: 1/1.1,
              mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 2,
                children: List.generate(
                  homeModel.data.products.length,
                  (index) => gridViewProductsBuilder( homeModel.data.products[index] ),
                ),
            ),
          ],
        ),
      );

  Widget gridViewProductsBuilder(Products products,)=>
      Column(
    children: [
      Image.network(
        products.image ,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
      Text(
        products.name ,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      Text(''
          '${products.price.round()}',
      ),

    ],
  );
}
//GridView.count(
//         physics: const BouncingScrollPhysics(),
//         crossAxisCount: 2,
//         mainAxisSpacing: 10.0,
//         crossAxisSpacing: 10.0,
//         children:const [
//           Image(image: AssetImage('assets/images/3859310.jpg')),
//           Image(image: AssetImage('assets/images/3776133.jpg')),
//           Image(image: AssetImage('assets/images/4058271.jpg')),
//           Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
//           Image(image: AssetImage('assets/images/3859310.jpg'),),
//           Image(image: AssetImage('assets/images/3859310.jpg')),
//           Image(image: AssetImage('assets/images/3776133.jpg')),
//           Image(image: AssetImage('assets/images/4058271.jpg')),
//           Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
//           Image(image: AssetImage('assets/images/3859310.jpg'),),      Image(image: AssetImage('assets/images/3859310.jpg')),
//           Image(image: AssetImage('assets/images/3776133.jpg')),
//           Image(image: AssetImage('assets/images/4058271.jpg')),
//           Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
//           Image(image: AssetImage('assets/images/3859310.jpg'),),
//           Image(image: NetworkImage('https://disease.sh/assets/img/flags/eg.png')),
//
//         ],
//       ),
//     ),
//   ],
// ),
