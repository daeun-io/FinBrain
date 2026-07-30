import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/data/aes_helper.dart';
import 'package:finbrain/ui/viewmodel/shared_preferences_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_screen_viewmodel.g.dart';

@riverpod
class OnboardingScreenViewmodel extends _$OnboardingScreenViewmodel{
  @override
  int build() => 0;
  
  Future<void> savePersonalInfoInfirestore(User? user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final isFirstRun = await ref.read(sharedPreferencesViewmodelProvider.future);
    if(isFirstRun){
      final userRef = firestore.collection("users").doc(user!.uid);
      await userRef.set(
        {
          "display_name": AesHelper.encryptText(user.displayName ?? "성이름"),
          "email" : AesHelper.encryptText(user.email!),
        },
        SetOptions(merge: true)
      );
    }
  }
}