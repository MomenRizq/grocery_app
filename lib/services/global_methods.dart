import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:uuid/uuid.dart';

class GlobalMethods {
 static  navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

 static Future<void> warningDialog({
   required String title,
   required String subtitle,
   required Function fct,
   required BuildContext context,
 }) async {
   await showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Row(children: [
             Image.asset(
               'assets/images/warning-sign.png',
               height: 20,
               width: 20,
               fit: BoxFit.fill,
             ),
             const SizedBox(
               width: 8,
             ),
             Text(title),
           ]),
           content: Text(subtitle),
           actions: [
             TextButton(
               onPressed: () {
                 if (Navigator.canPop(context)) {
                   Navigator.pop(context);
                 }
               },
               child: CustomTextWidget(
                 color: Colors.cyan,
                 text: 'Cancel',
                 textSize: 18,
               ),
             ),
             TextButton(
               onPressed: () {
                 fct();
                 if (Navigator.canPop(context)) {
                   Navigator.pop(context);
                 }
               },
               child: CustomTextWidget(
                 color: Colors.red,
                 text: 'OK',
                 textSize: 18,
               ),
             ),
           ],
         );
       });
 }

 static Future<void> errorDialog({

   required String subtitle,

   required BuildContext context,
 }) async {
   await showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Row(children: [
             Image.asset(
               'assets/images/warning-sign.png',
               height: 20,
               width: 20,
               fit: BoxFit.fill,
             ),
             const SizedBox(
               width: 8,
             ),
             const Text('An Error occured'),
           ]),
           content: Text(subtitle),
           actions: [
             TextButton(
               onPressed: () {
                 if (Navigator.canPop(context)) {
                   Navigator.pop(context);
                 }
               },
               child: CustomTextWidget(
                 color: Colors.cyan,
                 text: 'Ok',
                 textSize: 18,
               ),
             ),

           ],
         );
       });
 }

 static Future<void> addToCart(
     {required String productId,
       required int quantity,
       required BuildContext context}) async {
   final User? user = KauthInstance.currentUser;
   final _uid = user!.uid;
   final cartId = const Uuid().v4();
   try {
     FirebaseFirestore.instance.collection('users').doc(_uid).update({
       'userCart': FieldValue.arrayUnion([
         {
           'cartId': cartId,
           'productId': productId,
           'quantity': quantity,
         }
       ])
     });
     await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       content: Text('Item has been added to your cart'),
       backgroundColor: Colors.green,
     ));
   } catch (error) {
     errorDialog(subtitle: error.toString(), context: context);
   }
 }
 static Future<void> addToWishlist(
     {required String productId, required BuildContext context}) async {
   final User? user = KauthInstance.currentUser;
   final _uid = user!.uid;
   final wishlistId = const Uuid().v4();
   try {
     FirebaseFirestore.instance.collection('users').doc(_uid).update({
       'userWish': FieldValue.arrayUnion([
         {
           'wishlistId': wishlistId,
           'productId': productId,
         }
       ])
     });
     await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       content: Text('Item has been added to your Wishlist'),
       backgroundColor: Colors.green,
     ));
   } catch (error) {
     errorDialog(subtitle: error.toString(), context: context);
   }
 }

}
