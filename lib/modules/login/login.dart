import 'package:flutter/material.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget
{
  LoginScreen({Key key}) : super(key: key);
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: black,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'lllllllll',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: grey,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                defultTextFormFiled(
                  controller: EmailController,
                  type: TextInputType.text,
                  radius: 10,
                  label: 'Email',
                  prefixIcon: Icons.email,
                  validate: (String value) {
                    if (value.isEmpty)
                    {
                      return 'Email Must Not be Empty';
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                defultTextFormFiled(
                  controller: PasswordController,
                  type: TextInputType.visiblePassword,
                  radius: 10,
                  label: 'Password',
                  isPassword: true,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility,
                  validate: (String value) {
                    if (value.isEmpty)
                    {
                      return 'Email Must Not be Empty';
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                defultButton(
                  function: () {},
                  text: const Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
