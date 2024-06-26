// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/core/common/bloc/app_bloc/app_bloc.dart';
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/presentation/account_screen_route.dart';
import 'package:cinema/core/features/login/presentation/login_screen_route.dart';
import 'package:cinema/core/features/login/presentation/views/login_screen.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/common/widget/customize_button.dart';
import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_bloc.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_event.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_state.dart';
import 'package:cinema/core/features/movie_detail/movie_detail_screen_route.dart';
import 'package:cinema/core/utils/testScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeData get theme => Theme.of(context);
  HomeBloc get bloc => BlocProvider.of<HomeBloc>(context);
  AppBloc get appBloc => BlocProvider.of<AppBloc>(context);
  final _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // logout();
    bloc.add(GetUpcomingAndNowPlayingMovieEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
    print("Build Home again");
    return BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.state == BlocStatusState.loading) {
            EasyLoading.show();
          } else if (state.state == BlocStatusState.success) {
            EasyLoading.dismiss();
            _isLoading = false;
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message!),
                behavior: SnackBarBehavior.floating,
              ));
            }
          } else if (state.state == BlocStatusState.failed) {
            EasyLoading.dismiss();
            showOkAlertDialog(context: context, message: state.message);
          } else {
            EasyLoading.dismiss();
            showOkAlertDialog(
                context: context, message: 'Something went wrong');
          }
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Container(
                      color: theme.colorScheme.background,
                      child: Column(
                        children: [
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state.state == BlocStatusState.loading) {
                                return Container();
                              } else if (state.state ==
                                  BlocStatusState.success) {
                                return _buildUpcomingCarousel(
                                    upComingMovies: state.upComingMovies!);
                              } else {
                                return SvgPicture.asset(
                                    Assets.svg.icEmptyPopcon);
                              }
                            },
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state.state == BlocStatusState.loading) {
                                return Container();
                              } else if (state.state ==
                                  BlocStatusState.success) {
                                return _buildNowInCinemaGridView(
                                    nowPlayingMovies: state.nowPlayingMovies!);
                              } else {
                                return SvgPicture.asset(
                                    Assets.svg.icEmptyPopcon);
                              }
                            },
                          ),
                          (_isLoading)
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(Assets.svg.icProductLogo),
          _buildAppBarInfoItem(assets: Assets.svg.icLocation, label: 'TP.HCM'),
          GestureDetector(
              onTap: () {},
              child: _buildAppBarInfoItem(
                  assets: Assets.svg.icLanguage, label: 'Eng')),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.state == BlocStatusState.success) {
                if (state.user != null) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AccountScreenRoute.screenName),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: (state.user!.photoURL != null)
                          ? Image.network(
                              state.user!.photoURL!,
                              fit: BoxFit.fill,
                            ).image
                          : null,
                      child: (state.user!.photoURL != null)
                          ? null
                          : const Icon(
                              Icons.account_circle,
                              size: 34,
                            ),
                    ),
                  );
                }
              }
              return GestureDetector(
                child: CustomizeButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreenRoute.screenName);
                  },
                  text: translates(context).login,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildAppBarInfoItem({required String assets, required String label}) {
    return Row(
      children: [
        SvgPicture.asset(assets),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildNowInCinemaGridView({required List<Movie> nowPlayingMovies}) {
    print("Building Gridview");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translates(context).nowincinemas,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              GestureDetector(child: SvgPicture.asset(Assets.svg.icSearch))
            ],
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
          ),
          itemCount: nowPlayingMovies.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildGridviewItem(context, nowPlayingMovies, index);
          },
        )
      ],
    );
  }

  Widget _buildGridviewItem(
      BuildContext context, List<Movie> nowPlayingMovies, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailScreenRoute.screenName,
            arguments: nowPlayingMovies[index].id.toString());
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(alignment: const Alignment(0.9, -0.95), children: [
              CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: nowPlayingMovies[index].posterUrl,
                width: 180,
                memCacheHeight: 400,
                height: 265,
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              (nowPlayingMovies[index].voteAverage != null)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        nowPlayingMovies[index].voteAverage!.toStringAsFixed(1),
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    )
                  : const Placeholder(),
            ]),
          ),
          Container(
            width: 163,
            child: Text(
              nowPlayingMovies[index].title ?? "No title",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ),
          Text(
            nowPlayingMovies[index]
                    .getGenre(translates(context).localeName)
                    ?.first ??
                "",
            maxLines: 1,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (!_isLoading && currentScroll >= maxScroll * 0.8) {
      setState(() {
        _isLoading = true;
      });

      bloc.add(GetUpcomingNextPageEvent());
    }
  }
}

class _buildUpcomingCarousel extends StatefulWidget {
  final List<Movie> upComingMovies;
  const _buildUpcomingCarousel({
    Key? key,
    required this.upComingMovies,
  }) : super(key: key);

  @override
  State<_buildUpcomingCarousel> createState() => _buildUpcomingCarouselState();
}

class _buildUpcomingCarouselState extends State<_buildUpcomingCarousel> {
  late List<Movie> movies;
  late ThemeData theme;
  int carouselActiveIndex = 0;
  @override
  Widget build(BuildContext context) {
    print("Build carousel");
    theme = Theme.of(context);
    movies = widget.upComingMovies;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                translates(context).upcoming,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        CarouselSlider(
            items: movies
                .map((e) => _buildCarouselItem(e.posterUrl, e.id ?? 0))
                .toList(),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  carouselActiveIndex = index;
                });
              },
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.4,
              aspectRatio: 4 / 3,
              viewportFraction: 0.55,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            )),
        const SizedBox(
          height: 24,
        ),
        AnimatedSmoothIndicator(
          activeIndex: carouselActiveIndex,
          count: movies.length,
          effect: ExpandingDotsEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: theme.colorScheme.primary,
              dotColor: theme.colorScheme.primaryContainer),
        )
      ],
    );
  }

  Widget _buildCarouselItem(String? url, int movieId) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailScreenRoute.screenName,
            arguments: movieId.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        // child: Image.network(url!),
        child: CachedNetworkImage(
          imageUrl: url!,
          placeholder: (context, url) => const Center(
              child: SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
