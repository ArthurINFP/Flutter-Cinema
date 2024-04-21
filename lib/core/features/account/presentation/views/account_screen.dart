// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_bloc.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_state.dart';
import 'package:cinema/core/features/account/presentation/views/widget/information_section_widget.dart';
import 'package:cinema/core/features/login/presentation/login_screen_route.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:intl/intl.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  ThemeData get theme => Theme.of(context);
  AccountBloc get bloc => BlocProvider.of<AccountBloc>(context);
  @override
  void initState() {
    super.initState();
    bloc.add(GetAccountInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is LoadingAccountState ||
            state is LoadingUpdateAccountState) {
          EasyLoading.show();
        } else if (state is SuccessAccountState) {
          EasyLoading.dismiss();
          if (state.message != null) {
            showOkAlertDialog(context: context, message: state.message);
          }
        } else if (state is FailedAccountState) {
          EasyLoading.dismiss();
          showOkAlertDialog(context: context, message: state.message);
        } else if (state is FailedUpdateAccountState) {
          EasyLoading.dismiss();
          showOkAlertDialog(context: context, message: state.message);
        } else {
          EasyLoading.dismiss();
          showOkAlertDialog(
            context: context,
            message: "Unexpedted state",
          );
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is LoadingAccountState) {
            return Container();
          } else if (state is SuccessAccountState) {
            return _BuildScreen(
              entity: state.entity,
            );
          } else if (state is LoadingUpdateAccountState) {
            return _BuildScreen(
              entity: state.newEntity,
            );
          } else if (state is FailedUpdateAccountState) {
            return _BuildScreen(
              entity: state.oldEntity,
            );
          } else if (state is FailedAccountState) {
            return SvgPicture.asset(Assets.svg.icEmptyPopcon);
          } else {
            return SvgPicture.asset(Assets.svg.icEmptyPopcon);
          }
        },
      ),
    );
  }
}

class _BuildScreen extends StatefulWidget {
  AccountEntity entity;
  _BuildScreen({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<_BuildScreen> createState() => _BuildScreenState();
}

class _BuildScreenState extends State<_BuildScreen> {
  ThemeData get theme => Theme.of(context);
  AccountEntity get entity => widget.entity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildAvatar(),
          _buildUsernameTitle(),
          InformationSection(
            entity: entity,
          )
        ],
      )),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_left),
        iconSize: 40,
        color: const Color(0xff637394),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        translates(context).profile,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(
                  context, LoginScreenRoute.screenName);
            },
            icon: const Icon(Icons.logout, color: Color(0xff637394)))
      ],
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 28,
          ),
          CircleAvatar(
            radius: 40,
            backgroundImage: (entity.photoURL != null)
                ? Image.network(entity.photoURL!).image
                : null,
            child: (entity.photoURL == null)
                ? const Icon(Icons.account_circle)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameTitle() {
    return (entity.displayName == null)
        ? Placeholder()
        : Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entity.displayName!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                )
              ],
            ),
          );
  }
}
