// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tinderapp/auth/auth_services.dart';

// class AuthServicesProvider with ChangeNotifier {
//   final AuthServices _authServices = AuthServices();

//   User? _user;
//   User? get user => _user;

//   bool _isLoading = true;
//   bool get isLoading => _isLoading;

//   AuthServicesProvider() {
//     FirebaseAuth.instance.authStateChanges().listen((user) {
//       _user = user;
//       _isLoading = false;
//       notifyListeners();
//     });
//   }

//   Future<void> signInWithGoogle() async {
//     _isLoading = true;
//     notifyListeners();

//     _user = await _authServices.signInWithGoogle();
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> signOut() async {
//     _isLoading = true;
//     notifyListeners();

//     await _authServices.signOut();
//     _user = null;
//     _isLoading = false;
//     notifyListeners();
//   }
// }
