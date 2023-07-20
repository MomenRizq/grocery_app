import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/auth/login.dart';
import 'package:grocery_app/views/auth/widgets/auth_button.dart';
import 'package:grocery_app/views/auth/widgets/custom_text_field.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();

  String ? email ;
  String ? pass ;
  String ? name;
  String ? address ;


  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(
            height: 60.0,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
            Navigator.canPop(context) ? Navigator.pop(context) : null,
            child: Icon(
              IconlyLight.arrowLeft2,
              color: theme == true ? Colors.white : Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          CustomTextWidget(
            text: 'Welcome',
            color: Colors.white,
            textSize: 30,
            isTitle: true,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextWidget(
            text: "Sign up to continue",
            color: Colors.white,
            textSize: 18,
            isTitle: false,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                customFormTextField(
                  lableText: "Full Name",
                  hintText: "Enter your Name",
                  emptyText:
                  "Name is empty ,write your Name , please.",
                  onchanged: (data) {
                    name = data;
                  },),
                const SizedBox(
                  height: 20,
                ),
                customFormTextField(
                  lableText: "Email",
                  hintText: "Enter your email",
                  emptyText:
                  "Email is empty ,write your email , please.",
                  onchanged: (data) {
                    email = data;
                  },),
                const SizedBox(
                  height: 20,
                ),
                //Password
                customFormTextField(
                  lableText: "Password",
                  hintText: "Enter your password",
                  obscureText: true,
                  emptyText:
                  "Password is empty ,write your password , please.",
                  onchanged: (data) {
                    pass = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                customFormTextField(
                  lableText: "Address",
                  hintText: "Enter your address",
                  obscureText: true,
                  emptyText:
                  "Address is empty ,write your address , please.",
                  onchanged: (data) {
                    pass = data;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // GlobalMethods.navigateTo(
                //     ctx: context, routeName: FeedsScreen.routeName);
              },
              child: const Text(
                'Forget password?',
                maxLines: 1,
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          AuthButton(
            buttonText: 'Sign up',
            fct: () {
              _submitFormOnRegister();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                  text: 'Already a user?',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sign in',
                        style: const TextStyle(
                            color: Colors.lightBlue, fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          }),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
