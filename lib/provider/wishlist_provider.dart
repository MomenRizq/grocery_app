import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }


  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> fetchWishlist() async {
    final User? user = KauthInstance.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.data().toString().contains('userWish') ?userDoc.get('userWish').length : 0;
    for (int i = 0; i < leng; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('userWish')[i]['productId'],
              () => WishlistModel(
            id: userDoc.data().toString().contains('userWish') ?userDoc.get('userWish')[i]['wishlistId']:"",
            productId: userDoc.data().toString().contains('userWish') ?userDoc.get('userWish')[i]['productId']:"",
          ));
    }
    notifyListeners();
  }

  // void addRemoveProductToWishlist({required String productId}) {
  //   if (_wishlistItems.containsKey(productId)) {
  //    return ;
  //   } else {
  //     _wishlistItems.putIfAbsent(
  //         productId,
  //             () => WishlistModel(
  //             id: DateTime.now().toString(), productId: productId));
  //   }
  //   notifyListeners();
  // }

  Future<void> removeOneItem({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = KauthInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {
          'wishlistId': wishlistId,
          'productId': productId,
        }
      ])
    });
    _wishlistItems.remove(productId);
    await fetchWishlist();
    notifyListeners();
  }

  Future<void> clearOnlineWishlist() async {
    final User? user = KauthInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': [],
    });
    _wishlistItems.clear();
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
