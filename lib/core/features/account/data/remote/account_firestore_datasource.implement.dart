import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountFirestoreDatasourceImplement extends AccountFirestoreDatasource {
  @override
  Future<AccountModel?> getAccountInfo({required String uid}) async {
    final db = FirebaseFirestore.instance;
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
    final updatedModel = await getAccountInfo(uid: uid);
    return updatedModel?.toEntity(uid: uid);
  }
}
