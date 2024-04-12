// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  late ThemeData theme;
  late HomeBloc bloc;
  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<HomeBloc>(context);
    theme = Theme.of(context);
    if (movies.isEmpty) {
      bloc.add(GetUpcomingMovieEvent());
    }

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LoadingHomeState) {
          EasyLoading.show();
        } else if (state is SuccessfulHomeState) {
          EasyLoading.dismiss();
          movies = state.movies;
        } else if (state is FailedHomeState) {
          EasyLoading.dismiss();
          showOkAlertDialog(context: context, message: state.message);
        } else {
          EasyLoading.dismiss();
          showOkAlertDialog(context: context, message: 'Something went wrong');
        }
      },
      builder: (context, state) {
        print("Build Whole Screen");
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: theme.colorScheme.background,
                      child: Column(
                        children: [
                          _buildUpcomingCarousel(movies: movies),
                          _buildNowInCinemaGridView()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(Assets.svg.icProductLogo),
        _buildAppBarInfoItem(assets: Assets.svg.icLocation, label: 'TP.HCM'),
        _buildAppBarInfoItem(assets: Assets.svg.icLanguage, label: 'Eng'),
        CustomizeButton(
          onPressed: () {
            // Navigator.pushNamed(context, MovieDetailScreenRoute.screenName,
            //     arguments: movieId.toString());
            Navigator.pushNamed(context, TestScreen.screenName);
          },
          text: 'Profile',
        )
      ],
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

  Widget _buildNowInCinemaGridView() {
    print("Building Gridview");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Now in Cinema',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(Assets.svg.icSearch)
            ],
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
          ),
          itemCount: movies.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MovieDetailScreenRoute.screenName,
                    arguments: movies[index].id.toString());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: movies[index].posterUrl,
                      width: 190,
                      memCacheHeight: 400,
                      height: 260,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Container(
                    width: 163,
                    child: Text(
                      movies[index].title ?? "No title",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    movies[index].genre?.first ?? "No genre",
                    maxLines: 1,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

class _buildUpcomingCarousel extends StatefulWidget {
  final List<Movie> movies;
  const _buildUpcomingCarousel({
    Key? key,
    required this.movies,
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
    movies = widget.movies;
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Upcoming',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
