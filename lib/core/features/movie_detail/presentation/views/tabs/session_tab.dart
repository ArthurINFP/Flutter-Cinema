// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:cinema/core/features/ticket/payment_confirm_screen_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_event.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_state.dart';
import 'package:cinema/core/utils/localizations.dart';

class SessionTab extends StatefulWidget {
  String movieId;
  MovieDetailEntity movieDetailEntity;
  SessionTab({
    Key? key,
    required this.movieId,
    required this.movieDetailEntity,
  }) : super(key: key);

  @override
  State<SessionTab> createState() => _SessionTabState();
}

class _SessionTabState extends State<SessionTab> {
  MovieDetailBloc get bloc => BlocProvider.of<MovieDetailBloc>(context);
  bool _cinemaValue = false;
  DateTime sessionDate = DateTime.now();
  // MovieSessionEntity mockEntity = MovieSessionEntity(
  //     adultPrice: 100,
  //     childPrice: 100,
  //     filmFormat: "3D",
  //     sessionTime: DateTime.now(),
  //     studentPrice: 100,
  //     theater: "AEON Tân Phú",
  //     vipPrice: 200);

  ThemeData get theme => Theme.of(context);
  TextStyle? get textStyle =>
      theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700);
  TextStyle? get hintStyle => theme.textTheme.bodySmall
      ?.copyWith(fontWeight: FontWeight.w500, color: const Color(0xFF637394));
  @override
  void initState() {
    super.initState();
    bloc.add(GetMovieSessionEvent(
        sessionDate: sessionDate, movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: theme.colorScheme.surface,
          child: _buildSessionController(),
        ),
        _buildHeader(),
        BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
          if (state is SuccessMovieSessionSate) {
            return _buildSessionList(state.entityList);
          } else if (state is FailedMovieDetailState) {
            return SvgPicture.asset(Assets.svg.icEmptyPopcon);
          } else {
            return SvgPicture.asset(Assets.svg.icEmptyPopcon);
          }
        }),
      ],
    );
  }

  Widget _buildSessionController() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now()
                            .copyWith(month: DateTime.now().month + 1));
                    if (result != null) {
                      setState(() {
                        sessionDate = result;
                        bloc.add(GetMovieSessionEvent(
                            sessionDate: sessionDate, movieId: widget.movieId));
                      });
                    }
                  },
                  child: SvgPicture.asset(Assets.svg.icCalendar)),
            ),
            Expanded(child: SvgPicture.asset(Assets.svg.icSort)),
            Expanded(
              child: Switch(
                value: _cinemaValue,
                onChanged: (value) {
                  setState(() {
                    _cinemaValue = value;
                  });
                },
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                DateFormat("MMMM, d").format(sessionDate),
                textAlign: TextAlign.center,
                // sessionDate.year.toString(),
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                translates(context).time,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                translates(context).byCinema,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF253554),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                translates(context).time,
                textAlign: TextAlign.center,
                style: hintStyle,
              )),
          const SizedBox(
            width: 24,
          ),
          _buildHeaderItem(translates(context).adult),
          _buildHeaderItem(translates(context).child),
          _buildHeaderItem(translates(context).student),
          _buildHeaderItem(translates(context).vip),
          const SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }

  Expanded _buildHeaderItem(String content, {int flexRatio = 1}) {
    return Expanded(
        flex: flexRatio,
        child: Text(
          content,
          textAlign: TextAlign.start,
          style: hintStyle,
        ));
  }

  Widget _buildSessionList(List<MovieSessionEntity> sessionList) {
    return Expanded(
      child: ListView(
        // children: [_buildSessionRow(mockEntity)],
        children: List.generate(sessionList.length,
            (index) => _buildSessionRow(sessionList[index])),
      ),
    );
  }

  Widget _buildSessionRow(MovieSessionEntity entity) {
    TextStyle? moneyStyle = textStyle?.copyWith(fontWeight: FontWeight.w400);
    TextStyle? hourStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
    return GestureDetector(
      onTap: () {
        final TicketEntity ticketEntity = TicketEntity(
          title: widget.movieDetailEntity.title,
          runtime: widget.movieDetailEntity.runtime,
          theater: entity.theater,
          filmFormat: entity.filmFormat,
          time: entity.sessionTime,
          seats: ["F0", "F1"],
          unitPrice: entity.adultPrice,
        );
        Navigator.pushNamed(context, PaymentConfirmScreenRoute.screenName,
            arguments: ticketEntity);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Color(0xFF253554), width: 1))),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          DateFormat(DateFormat.HOUR24_MINUTE)
                              .format(entity.sessionTime ?? DateTime.now()),
                          textAlign: TextAlign.center,
                          style: hourStyle,
                        )),
                    Container(
                      width: 24,
                      alignment: Alignment.topLeft,
                      child: const VerticalDivider(
                        color: Color(0xFF253554),
                        width: 1,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Text(
                          entity.theater ?? "",
                          textAlign: TextAlign.start,
                          style: hourStyle.copyWith(fontSize: 14),
                        )),
                    const SizedBox(
                      width: 24,
                    )
                  ]),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        entity.filmFormat ?? "",
                        textAlign: TextAlign.center,
                        style: hintStyle,
                      )),
                  Container(
                    width: 24,
                    alignment: Alignment.topLeft,
                    child: const VerticalDivider(
                      color: Color(0xFF253554),
                      width: 1,
                      thickness: 1,
                    ),
                  ),
                  _buildSessionMoneyItem(
                      "${entity.adultPrice?.toStringAsFixed(0) ?? ""} \$",
                      moneyStyle),
                  _buildSessionMoneyItem(
                      "${entity.childPrice?.toStringAsFixed(0) ?? ""} \$",
                      moneyStyle),
                  _buildSessionMoneyItem(
                      "${entity.studentPrice?.toStringAsFixed(0) ?? ""} \$",
                      moneyStyle),
                  _buildSessionMoneyItem(
                      "${entity.vipPrice?.toStringAsFixed(0) ?? ""} \$",
                      moneyStyle),
                  const SizedBox(
                    width: 24,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionMoneyItem(String content, TextStyle? moneyStyle) {
    return Expanded(
        child: Text(
      content,
      textAlign: TextAlign.start,
      style: moneyStyle,
    ));
  }
}
