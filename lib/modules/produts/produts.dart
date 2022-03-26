
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/home/HomeModel.dart';
import 'package:shopapp/shared/styles/colors.dart';

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
          builder: (BuildContext context) => productsBuilder(cubit.homeModel , context),
          fallback: (BuildContext context) => Column(
            children: [
              Center(
                child: Image.asset('assets/images/loading1.gif'),
              ),
              Text(
                'Loading...',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel homeModel , context) => SingleChildScrollView(
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
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.43,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              crossAxisCount: 2,
              children: List.generate(
                homeModel.data.products.length,
                (index) =>
                    gridViewProductsBuilder(homeModel.data.products[index] , context),
              ),
            ),
          ],
        ),
      );

  Widget gridViewProductsBuilder(Products products , context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children:[
              Image.network(
              products.image,
              width: double.infinity,
              height: 150,
            ),
              if (products.discount != 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.redAccent,
                  child: const Text('Discount'),

                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products.name,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
              children: [
                    Text(
                      'price ${products.price.round()} ',style: Theme.of(context).textTheme.subtitle2,
                    ),
                    if (products.discount !=0)
                      Text(
                      '${products.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: grey,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                const Spacer(),

                IconButton(
                  padding:EdgeInsets.zero ,
                    onPressed: (){},
                    icon: const Icon(
                      Icons.favorite_border ,
                      size: 15,

                    )

                )

                  ],
                ),
              ],
            ),
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
