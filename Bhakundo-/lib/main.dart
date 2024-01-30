import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/core/my_app.dart';

import 'core/network/local/hive_service.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}
