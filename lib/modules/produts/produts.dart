import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/Categories/CategoriesModel.dart';
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
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (BuildContext context) =>
              productsBuilder(cubit.homeModel, context, cubit.categoriesModel),
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

  Widget productsBuilder(
          HomeModel homeModel, context, CategoriesModel categoriesModel) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image ?? Image.asset('assets/images/loading.gif')),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'categories',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          categoriesBuilder(categoriesModel.data.data[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'New products',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.7,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              crossAxisCount: 2,
              children: List.generate(
                homeModel.data.products.length,
                (index) => gridViewProductsBuilder(
                    homeModel.data.products[index], context),
              ),
            ),
          ],
        ),
      );

  Widget categoriesBuilder(dataCategoriesModel) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              dataCategoriesModel.image,
              height: 100,
              width: 100,
            ),
            Container(
              width: 100,
              color: Colors.black12.withOpacity(.1),
              child: Text(
                dataCategoriesModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );

  Widget gridViewProductsBuilder(Products products, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Image.network(
              products.image ?? Image.asset('assets/images/loading.gif') ,
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
          ]),
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
                      'price ${products.price.round()} ',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    if (products.discount != 0)
                      Text(
                        '${products.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon:const CircleAvatar(
                          radius: 15,
                          child:  Icon(
                            Icons.favorite_border,
                            size: 15,
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
