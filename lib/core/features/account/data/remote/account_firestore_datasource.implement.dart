import 'dart:io';

import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

class AccountFirestoreDatasourceImplement extends AccountFirestoreDatasource {
  @override
  Future<AccountModel?> getAccountInfo() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseFirestore.instance;
    if (uid == null) {
      return null;
    }
    final docRef = await db.collection('account').doc(uid).get();
    if (docRef != null) {
      final data = docRef.data() as Map<String, dynamic>;
      return AccountModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<AccountEntity?> updateAccountInfo(
      {required AccountModel newAccountModel}) async {
    final db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await db.collection('account').doc(uid).set(newAccountModel.toJson());
    } else {
      throw Exception("uid is null");
    }
    final updatedModel = await getAccountInfo();
    return updatedModel?.toEntity(uid: uid);
  }

  @override
  Future<String?> updateAvatar({required XFile image}) async {
    String? userID =
        FirebaseAuth.instance.currentUser?.uid; // Ensure the user is logged in
    if (userID == null) {
      return null;
    }
    final storage = FirebaseStorage.instance;
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    final ref = storage.ref().child('$userID.jpg');
    await ref.putFile(File(image.path), metadata);
    final String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
}
