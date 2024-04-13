// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';
import 'package:cinema/core/features/movie_detail/presentation/views/tabs/about_tab.dart';
import 'package:cinema/core/features/movie_detail/presentation/views/tabs/session_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_event.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_state.dart';
import 'package:cinema/core/utils/localizations.dart';

class MovieDetailScreen extends StatefulWidget {
  String args;
  MovieDetailScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  MovieDetailBloc get bloc => BlocProvider.of<MovieDetailBloc>(context);
  MovieDetailEntity? movieDetailEntity;
  bool isSuccess = false;
  ThemeData get theme => Theme.of(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(Localizations.localeOf(context).languageCode);
    bloc.add(GetMovieDetailEvent(
        movieId: widget.args,
        language: Localizations.localeOf(context).languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          if (state is LoadingMovieDetailState) {
            EasyLoading.show();
          } else if (state is SuccessMovieDetailState) {
            movieDetailEntity = state.movieDetailEntity;
            isSuccess = true;
            EasyLoading.dismiss();
          } else if (state is SuccessMovieSessionSate) {
            EasyLoading.dismiss();
          } else if (state is FailedMovieDetailState) {
            EasyLoading.dismiss();
            showOkAlertDialog(context: context, message: state.message);
          } else {
            EasyLoading.dismiss();
            showOkAlertDialog(
                context: context, message: 'Something went wrong at Screen');
          }
        },
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: const Color(0xff1A2232),
              appBar: AppBar(
                backgroundColor: theme.colorScheme.surface,
                centerTitle: true,
                title: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                  builder: (context, state) {
                    if (state is SuccessMovieDetailState ||
                        state is SuccessMovieSessionSate) {
                      return Text(
                        movieDetailEntity?.title ?? "Movie",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      );
                    } else {
                      return const Text(
                        "Movie",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      );
                    }
                  },
                ),
                bottom: _buildTabBar(context),
              ),
              body: TabBarView(children: [
                BlocBuilder<MovieDetailBloc, MovieDetailState>(
                    builder: (context, state) {
                  if (state is SuccessMovieDetailState) {
                    return AboutTab(entity: state.movieDetailEntity);
                  } else if (state is SuccessMovieSessionSate) {
                    if (movieDetailEntity != null) {
                      return AboutTab(entity: movieDetailEntity!);
                    }
                    return SvgPicture.asset(Assets.svg.icEmptyPopcon);
                  } else if (state is FailedMovieDetailState) {
                    return SvgPicture.asset(Assets.svg.icEmptyPopcon);
                  } else {
                    return SvgPicture.asset(Assets.svg.icEmptyPopcon);
                  }
                }),
                BlocBuilder<MovieDetailBloc, MovieDetailState>(
                    builder: (context, state) {
                  if (state is SuccessMovieDetailState) {
                    return SessionTab(
                      movieId: widget.args,
                      movieDetailEntity: state.movieDetailEntity,
                    );
                  } else if (state is SuccessMovieSessionSate) {
                    if (movieDetailEntity != null) {
                      return SessionTab(
                        movieId: widget.args,
                        movieDetailEntity: movieDetailEntity!,
                      );
                    }
                    return SvgPicture.asset(Assets.svg.icEmptyPopcon);
                  } else if (state is FailedMovieDetailState) {
                    return SvgPicture.asset(Assets.svg.icEmptyPopcon);
                  } else {
                    return SvgPicture.asset(Assets.svg.icEmptyPopcon);
                  }
                }),
              ]),
            )));
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: const Color(0xffFF8036),
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(translates(context).about,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFF8036))),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(translates(context).sessions,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFF8036))),
          ),
        ]);
  }
}
