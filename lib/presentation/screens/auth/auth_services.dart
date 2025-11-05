import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
}

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Singleton GoogleSignIn instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // IMPORTANT: Initialize before authenticate
      await _googleSignIn.initialize(
        clientId:
            "292387979165-mcm23gb2v7hu0bgdn94vaieo9rerd8nl.apps.googleusercontent.com",
      );

      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      final GoogleSignInAuthentication auth = await account.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
        //accessToken: auth.accessToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } catch (e) {
      // TODO: Implement proper error logging
      print("Google Sign-In Error: $e");
      throw AuthException('Failed to sign in with Google: $e');
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("Sign-Out Error: $e");
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

//   /// Sign in with Google
//   Future<User?> signInWithGoogle() async {
//     String webClientId =
//         "292387979165-mcm23gb2v7hu0bgdn94vaieo9rerd8nl.apps.googleusercontent.com";
//     try {
//       // Trigger the Google Sign-In flow
//       await _googleSignIn.initialize(clientId: webClientId);
//       GoogleSignInAccount account = await _googleSignIn.authenticate();
//       GoogleSignInAuthentication googleUser = account.authentication;
//       final credential = GoogleAuthProvider.credential(
//         // accessToken: googleAuth.accessToken,
//         idToken: googleUser.idToken,
//       );
//       await _auth.signInWithCredential(credential);
//     } catch (e) {
//       print('Google sign-in error: $e');
//       return null;
//     }
//   }

//   /// Sign out
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }
