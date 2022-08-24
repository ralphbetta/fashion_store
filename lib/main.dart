import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/providers/theme.dart';
import 'package:fashion_shop/screens/login.dart';
import 'package:fashion_shop/screens/onboarding.dart';
import 'package:fashion_shop/screens/splash.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MultiProvider(
//     providers: const [
//       //StreamProvider(create: (_) => getSessionTime(), initialData: 0, ),
//       // StreamProvider.value(value: getProducts(), initialData: []),
//     ],
//     child: const MyApp(),
//   ));
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeClass.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: currentMode,
            theme: ThemeClass.lightTheme,
            darkTheme: ThemeClass.darkTheme,
            home: const MainScreen(),
          );
        });
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Splash();
  }
}
