import 'package:cinema/core/common/bloc/app_bloc/app_bloc.dart';
import 'package:cinema/core/common/bloc/app_bloc/app_state.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_bloc.dart';
import 'package:cinema/core/features/home/presentation/views/home_screen.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:cinema/core/features/login/presentation/views/login_screen.dart';

import 'package:cinema/core/routes/route.dart';
import 'package:cinema/core/service/dio_client.dart';
import 'package:cinema/core/utils/dotenv.dart';
import 'package:cinema/firebase_options.dart';
import 'package:cinema/l10n/generated/app_localizations.dart';
import 'package:cinema/core/themes/theme_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

DioClient dioClient = DioClient();
void main() async {
  await DotEnvUtils.initDotEnv();
  dioClient.initDio();
  await initFirebase();

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
    print("App build here");
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            theme: darkTheme,
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            darkTheme: darkTheme,
            home: (FirebaseAuth.instance.currentUser != null)
                ? BlocProvider(
                    create: (context) => HomeBloc(), child: HomeScreen())
                : BlocProvider(
                    create: (context) => LoginBloc(), child: LoginScreen()),
            onGenerateRoute: RouteGenerator.generate,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale ?? const Locale('en'),
          );
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
