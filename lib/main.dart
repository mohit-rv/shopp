import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/route_management/all_pages.dart';
import 'package:machine_test/route_management/routes.dart';
import 'package:machine_test/route_management/screen_bindings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    if (isIOS) {
      return GetCupertinoApp(
        debugShowCheckedModeBanner: false,
        initialRoute: splashScreen,
        getPages: AllPages.getPages(),
        initialBinding: ScreenBindings(),
        title: 'Machine test',
        theme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: GoogleFonts.poppins(),
          ),
        ),
      );
    } else {
      return ScreenUtilInit(
        designSize: const Size(360, 640),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: splashScreen,
          getPages: AllPages.getPages(),
          initialBinding: ScreenBindings(),
          title: 'Machine Test',
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            colorSchemeSeed: Colors.white,
          ),
        ),
      );
    }
  }
}
