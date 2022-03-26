// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

class RegistrationScreen extends StatelessWidget{
  RegistrationScreen({Key key}) : super(key: key);

var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmepasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                     Text('Please Insert all features ' ,
                       style: Theme.of(context).textTheme.bodyText1,),
                    const SizedBox(height: 20,),
                    defultTextFormFiled(
                      context,
                      controller: userNameController,
                      type: TextInputType.text,
                      label: 'Enter your name',
                      prefixIcon: Icons.person,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Enter your name' ;
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    defultTextFormFiled(
                        context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Enter your Email',
                        prefixIcon: Icons.email,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Enter your Email' ;
                          }
                          else {
                            return null;
                          }
                        },
                    ),
                    const SizedBox(height: 20,),

                    defultTextFormFiled(
                      context,
                      controller: phoneController,
                      type: TextInputType.number,
                      label: 'Enter your phone',
                      prefixIcon: Icons.phone,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Enter your phone' ;
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    defultTextFormFiled(
                      context,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword: cubit.isPassword,
                      label: 'Enter your password',
                      prefixIcon: Icons.lock,
                      suffixIcon: cubit.isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixPressed: (){
                        cubit.changeIcon();
                      },
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'Enter your password' ;
                        }
                        else  if(value.length > 6)
                        {
                          return 'password is shortest' ;
                        }
                        else
                        {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    defultTextFormFiled(
                      context,
                      controller: confirmepasswordController,
                      type: TextInputType.visiblePassword,
                      isPassword: cubit.confirmPassword,
                      label: 'confirm your password',
                      prefixIcon: Icons.lock,
                      suffixIcon: cubit.confirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixPressed: (){
                        cubit.confirmepassword();
                      },
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'confirm your password' ;
                        }
                        else if( passwordController.text != confirmepasswordController.text){

                          return "your password don't identical";
                        }
                        else
                        {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    defultMaterialButton(
                        function: (){
                          if (formKey.currentState.validate()){
                            print('Abdellah');
                          }
                        },
                        text: 'Register' , background: grey.withOpacity(.40)
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
