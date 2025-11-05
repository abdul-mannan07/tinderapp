import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Mobile GoogleSignIn singleton
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Initialize GoogleSignIn with your server client ID
      await _googleSignIn.initialize(
        serverClientId:
            "292387979165‑mcm23gb2v7hu0bgdn94vaieo9rerd8nl.apps.googleusercontent.com",
      );

      // Prompt user to select a Google account
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      if (googleUser == null) {
        print('Google Sign-In canceled by user');
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        // accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e, s) {
      print('Google Sign-In error: $e');
      print(s);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
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
