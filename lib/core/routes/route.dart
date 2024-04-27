import 'package:cinema/core/features/account/presentation/account_screen_route.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_bloc.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:cinema/core/features/account/presentation/views/account_screen.dart';
import 'package:cinema/core/features/home/home_screen_route.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_bloc.dart';
import 'package:cinema/core/features/home/presentation/views/home_screen.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:cinema/core/features/login/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:cinema/core/features/login/presentation/login_screen_route.dart';
import 'package:cinema/core/features/login/presentation/register_screen_route.dart';
import 'package:cinema/core/features/login/presentation/views/login_screen.dart';
import 'package:cinema/core/features/login/presentation/views/register_screen.dart';
import 'package:cinema/core/features/movie_detail/movie_detail_screen_route.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:cinema/core/features/movie_detail/presentation/views/movie_detail_screen.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:cinema/core/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:cinema/core/features/ticket/ticket_screen_route.dart';
import 'package:cinema/core/features/ticket/presentation/views/ticket_screen.dart';
import 'package:cinema/core/utils/testScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    switch (setting.name) {
      case LoginScreenRoute.screenName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
                create: (context) => LoginBloc(), child: const LoginScreen());
          },
        );
      case HomeScreenRoute.screenName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: HomeScreen(),
            );
          },
        );
      case MovieDetailScreenRoute.screenName:
        final args = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => MovieDetailBloc(),
              child: MovieDetailScreen(args: args),
            );
          },
        );
      case RegisterScreenRoute.screenName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => RegisterBloc(),
              child: const RegisterScreen(),
            );
          },
        );
      case TicketScreenRoute.screenName:
        final args = setting.arguments as TicketEntity;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => TicketBloc(),
              child: TicketScreen(entity: args),
            );
          },
        );
      case AccountScreenRoute.screenName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AccountBloc(),
              child: const AccountScreen(),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: HomeScreen(),
            );
          },
        );
    }
  }
}
