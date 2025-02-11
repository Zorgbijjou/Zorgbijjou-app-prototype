import 'package:flutter/material.dart';

class LocaleSelector extends StatelessWidget {
  const LocaleSelector({
    super.key,
    required this.locale,
    required this.supportedLocales,
    required this.onLocaleChanged,
  });

  final Locale locale;
  final List<Locale> supportedLocales;
  final void Function(Locale) onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      dropdownColor: Colors.black,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      iconEnabledColor: Colors.white,
      value: locale,
      icon: const Icon(Icons.language),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          onLocaleChanged(newLocale);
        }
      },
      items: supportedLocales.map<DropdownMenuItem<Locale>>((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(locale.languageCode
              .toUpperCase()), // You can customize this to show full language names
        );
      }).toList(),
    );
  }
}
