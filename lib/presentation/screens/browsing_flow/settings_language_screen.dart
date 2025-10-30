import 'package:flutter/material.dart';
import 'package:language_picker/languages.dart';

class SettingsLanguageScreen extends StatefulWidget {
  final Language selectedLanguage;
  const SettingsLanguageScreen({super.key, required this.selectedLanguage});

  @override
  State<SettingsLanguageScreen> createState() => _SettingsLanguageScreenState();
}

class _SettingsLanguageScreenState extends State<SettingsLanguageScreen> {
  late Language _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Language")),
      body: ListView.builder(
        itemCount: Languages.defaultLanguages.length,
        itemBuilder: (context, index) {
          final language = Languages.defaultLanguages[index];
          final isSelected = language.isoCode == _selectedLanguage.isoCode;

          return ListTile(
            title: Text(language.name),
            trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              // Update selected language and return it
              Navigator.pop(context, language);
            },
          );
        },
      ),
    );
  }
}
