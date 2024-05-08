// ignore_for_file: avoid_print, unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:k/screens/Home/home.dart';
import 'package:k/screens/Login/database.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

signInWithGoogle() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    var result = await googleSignIn.signIn();
    if (result == null) {
      return;
    }
    final userData = await result.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: userData.accessToken,
      idToken: userData.idToken,
    );
    var finalResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("Result $result");
    print(result.displayName);
    print(result.email);
    print(result.photoUrl);
    FirebaseAuth.instance.signInWithCredential(credential);
  } catch (ex) {
    print(ex);

    // ignore: unnecessary_null_comparison
  }
}

Future<void> logout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}

class Authmethod {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentuser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    // ignore: unnecessary_null_comparison
    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "name": userDetails.displayName,
        "image": userDetails.photoURL,
        "id": userDetails.uid
      };
      Database().adduser(userDetails.uid, userInfoMap).then((value) =>
          Navigator.of(context)
              .pop(MaterialPageRoute(builder: (ctx) => const HomeScreen())));
    }
  }

  Future<AuthCredential?> signInWithApple(
      {List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!));
        final userCredential = await auth.signInWithCredential(credential);
        final firebaseUser = userCredential.credential;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayname = '${fullName.givenName} ${fullName.familyName}';
            // await firebaseUser!.updateDisplayName(displayname);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED', message: result.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Error aborted by user');

      default:
        throw UnimplementedError();
    }
  }
}

Future<void> signout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}
