import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_theme.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  return buildAppTheme();
});
