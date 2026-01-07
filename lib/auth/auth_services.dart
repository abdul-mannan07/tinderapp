import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinderapp/models/name_screen_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<String?> signUpWithEmail(NameScreenModel user, String password) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      final uid = userCred.user!.uid;
      await _firestore
          .collection('users')
          .doc(uid)
          .set(user.toMap(excludePassword: true));
      // Clear password from memory
      user.password = null;

      return uid;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "This email is already registered. Try logging in.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'weak-password':
          errorMessage = "Password is too weak. Use at least 6 characters.";
          break;
        default:
          errorMessage = e.message ?? "Registration failed";
      }
      throw AuthException(errorMessage);
    } catch (e) {
      throw AuthException("Something went wrong");
    }
  }

  Future<String?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred.user!.uid;
    } on FirebaseException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password";
          break;
        case 'invalid-email':
          errorMessage = "Email address is invalid";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled";
          break;
        default:
          errorMessage = "Email or password is incorrect";
      }
      throw AuthException(errorMessage);
    } catch (e) {
      throw AuthException("Something went wrong");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance
          .signOut(); // also sign out Google user if used
    } catch (e) {
      throw AuthException("Failed to sign out");
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      print("Starting Google Sign-In...");

      final googleUser = await _googleSignIn.authenticate();
      print("Google user: $googleUser");

      if (googleUser == null) return null; // user cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google ID token: ${googleAuth.idToken}");

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        //  accessToken: googleAuth.accessToken,
      );

      UserCredential userCred = await _auth.signInWithCredential(credential);

      final User? user = userCred.user;
      if (user == null) throw AuthException("Google Sign-In failed");

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'gender': '',
          'dob': null,
          'hobbies': [],
          'insgender': '',
          'selectedOption': '',
          'drink': null,
          'smoke': null,
          'workout': null,
          'pet': null,
          'recentPics': [],
          'lookingFor': null,
          'createdAt': DateTime.now(),
          'authMethod': 'google',
        });
      }

      return user.uid;
    } on GoogleSignInException catch (e) {
      print("GoogleSignInException: $e");
      throw AuthException("Google Sign-In failed: ${e}");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
      throw AuthException("Firebase error: ${e.message}");
    } catch (e, st) {
      print("Unknown error: $e");
      print(st);
      throw AuthException("Google Sign-In failed with unknown error");
    }
  }

  // ------------------------------------------------
  // FETCH CURRENT LOGGED-IN USER FROM FIRESTORE
  // ------------------------------------------------

  Future<NameScreenModel?> fetchUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return null;
      return NameScreenModel.fromMap(doc.data()!);
    } catch (e) {
        throw AuthException("Failed to fetch user data");
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}
