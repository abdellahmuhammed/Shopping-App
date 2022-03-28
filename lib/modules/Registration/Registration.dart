// ignore_for_file: must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/homelayout.dart';
import 'package:shopapp/modules/Registration/cubit/user_register_cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';
import 'package:shopapp/shared/styles/colors.dart';

class RegistrationScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmepasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegisterCubit(),
      child: BlocConsumer<UserRegisterCubit, UserRegisterState>(
        listener: (context, state) {
          if (state is UserRegisterSuccessState) {
            if (state.userRegisterModel.status) {
              CacheHelper.saveData(
                key: 'token',
                value: state.userRegisterModel.data.token,
              ).then((value) {
                token = state.userRegisterModel.data.token;
                Fluttertoast.showToast(
                    msg: state.userRegisterModel.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                NavigateAndRemove(
                  context,
                  const HomeLayoutScreen(),
                );
              });
            } else {
              Fluttertoast.showToast(
                msg: state.userRegisterModel.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = UserRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please Insert all features ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defultTextFormFiled(
                        context,
                        controller: userNameController,
                        type: TextInputType.text,
                        label: 'Enter your name',
                        prefixIcon: Icons.person,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defultTextFormFiled(
                        context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Enter your Email',
                        prefixIcon: Icons.email,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      defultTextFormFiled(
                        context,
                        controller: phoneController,
                        type: TextInputType.number,
                        label: 'Enter your phone',
                        prefixIcon: Icons.phone,
                        maxLines: 11,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your phone';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defultTextFormFiled(context,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          label: 'Enter your password',
                          prefixIcon: Icons.lock,
                          suffixIcon: cubit.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off, suffixPressed: () {
                        cubit.changeIcon();
                      }, validate: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your password';
                        } else if (value.length > 6) {
                          return 'password is shortest';
                        } else {
                          return null;
                        }
                      }, onSubmit: (value) {
                        if (formKey.currentState.validate()) {
                          cubit.userRegister(
                              name: userNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text);
                        }
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      // defultTextFormFiled(
                      //   context,
                      //   controller: confirmepasswordController,
                      //   type: TextInputType.visiblePassword,
                      //   isPassword: cubit.confirmPassword,
                      //   label: 'confirm your password',
                      //   prefixIcon: Icons.lock,
                      //   suffixIcon: cubit.confirmPassword
                      //       ? Icons.visibility
                      //       : Icons.visibility_off,
                      //   suffixPressed: (){
                      //     cubit.confirmepassword();
                      //   },
                      //   validate: (String value){
                      //     if(value.isEmpty)
                      //     {
                      //       return 'confirm your password' ;
                      //     }
                      //     else if( passwordController.text != confirmepasswordController.text){
                      //
                      //       return "your password don't identical";
                      //     }
                      //     else
                      //     {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingUserRegisterState,
                        builder: (context) => Center(
                          child: defultMaterialButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                cubit.userRegister(
                                    name: userNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'Register',
                            background: grey.withOpacity(.40),
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
