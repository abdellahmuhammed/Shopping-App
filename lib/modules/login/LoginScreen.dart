// ignore_for_file: must_be_immutable
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/layout/homelayout.dart';
import 'package:shopapp/modules/Registration/Registration.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';
import 'package:shopapp/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state){
        if (state is UserLoginSuccessState)
        {
          if (state.loginModel.status)
          {
            CacheHelper.saveData(
                key:'token' ,
                value: state.loginModel.data.token).then((value) {
              Fluttertoast.showToast(
                  msg:state.loginModel.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              NavigateAndRemove(context, const HomeLayoutScreen());
            });
          }
          else
          {
            Fluttertoast.showToast(
                msg:state.loginModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Shop App ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Hello ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Login to your account to show statues',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: defultTextFormFiled(context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Enter your Email',
                          prefixIcon: Icons.email, validate: (String value) {
                        if (value.isEmpty) {
                          return ' Email must not be empty';
                        } else {
                          return null;
                        }
                      }, radius: 10.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: defultTextFormFiled(context,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          label: 'Enter your password',
                          radius: 8.0,
                          prefixIcon: Icons.lock,
                          suffixIcon: cubit.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                        cubit.changeIcon();
                          },
                          validate: (String value) {
                        if (value.isEmpty) {
                          return ' Password must not be empty';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    // forget password
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child:  Text('Forget Your Password?' ,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        )
                      ],
                    ),
                    ConditionalBuilder(
                      condition:state is! LoadingUserLoginState ,
                      builder: (context)=> defultMaterialButton(
                        text: 'Login',
                        background: grey.withOpacity(.40),
                        function: () {
                          if(formKey.currentState.validate()){
                            cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text
                            );
                          }
                        },
                      ),
                      fallback: (context)=> const Center(child:  CircularProgressIndicator()),
                    ),
                    Row(
                      children:  [
                         Text(
                          'Do not have account? ',
                            style: Theme.of(context).textTheme.bodyText1
                        ),
                        TextButton(
                            onPressed:
                            ()
                            {
                              NavigateTo(context,  RegistrationScreen());
                            },
                            child: const Text('Register here')
                        )
                      ],
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
