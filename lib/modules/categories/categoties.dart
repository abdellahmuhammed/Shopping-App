import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/Categories/CategoriesModel.dart';
import 'package:shopapp/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: (BuildContext context) => ListView.separated(
            itemBuilder: (BuildContext context, int index) =>
                categoriesBuilder(cubit.categoriesModel.data.data[index]),
            separatorBuilder: (BuildContext context, int index) => MyDivider(),
            itemCount: cubit.categoriesModel.data.data.length,
          ),
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

//dsd
  Widget categoriesBuilder(DataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              model.image ?? Image.asset('assets/images/loading1.gif'),
              height: 80,
              width: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              model.name,
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ],
        ),
      );
}
