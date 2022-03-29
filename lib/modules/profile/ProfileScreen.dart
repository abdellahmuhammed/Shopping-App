// ignore_for_file: must_be_immutable, non_constant_identifier_names, file_names

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/models/GetFavorites/GetFavorites.dart';
import 'package:shopapp/modules/updateProfile/UpdateProfile.dart';
import 'package:shopapp/shared/components/components.dart';
class ProfileScreen extends StatelessWidget {
  var Usercontroller = TextEditingController();
  ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< ShopAppCubit, ShopAppState>(
  listener: (context, state) {},
  builder: (context, state)
  {
    var cubit = ShopAppCubit.get(context).getUserProfileModel;
    return Scaffold(
      appBar: AppBar(),
      body: ConditionalBuilder(
        condition: cubit != null && ShopAppCubit.get(context).getFavoritesModel != null &&
            ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoriesModel != null,
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(10.0),
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
                          image: NetworkImage(cubit.data.image),
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
                     Text('Personal Information' ,style: Theme.of(context).textTheme.bodyText1,),
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
                    text2: cubit.data.name,
                    width: 75,
                  )),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15.0),
                child: defultProfileRow(
                  context,
                  onPressed: () {},
                  text1: 'phone number',
                  text2:  cubit.data.phone.toString(),
                ),
              ),
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15.0),
                  child: defultProfileRow(context,
                      onPressed: () {},
                      text1: 'Email',
                      text2: cubit.data.email,
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
        ),
        fallback:  (BuildContext context) =>const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  },
);
  }

  Widget getProfile( FavoritesData ProfileModel , BuildContext context )=> Center(
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
  );
}
