import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/auth/login.dart';
import 'package:grocery_app/views/auth/widgets/auth_button.dart';
import 'package:grocery_app/views/auth/widgets/custom_text_field.dart';
import 'package:grocery_app/views/bottom_bar_view.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/loading_manager.dart';

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
  bool _isLoading = false;


  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await KauthInstance.createUserWithEmailAndPassword(
            email: email.toString().toLowerCase().trim(),
            password: pass!);
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('registration successful'),
          backgroundColor: Colors.green,
        ));

        //Save user info
        final User? user = KauthInstance.currentUser;
        final _uid = user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': name,
          'email': email!.toLowerCase(),
          'shipping-address': address,
          'userWish': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BottomBarView(),
          ),
        );
        print('Succefully registered');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        print(error.message);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        print(error);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    else{
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    return LoadingManager(
      isLoading: _isLoading,
      child: SingleChildScrollView(
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
              buttonText: "sign up",
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
      ),
    );
  }
}
