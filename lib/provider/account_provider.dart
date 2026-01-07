import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinderapp/auth/auth_services.dart';
import 'package:tinderapp/models/name_screen_model.dart';
import 'package:tinderapp/presentation/screens/onboarding/name_screen.dart';

class AccountProvider extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  NameScreenModel? _user;
  NameScreenModel? get user => _user;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> loadAccountData() async {
    _isLoading = true;
    notifyListeners();

    _user = await _authServices.fetchUserData();
    print("Fetched user: $_user");

    _isLoading = false;
    notifyListeners();
  }
}
