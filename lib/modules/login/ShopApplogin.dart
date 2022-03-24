import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/modules/registration/registration.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

class ShopAppLoginScreen extends StatelessWidget {
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit, ShopAppState>(
        listener: (context, state)
        {
          // if (state is ShopAppLoginScreen)
          // {
          //   Fluttertoast.showToast(
          //       msg:'welcome',
          //       toastLength: Toast.LENGTH_LONG,
          //       gravity: ToastGravity.BOTTOM,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.green,
          //       textColor: Colors.white,
          //       fontSize: 16.0
          //   );
          // }
          // else
          // {
          //   Fluttertoast.showToast(
          //       msg: 'error',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.CENTER,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text (
                'Covid_19 ',
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
                  key: FormKey,
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage(
                            'assets/images/OIP (1).jfif'
                        ),
                        height: 200.0,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Hello ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        'Log in to your account to show statues',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: defultTextFormFiled(
                            controller: EmailController,
                            type: TextInputType.emailAddress,
                            label: 'enter your Email',
                            prefixIcon: Icons.email,
                            validate: (String value) {
                              if (value.isEmpty)
                              {
                                return ' Email must not be empty';
                              }
                              else
                              {
                                return null;
                              }
                            },
                            radius: 10.0),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: defultTextFormFiled(
                            controller: PasswordController,
                            type: TextInputType.visiblePassword,
                            isPassword: isPassword,
                            label: 'Enter your password',
                            radius: 8.0,
                            prefixIcon: Icons.lock,
                            suffixIcon: isPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixPressed: () {
                              //isPassword = !isPassword;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              NavigateTo(context, const Registration());
                            },
                            child: const Text(
                              'Forget your password?',
                              style: TextStyle(
                                color: black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingShopAppDataState,
                        builder: (context) => defultButton(
                          function: () {
                            if (FormKey.currentState.validate()) {
                             ShopAppCubit.get(context).userLogin(
                                 email:EmailController.text,
                                 password:PasswordController.text
                             );
                            }
                          },
                          text: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              'Do not have account?',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            defultTextButton(
                                text: 'Register here',
                                color: deepOrange,
                                function: () {
                                  NavigateTo(context, const Registration());
                                }),
                          ],
                        ),
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
