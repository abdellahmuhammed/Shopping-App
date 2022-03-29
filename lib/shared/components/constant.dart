String baseUel = 'https://newsapi.org';


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token ='';




//https://newsapi.org/v2/top-headlines?country=eg&apiKey=bc88c0d4da3c484fa28644e1698c1651

/*



https://newsapi.org/v2/everything?q=tesla&from=2022-02-06&sortBy=publishedAt&apiKey=bc88c0d4da3c484fa28644e1698c1651





// ignore_for_file: unrelated_type_equality_checks

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/GetFavorites/GetFavorites.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => ConditionalBuilder(
                condition: ShopAppCubit.get(context).getFavoritesModel != null,
                builder: (BuildContext context) => favoritesBuilder(
                    context,
                    ShopAppCubit.get(context)
                        .getFavoritesModel
                        .data
                        .data[index]),
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
              ),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount:
                  ShopAppCubit.get(context).getFavoritesModel.data.data.length,
            ),
          ),
        );
      },
    );
  }

  Widget favoritesBuilder(context, FavoritesData favModel) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(favModel.product.image),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              favModel.product.name,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              favModel.product.description,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
            const SizedBox(
              height: 15,
            ),

            Row(
              children: [
                Text(
                  'price ${favModel.product.price.round()}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  width: 5,
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
                    //ShopAppCubit.get(context).changeFavorites(products.id);
                  },
                  icon: const CircleAvatar(
                    radius: 15,
                    // backgroundColor:
                    //ShopAppCubit.get(context).favorites[products.id]
                    //     ? blue
                    //     : grey,
                    child: Icon(
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


  /*
   Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 50),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .145,
            child: Column(
              children:  [
                Center(
                  child: Image(
                    image: NetworkImage(ProfileModel.product.image),
                    height: 80,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0),
          child: Row(
            children: [
              const Text('Personal Information'),
              const Spacer(),
              MaterialButton(onPressed: (){
                NavigateTo(context, UpdateProfileScreen());
              },
                child: Text('Edit' , style: Theme.of(context).textTheme.bodyText1,),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: defultProfileRow(
              context,
              onPressed: (){},
              text1: 'UserName',
              text2: ProfileModel.product.name,
              width: 75,
            )),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0),
          child: defultProfileRow(
            context,
            onPressed: () {},
            text1: 'phone number',
            text2:  '${ProfileModel.product.phone.toInt()}',
          ),
        ),
        Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: defultProfileRow(context,
                onPressed: () {},
                text1: 'Email',
                text2: ProfileModel.product.email,
                width: 112)),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0),
          child: defultProfileRow(context,
              onPressed: () {},
              text1: 'National Id',
              text2: '12345678912345',
              width: 75),
        ),
      ],
    ),
  )
  * */
}
/**/

*/
