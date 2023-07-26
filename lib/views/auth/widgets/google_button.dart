import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/bottom_bar_view.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await KauthInstance.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));

          await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomBarView(),
            ),
          );

        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              subtitle: '${error.message}', context: context);
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,

      child: Material(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          onTap: () {
            _googleSignIn(context);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
                height: 50,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            CustomTextWidget(
                text: 'Sign in with google', color: Colors.white, textSize: 18)
          ]),
        ),
      ),
    );
  }
}
