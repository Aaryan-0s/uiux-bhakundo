import 'package:flutter/material.dart';
import 'package:nba_hub/config/themes/app_theme.dart';

import '../config/router/app_route.dart';
import '../proximity.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProximityBrightnessControl(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getApplicationTheme(),
        initialRoute: AppRoute.splashScreen,
        routes: AppRoute.getApplicationRoute(),
      ),
    );
  }
}
