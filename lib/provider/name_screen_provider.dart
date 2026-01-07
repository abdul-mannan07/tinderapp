import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tinderapp/auth/auth_services.dart';
import 'package:tinderapp/models/name_screen_model.dart';
import 'package:tinderapp/utils/signup_utils.dart';

class NameProvider extends ChangeNotifier {
  NameProvider() {
    nameController.addListener(_onFieldChanged);
    emailController.addListener(_onFieldChanged);
    passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');
    print('isFormValid: $isFormValid');

    notifyListeners();
  }

  final AuthServices _authServices = AuthServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final NameScreenModel _user = NameScreenModel(
    name: '',
    email: '',
    password: '',
    gender: '',
    dob: DateTime.now(),
    hobbies: [],
    insgender: '',
    selectedOption: '',
    drink: null,
    smoke: null,
    workout: null,
    pet: null,
    recentPics: [],
    lookingFor: null,
  );
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  NameScreenModel get user => _user;
  bool _obscurePassword = true;
  // final FirebaseAuth _emailAuth = FirebaseAuth.instance;
  void setBasicInfo() {
    _user.email = emailController.text.trim();
    _user.name = nameController.text.trim();
    notifyListeners();
  }

  bool _isSignUp = false; // false for Sign-In, true for Sign-Up
  bool get isSignUp => _isSignUp;
  void enableSignUpMode() {
    _isSignUp = true;
    notifyListeners();
  }
  void disableSignUpMode() {
  _isSignUp = false;
  notifyListeners();
}

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> signUp() async {
    _setLoading(true);

    try {
      _user.name = nameController.text.trim();
      _user.email = emailController.text.trim();

      final uid = await _authServices.signUpWithEmail(
        _user,
        passwordController.text.trim(),
      );
      SignupUtils.showToast(
        "Registration successful!",
        backgroundColor: Colors.green,
      );
      _setLoading(false);
      return uid;
    } on AuthException catch (e) {
      _setLoading(false);
      // You can show a toast here or propagate the message
      SignupUtils.showToast(e.message, backgroundColor: Colors.red);
      return null;
    } catch (e) {
      _setLoading(false);
      SignupUtils.showToast(
        "Something went wrong",
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future<String?> signIn() async {
    _setLoading(true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    try {
      final uid = await _authServices.signInWithEmail(
        email: email,
        password: password,
      );
      SignupUtils.showToast(
        "Sign In successful!",
        backgroundColor: Colors.green,
      );

      _setLoading(false);
      return uid;
    } on AuthException catch (e) {
      _setLoading(false);
      SignupUtils.showToast(e.message, backgroundColor: Colors.red);
      return null;
    } catch (e) {
      _setLoading(false);
      SignupUtils.showToast(
        "Something went wrong",
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future<String?> signInWithGoogle() async {
    _setLoading(true);
    try {
      final uid = await _authServices.signInWithGoogle();
      SignupUtils.showToast(
        "Google Sign-In successful!",
        backgroundColor: Colors.green,
      );

      _setLoading(false);
      return uid;
    } on AuthException catch (e) {
      _setLoading(false);
      SignupUtils.showToast(e.message, backgroundColor: Colors.red);
      return null;
    } catch (e) {
      _setLoading(false);
      SignupUtils.showToast(
        "Google Sign-In failed",
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);

    try {
      await _authServices.signOut();

      SignupUtils.showToast(
        "Signed out successfully",
        backgroundColor: Colors.green,
      );
    } on AuthException catch (e) {
      SignupUtils.showToast(e.message, backgroundColor: Colors.red);
    } catch (e) {
      SignupUtils.showToast(
        "Something went wrong",
        backgroundColor: Colors.red,
      );
    } finally {
      _setLoading(false);
    }
  }

  // Future<String?> signup() async {
  //   _isLoading = true;
  //   notifyListeners(); // notify UI to show loader
  //   try {
  //     _user.name = nameController.text.trim();
  //     _user.email = emailController.text.trim();

  //     UserCredential userCred = await _emailAuth.createUserWithEmailAndPassword(
  //       email: _user.email,
  //       password: passwordController.text.trim(),
  //     );
  //     // Registration successful, user UID is:
  //     final uid = userCred.user!.uid;
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .set(_user.toMap(excludePassword: true));
  //     // Clear password from memory after signup
  //     _user.password = null;
  //     passwordController.clear();
  //     SignupUtils.showToast(
  //       "Registration successful!",
  //       backgroundColor: Colors.green,
  //     );
  //     _isLoading = false;
  //     notifyListeners();
  //     return uid;
  //   } on FirebaseAuthException catch (e) {
  //     _isLoading = false;
  //     notifyListeners();

  //     String errorMessage;

  //     switch (e.code) {
  //       case 'email-already-in-use':
  //         errorMessage = "This email is already registered. Try logging in.";
  //         break;
  //       case 'invalid-email':
  //         errorMessage = "The email address is not valid.";
  //         break;
  //       case 'weak-password':
  //         errorMessage = "Password is too weak. Use at least 6 characters.";
  //         break;
  //       default:
  //         errorMessage = e.message ?? "Registration failed";
  //     }

  //     SignupUtils.showToast(errorMessage, backgroundColor: Colors.red);

  //     return null;
  //   }
  // }

  // Future<String?> signIn() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     UserCredential userCred = await _emailAuth.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     SignupUtils.showToast(
  //       "Sign In successful!",
  //       backgroundColor: Colors.green,
  //     );

  //     _isLoading = false;
  //     notifyListeners();
  //     return userCred.user?.uid;
  //   } on FirebaseAuthException catch (e) {
  //     _isLoading = false;
  //     notifyListeners();

  //     // Map Firebase error codes to friendly messages
  //     String errorMessage;

  //     switch (e.code) {
  //       case 'user-not-found':
  //         errorMessage = "No user found with this email";
  //         break;
  //       case 'wrong-password':
  //         errorMessage = "Incorrect password";
  //         break;
  //       case 'invalid-email':
  //         errorMessage = "Email address is invalid";
  //         break;
  //       case 'user-disabled':
  //         errorMessage = "This user account has been disabled";
  //         break;
  //       default:
  //         errorMessage = "Email or password is incorrect"; // generic fallback
  //     }

  //     SignupUtils.showToast(errorMessage, backgroundColor: Colors.red);

  //     return null;
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();

  //     SignupUtils.showToast(
  //       "Something went wrong",
  //       backgroundColor: Colors.red,
  //     );
  //     return null;
  //   }
  // }

  bool get obscurePassword => _obscurePassword;
  void toggleObscure() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Form validation inside provider
  String? validateName() {
    if (nameController.text.isEmpty) return 'Please enter your name';
    return null;
  }

  String? validateEmail() {
    if (emailController.text.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Inside NameProvider
  void addRecentPic(File image) {
    if (_user.recentPics.length >= 6) return; // Max 6 images
    _user.recentPics.add(image.path); // store path as String
    notifyListeners();
  }

  String? validatePassword() {
    if (passwordController.text.isEmpty) return 'Please enter a password';
    if (passwordController.text.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  bool get isFormValid {
    if (isSignUp == true) {
      return validateName() == null &&
          validateEmail() == null &&
          validatePassword() == null;
    } else {
      return validateEmail() == null && validatePassword() == null;
    }
  }

  void updateName(String value) {
    _user.name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _user.email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _user.password = value;
    notifyListeners();
  }

  // void updateDob(DateTime dob) {
  //   _user.dob = dob;
  //   notifyListeners();
  // }

  void updateGender(String gender) {
    _user.gender = gender;
    notifyListeners();
  }

  void updateHobbies(List<String> hobbies) {
    _user.hobbies = hobbies;
    notifyListeners();
  }

  void updateInterestedIn(String insgender) {
    _user.insgender = insgender;
    notifyListeners();
  }

  void updateLifestyle({
    String? drink,
    String? smoke,
    String? workout,
    String? pet,
  }) {
    _user.drink = drink;
    _user.smoke = smoke;
    _user.workout = workout;
    _user.pet = pet;
    notifyListeners();
  }

  void updateRecentPics(List<String> pics) {
    _user.recentPics = pics;
    notifyListeners();
  }

  void updateLookingFor(String value) {
    _user.lookingFor = value;
    notifyListeners();
  }

  void clearControllers() {
    // Always clear email & password
    emailController.clear();
    passwordController.clear();

    // Clear name only for SignUp
    if (isSignUp == true) {
      nameController.clear();

      // Reset SignUp-specific temp variables
      _selectedDate = null;
      _gender = null;
      _insGender = null;
      _selectedOption = null;
      _selectedDrink = null;
      _selectedSmoke = null;
      _selectedWorkout = null;
      _selectedPet = null;
      _selectedHobbies.clear();
      _profileImages.clear();
    }

    // Reset common UI flags
    _isLoading = false;
    _obscurePassword = true;

    notifyListeners(); // update UI
  }
  // ---------------- GOOGLE SIGN IN ------------------

  // Future<String?> signInWithGoogle() async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();

  //     final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  //     // 2. Attempt Google sign-in
  //     final googleUser = await googleSignIn.authenticate();

  //     if (googleUser == null) {
  //       _isLoading = false;
  //       notifyListeners();
  //       return null; // user canceled
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       // accessToken: googleAuth.accs,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase
  //     final UserCredential userCred = await FirebaseAuth.instance
  //         .signInWithCredential(credential);

  //     final User? user = userCred.user;

  //     // Check if this user exists in Firestore
  //     final doc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user!.uid)
  //         .get();

  //     // If user is new → create profile
  //     if (!doc.exists) {
  //       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
  //         'name': user.displayName ?? '',
  //         'email': user.email ?? '',
  //         'gender': '',
  //         'dob': null,
  //         'hobbies': [],
  //         'insgender': '',
  //         'selectedOption': '',
  //         'drink': null,
  //         'smoke': null,
  //         'workout': null,
  //         'pet': null,
  //         'recentPics': [],
  //         'lookingFor': null,
  //         'createdAt': DateTime.now(),
  //         'authMethod': 'google',
  //       });
  //     }

  //     SignupUtils.showToast(
  //       "Google Sign-In successful!",
  //       backgroundColor: Colors.green,
  //     );

  //     _isLoading = false;
  //     notifyListeners();

  //     return user.uid;
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();

  //     SignupUtils.showToast(
  //       "Google Sign-In failed",
  //       backgroundColor: Colors.red,
  //     );

  //     return null;
  //   }
  // }

  //dob screen//
  final TextEditingController dobController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      _user.dob = _selectedDate!;

      notifyListeners();
    }
  }

  bool get isDateSelected => _selectedDate != null;

  String? validateDate() {
    if (_selectedDate == null) {
      return 'Please select your date of birth';
    }
    return null;
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }
  //----------------------//end//-----------------------//

  //gender screen
  String? _gender;
  final List<String> _genders = ["Woman", "Man", "Other"];

  String? get gender => _gender;
  List<String> get genders => _genders;

  void selectGender(String selectedGender) {
    _gender = selectedGender;
    _user.gender = selectedGender; // update the model
    notifyListeners();
  }

  //----------------------//end//-----------------------//

  //Interested gender //
  String? _insGender;
  final List<String> _insGenders = ["Woman", "Man", "EveryOne"];
  String? get insGender => _insGender;
  List<String> get insGenders => _insGenders;

  void selectInsGender(String selectedinsGenders) {
    _insGender = selectedinsGenders;
    _user.insgender = selectedinsGenders;
    notifyListeners();
  }
  //----------------------//end//-----------------------//

  //Lokking for //
  final List<String> _options = [
    "Long-term partner",
    "Long-term open to short",
    "Short-term open to long",
    "Short-term fun",
    "New friends",
    "Still figuring it out",
  ];

  final List<String> _images = [
    "assets/images/pink_heart.png",
    "assets/images/heart_face.png",
    "assets/images/glasses.png",
    "assets/images/celebration.png",
    "assets/images/waving.png",
    "assets/images/thinking.png",
  ];
  String? _selectedOption;

  List<String> get images => _images;
  List<String> get options => _options;
  String? get selectedOption => _selectedOption;
  void selectOption(String option) {
    _selectedOption = option;
    _user.selectedOption = option;
    notifyListeners();
  }
  //----------------------//end//-----------------------//

  //lifestyle //

  String? _selectedDrink;
  String? _selectedSmoke;
  String? _selectedWorkout;
  String? _selectedPet;

  String? get selectedDrink => _selectedDrink;
  String? get selectedSmoke => _selectedSmoke;
  String? get selectedWorkout => _selectedWorkout;
  String? get selectedPet => _selectedPet;

  bool get isNextEnabled =>
      _selectedDrink != null &&
      _selectedSmoke != null &&
      _selectedWorkout != null &&
      _selectedPet != null;

  void setDrink(String val) {
    _selectedDrink = val;
    _user.drink = val;
    notifyListeners();
  }

  void setSmoke(String val) {
    _selectedSmoke = val;
    _user.smoke = val;

    notifyListeners();
  }

  void setWorkout(String val) {
    _selectedWorkout = val;
    _user.workout = val;

    notifyListeners();
  }

  void setPet(String val) {
    _selectedPet = val;
    _user.pet = val;

    notifyListeners();
  }

  //----------------------//end//-----------------------//

  //hobbies //

  final Set<String> _selectedHobbies = {};

  Set<String> get selectedHobbies => _selectedHobbies;

  // All available hobbies (renamed from "options" to "allHobbies")
  final List<String> allHobbies = [
    "German Hip Hop",
    "Fridays for Future",
    "Self Care",
    "Meditation",
    "Sushi",
    "Basketball",
    "Second-hand apparel",
    "Snowboarding",
    "Skiing",
    "Festivals",
    "Tattoos",
    "Activism",
    "Crossfit",
    "Muay Thai",
    "Artistic Swimming",
    "Beach Volleyball",
    "Flag Football",
    "Athletics",
    "Rhythmic Gymnastics",
    "Karate",
    "Softball",
    "Diving",
    "Trampoline",
    "Taekwondo",
    "Handball",
    "Judo",
    "Lacrosse",
    "Water Polo",
    "Ice Hockey",
    "Rowing",
    "Squash",
    "Luge",
    "Sports Shooting",
    "Walking",
    "K-Pop",
    "Reading",
    "Sports",
    "Aquarium",
    "Instagram",
    "Hot Springs",
    "Photography",
    "Exhibition",
    "Shopping",
    "Foodie Tour",
    "Escape Cafe",
  ];

  // Toggle hobby selection
  void toggleHobby(String hobby) {
    if (_selectedHobbies.contains(hobby)) {
      _selectedHobbies.remove(hobby);
    } else {
      _selectedHobbies.add(hobby);
    }
    _user.hobbies = _selectedHobbies.toList();
    notifyListeners();
  }

  // -------------------- IMAGES --------------------
  // -------------------- PROFILE IMAGES --------------------
  final List<File> _profileImages = [];
  final ImagePicker _picker = ImagePicker();

  List<File> get profileImages => _profileImages;
  bool get hasImages => _profileImages.isNotEmpty;
  bool get canProceed => _profileImages.length >= 2;

  /// Add or replace an image in a specific slot
  void addOrReplaceImage(int index, File image) {
    if (index < _profileImages.length) {
      _profileImages[index] = image; // Replace existing image
    } else if (_profileImages.length < 6) {
      _profileImages.add(image); // Add new image (max 6)
    }

    // ✅ Store image paths in the model
    _user.recentPics = _profileImages.map((file) => file.path).toList();

    notifyListeners();
  }

  /// Request permission (for Android/iOS)
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) return true;
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }

  /// Pick an image from gallery
  Future<void> pickImage(BuildContext context, int index) async {
    if (_profileImages.length >= 6 && index >= _profileImages.length) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Maximum 6 images allowed")));
      return;
    }

    bool permissionGranted = Platform.isIOS
        ? await _requestPermission(Permission.photos)
        : await _requestPermission(Permission.storage);

    if (!permissionGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Permission denied")));
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      addOrReplaceImage(index, File(pickedFile.path));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No image selected")));
    }
  }
  //----------------------//end//-----------------------//

  //progress bar //

  //   int currentStep = 1;
  // final int totalSteps = 8;

  // double get progressFraction => currentStep / totalSteps;

  // void goToNextStep() {
  //   if (currentStep < totalSteps) {
  //     currentStep++;
  //     notifyListeners();
  //   }
  // }

  // void goToPreviousStep() {
  //   if (currentStep > 1) {
  //     currentStep--;
  //     notifyListeners();
  //   }
  // }
}
