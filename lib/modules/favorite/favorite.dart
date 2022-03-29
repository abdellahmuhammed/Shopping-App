// ignore_for_file: unrelated_type_equality_checks

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/GetFavorites/GetFavorites.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: ConditionalBuilder(
              condition: ShopAppCubit.get(context).getFavoritesModel != null &&
                  ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoriesModel != null,
              builder: (BuildContext context)=>ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => favoritesBuilder(
                    context,
                    ShopAppCubit.get(context).getFavoritesModel.data.data[index]),
                separatorBuilder: (context, index) => MyDivider(),
                itemCount: ShopAppCubit.get(context).getFavoritesModel.data.data.length,
              ),
              fallback: (BuildContext context) => defultLoading(context , text: 'Loading Favorites...' )
            ),
          ),
        );
      },
    );
  }

  Widget favoritesBuilder(context, FavoritesData favModel) =>
      Row(
    children: [
      Stack(
          alignment: Alignment.bottomLeft, children:
      [
        Image.network(
          favModel.product.image,
          width: MediaQuery.of(context).size.width*.3,
          height:MediaQuery.of(context).size.height*.2,
        ),
        if (favModel.product.discount != 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.redAccent,
              child: const Text('Discount'),
            ),
          ),
      ]
      ),
      const SizedBox(width: 20,),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height:MediaQuery.of(context).size.height*.20,
            width:double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favModel.product.name,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10,),
                Text(
                  favModel.product.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines:3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'price ${favModel.product.price.round()} ',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    if (favModel.product.discount != 0)
                      Text(
                        '${favModel.product.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        printFullText('${favModel.product.id}');
                        ShopAppCubit.get(context).changeFavorites(favModel.product.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                        ShopAppCubit.get(context).favorites[favModel.product.id]
                            ? blue
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
        ),
      ),
    ],
  );
}
// Stack(alignment: Alignment.bottomLeft, children: [
//
//      Image.asset('assets/images/loading.gif' ,
//        width: double.infinity,
//        height: 150,),
//
//   if (products.discount != 0)
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         color: Colors.redAccent,
//         child: const Text('Discount'),
//       ),
//     ),
// ]),
// Padding(
//   padding: const EdgeInsets.all(15.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         products.name,
//         style: Theme.of(context).textTheme.bodyText1,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//       ),
//       Row(
//         children: [
//           Text(
//             'price ${products.price.round()} ',
//             style: Theme.of(context).textTheme.bodyText2,
//           ),
//           if (products.discount != 0)
//             Text(
//               '${products.oldPrice.round()}',
//               style: const TextStyle(
//                   fontSize: 12,
//                   color: grey,
//                   decoration: TextDecoration.lineThrough),
//             ),
//           const Spacer(),
//           IconButton(
//             onPressed: () {
//               print(products.id);
//               ShopAppCubit.get(context).changeFavorites(products.id);
//             },
//             icon: CircleAvatar(
//               radius: 15,
//               backgroundColor:
//               ShopAppCubit.get(context).favorites[products.id]
//                   ? blue
//                   : grey,
//               child: const Icon(
//                 Icons.favorite_border,
//                 size: 15,
//                 color: white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),
