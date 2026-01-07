class NameScreenModel {
  String name;
  String email;
  String? password;
  String? gender;
  DateTime? dob;
  List<String> hobbies;
  String? insgender;
  String? selectedOption;
  String? drink;
  String? smoke;
  String? workout;
  String? pet;
  List<String> recentPics;
  String? lookingFor;

  NameScreenModel({
    required this.name,
    required this.email,
    this.password,
    this.gender,
    this.dob,
    this.hobbies = const [],
    this.insgender,
    this.selectedOption,
    this.drink,
    this.smoke,
    this.workout,
    this.pet,
    this.recentPics = const [],
    this.lookingFor,
  });

  Map<String, dynamic> toMap({bool excludePassword = true}) {
    final map = {
      'name': name,
      'email': email,
      'gender': gender,
      'dob': dob?.toIso8601String(),
      'hobbies': hobbies,
      'insgender': insgender,
      'selectedOption': selectedOption,
      'drink': drink,
      'smoke': smoke,
      'workout': workout,
      'pet': pet,
      'recentPics': recentPics,
      'lookingFor': lookingFor,
    };

    // Add password only if not excluded
    if (!excludePassword && password != null) {
      map['password'] = password;
    }

    return map;
  }

  factory NameScreenModel.fromMap(Map<String, dynamic> map) {
    return NameScreenModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      gender: map['gender'],
      dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
      hobbies: List<String>.from(map['hobbies'] ?? []),
      insgender: map['insgender'],
      selectedOption: map['selectedOption'],
      drink: map['drink'],
      smoke: map['smoke'],
      workout: map['workout'],
      pet: map['pet'],
      recentPics: List<String>.from(map['recentPics'] ?? []),
      lookingFor: map['lookingFor'],
    );
  }












  
}
