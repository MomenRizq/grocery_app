import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/auth/forget_pass.dart';
import 'package:grocery_app/views/auth/register.dart';
import 'package:grocery_app/views/auth/widgets/auth_button.dart';
import 'package:grocery_app/views/auth/widgets/custom_text_field.dart';
import 'package:grocery_app/views/auth/widgets/google_button.dart';
import 'package:grocery_app/views/auth/widgets/or_widget.dart';
import 'package:grocery_app/views/bottom_bar_view.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/fetch_screen.dart';
import 'package:grocery_app/views/loading_manager.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String? email;

  String? pass;

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;

  @override
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await KauthInstance.signInWithEmailAndPassword(
            email: email.toString().toLowerCase().trim(), password: pass!);
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FetchScreen(),
          ),
        );
        print('Succefully registered');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: _isLoading,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 120.0,
              ),
              CustomTextWidget(
                text: 'Welcome Back',
                color: Colors.white,
                textSize: 30,
                isTitle: true,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextWidget(
                text: "Sign in to continue",
                color: Colors.white,
                textSize: 18,
                isTitle: false,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      customFormTextField(
                        lableText: "Email",
                        hintText: "Enter your email",
                        emptyText: "Email is empty ,write your email , please.",
                        onchanged: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(
                        height: 12,
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
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: ForgetPasswordScreen.routeName);
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
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                fct: () {
                  _submitFormOnLogin();
                },
                buttonText: 'Login',
              ),
              const SizedBox(
                height: 10,
              ),
              const GoogleButton(),
              const SizedBox(
                height: 20,
              ),
              const OrWidget(),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                fct: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FetchScreen(),
                    ),
                  );
                },
                buttonText: 'Continue as a guest',
                primary: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        children: [
                      TextSpan(
                          text: '  Sign up',
                          style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GlobalMethods.navigateTo(
                                  ctx: context,
                                  routeName: RegisterScreen.routeName);
                            }),
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
