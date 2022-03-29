import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/Categories/CategoriesModel.dart';
import 'package:shopapp/models/home/HomeModel.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccessState) {
          if (!state.changeFavoritesModel.status) {
            defultFluttertoast(
                message: state.changeFavoritesModel.message,
                backgroundColor: Colors.red,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (BuildContext context) => productsBuilder(
                cubit.homeModel, context, cubit.categoriesModel),
            fallback: (BuildContext context) =>
                defultLoading(context, text: 'Loading Product...' ));
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
                      image: NetworkImage(
                          e.image ?? Image.asset('assets/images/loading.gif')),
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
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          categoriesBuilder(categoriesModel.data.data[index] , context),
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
              childAspectRatio: 1 / 1.9,
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

  Widget categoriesBuilder(dataCategoriesModel , context) => SizedBox(
        height: MediaQuery.of(context).size.height * .2,
    width: MediaQuery.of(context).size.width * .2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              dataCategoriesModel.image,
              height: MediaQuery.of(context).size.height*.4,
              width: MediaQuery.of(context).size.width*.4,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*.4,
              child: Text(
                dataCategoriesModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                maxLines: 1,
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
              products.image ?? Image.asset('assets/images/loading.gif'),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  products.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      'price ${products.price.round()} ',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    if (products.discount != 0)
                      Text(
                        '${products.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: grey,
                            decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopAppCubit.get(context).changeFavorites(products.id);

                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            ShopAppCubit.get(context).favorites[products.id]
                                ? Colors.red
                                : grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 15,
                          color: white,
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
