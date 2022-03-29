// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/search/SearchModel.dart';
import 'package:shopapp/modules/search/cubit/search_cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defultTextFormFiled(context,
                        controller: searchController,
                        type: TextInputType.text,
                        label: 'Searching',
                        prefixIcon: Icons.search, onSubmit: (String text) {
                      SearchCubit.get(context).getSearch(text);
                    }),
                  ),
                  if (state is LoadingSearchState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: searchBuilderItem(cubit, isSearch: true)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchBuilder(context, SearchData searchDataModel) =>
      BlocConsumer<ShopAppCubit, ShopAppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                Image.network(
                  searchDataModel.image,
                  width: MediaQuery.of(context).size.width * .2,
                  height: MediaQuery.of(context).size.height * .2,
                ),
              ]),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchDataModel.name,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          searchDataModel.description,
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              searchDataModel.price.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ShopAppCubit.get(context)
                                    .changeFavorites(searchDataModel.id);
                              },
                              icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: ShopAppCubit.get(context)
                                        .favorites[searchDataModel.id]
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
                ),
              ),
            ],
          );
        },
      );

  Widget searchBuilderItem(cubit, {isSearch = false}) => ConditionalBuilder(
        condition: cubit.searchModel != null,
        builder: (BuildContext context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              searchBuilder(context, cubit.searchModel.data.data[index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: cubit.searchModel.data.data.length,
        ),
        fallback: (BuildContext context) => isSearch
            ? Center(
                child: Image.asset('assets/images/936-search.gif'),
              )
            : const Center(
                child: CircularProgressIndicator(),
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
//               SearchCubit.get(context).changeFavorites(products.id);
//             },
//             icon: CircleAvatar(
//               radius: 15,
//               backgroundColor:
//               SearchCubit.get(context).favorites[products.id]
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
