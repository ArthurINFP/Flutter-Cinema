import 'package:cinema/core/features/home/presentation/bloc/home_bloc.dart';
import 'package:cinema/core/features/home/presentation/views/home_screen.dart';

import 'package:cinema/core/routes/route.dart';
import 'package:cinema/core/service/dio_client.dart';
import 'package:cinema/core/utils/dotenv.dart';
import 'package:cinema/firebase_options.dart';
import 'package:cinema/l10n/generated/app_localizations.dart';
import 'package:cinema/core/themes/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

DioClient dioClient = DioClient();
void main() async {
  await DotEnvUtils.initDotEnv();
  dioClient.initDio();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    initFirebase();
    return MaterialApp(
      theme: darkTheme,
      builder: EasyLoading.init(),
      darkTheme: darkTheme,
      home: BlocProvider(create: (context) => HomeBloc(), child: HomeScreen()),
      onGenerateRoute: RouteGenerator.generate,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
    );
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}
