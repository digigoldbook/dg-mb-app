import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocaleCubit extends Cubit<Locale> {
  final Box languageBox;

  LocaleCubit(this.languageBox)
      : super(
          Locale(
            languageBox.get('languageCode', defaultValue: 'ne'),
          ),
        );

  // Switches language and saves to Hive
  void switchLocale(String languageCode) {
    emit(Locale(languageCode));
    languageBox.put('languageCode', languageCode);
  }
}
