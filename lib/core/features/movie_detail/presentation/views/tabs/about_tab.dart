import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutTab extends StatelessWidget {
  MovieDetailEntity entity;
  AboutTab({
    Key? key,
    required this.entity,
  }) : super(key: key);
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    print("Building About tab");
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              MyYoutubePlayer(entity: entity),
              _sectionRating(),
              _sectionContent(context)
            ]),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 343,
          height: 56,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
              color: const Color(0xffFF8036),
              borderRadius: BorderRadius.circular(8)),
          child: const Text(
            'Select Session',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _sectionRating() {
    return Container(
      color: theme.colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                entity.voteAverage.toStringAsFixed(1),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Rating',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff637394)),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                '7.9',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Kinopoisk',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff637394)),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionContent(BuildContext context) {
    TextStyle contentTextStyle = const TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);

    return Container(
      color: const Color(0xff1A2232),
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          entity.overview,
          style: contentTextStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        _buildRow(
            title: translates(context).certificate,
            content: entity.certificate),
        _buildRow(
            title: translates(context).runtime,
            content: entity.runtime.toString()),
        _buildRow(
            title: translates(context).release, content: entity.releaseDate),
        _buildRow(title: translates(context).gerne, content: entity.genre),
        _buildRow(
            title: translates(context).director, content: entity.director),
        _buildRow(
            title: translates(context).cast,
            content: entity.castNames,
            maxLines: 3),
      ]),
    );
  }

  Widget _buildRow(
      {required String title, required String content, int? maxLines}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                title,
                maxLines: maxLines,
                style: const TextStyle(
                    color: Color(0xff637394),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )),
          Expanded(
              flex: 3,
              child: Text(
                (content.isEmpty) ? "Updating" : content,
                maxLines: maxLines,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              )),
        ],
      ),
    );
  }
}

class MyYoutubePlayer extends StatefulWidget {
  MovieDetailEntity entity;
  MyYoutubePlayer({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  _MyYoutubePlayerState();

  late YoutubePlayerController _controller;

  YoutubePlayerController initController() {
    return YoutubePlayerController(
        initialVideoId: widget.entity!.youtubeUrl,
        flags: const YoutubePlayerFlags(
          useHybridComposition: false,
          autoPlay: false,
          mute: false,
          showLiveFullscreenButton: false,
          loop: false,
        ));
  }

  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = initController();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
