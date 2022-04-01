// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/layout/homelayout.dart';

import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';


class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key key}) : super(key: key);
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        if(state is UpdateProfileSuccessState){
          if (state.userModel.status)
          {
            defultFluttertoast(
              message: state.userModel.message,
              backgroundColor: Colors.green,
            );
            NavigateTo(context,  HomeLayoutScreen());
          } else{
            defultFluttertoast(
              message: state.userModel.message,
              backgroundColor: Colors.red,
            );
          }

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is LoadingUpdateProfileState)
                    const LinearProgressIndicator(),
                    const SizedBox(height: 15,),
                    Text('Update your account ',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1),
                    const SizedBox(
                      height: 20,
                    ),
                    // userName
                    defultTextFormFiled(
                      context,
                      controller: usernameController,
                      type: TextInputType.name,
                      label: 'Insert User Name',
                      prefixIcon: Icons.person,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' User Name most not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // email
                    defultTextFormFiled(
                      context, controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Enter your email',
                      prefixIcon: Icons.email,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' Email must not be Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // phone
                    defultTextFormFiled(
                      context, controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Enter your phone',
                      prefixIcon: Icons.phone,
                      maxLength: 11,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' phone must not be Empty';
                        } else if (value.length < 11) {
                          {
                            return ' phone is shortest';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: defultMaterialButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ShopAppCubit.get(context).updateUserProfile(
                                name: usernameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                image: 'https://student.valuxapps.com/storage/uploads/users/H5Qx2LmO1S_1648557694.jpeg'
                              );
                            }
                          },
                          background: grey.withOpacity(.25),
                          text: 'Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}

