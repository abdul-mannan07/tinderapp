class Profile {
  final String name;
  final List<String> pics;
  final String descp;

  Profile({
    required this.name,
    required this.pics,
    required this.descp,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] ?? '',
      pics: List<String>.from(map['pics'] ?? []),
      descp: map['descp'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pics': pics,
      'descp': descp,
    };
  }
}
