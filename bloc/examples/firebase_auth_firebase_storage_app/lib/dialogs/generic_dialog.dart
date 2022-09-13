import 'package:flutter/material.dart';

// eğer birden fazla buton olacaksa burayı List<Map<String,T?>> şeklinde yapabiliriz
// TODO english
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

// bu fonksiyon sadece 2 yerde çağrılıyor
// bir tanesi main.dart'ın içinden error verirse orada
// diğeri ise text yerleri boşsa butonun içinden
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              // butona basıcna map'in değeri dönüyor, bu boolean da olabilir başka bir şeyde olabilir.
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
