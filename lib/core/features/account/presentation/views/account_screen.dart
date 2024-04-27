// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cinema/core/features/account/presentation/views/widget/settings_section_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_bloc.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_state.dart';
import 'package:cinema/core/features/account/presentation/views/widget/information_section_widget.dart';
import 'package:cinema/core/features/account/presentation/views/widget/payment_history_section_widget.dart';
import 'package:cinema/core/features/login/presentation/login_screen_route.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:image_picker/image_picker.dart';

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
        if (state.status == BlocStatusState.loading) {
          EasyLoading.show();
        } else if (state.status == BlocStatusState.success) {
          EasyLoading.dismiss();
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
              behavior: SnackBarBehavior.floating,
            ));
          }
        } else if (state.status == BlocStatusState.failed) {
          EasyLoading.dismiss();
          showOkAlertDialog(context: context, message: state.message);
        } else {
          EasyLoading.dismiss();
          showOkAlertDialog(
            context: context,
            message: state.message,
          );
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state.status == BlocStatusState.loading) {
            return ((state.currentEntity != null) &&
                    (state.newEntity != null) &&
                    (state.ticketEntities != null))
                ? _BuildScreen(
                    currentEntity: state.currentEntity!,
                    newEntity: state.newEntity!,
                    ticketEntities: state.ticketEntities!,
                  )
                : Container();
          } else if (state.status == BlocStatusState.success) {
            return _BuildScreen(
              currentEntity: state.currentEntity!,
              newEntity: state.newEntity!,
              ticketEntities: state.ticketEntities!,
            );
          } else if (state.status == BlocStatusState.failed) {
            return ((state.currentEntity != null) &&
                    (state.newEntity != null) &&
                    (state.ticketEntities != null))
                ? _BuildScreen(
                    currentEntity: state.currentEntity!,
                    newEntity: state.newEntity!,
                    ticketEntities: state.ticketEntities!,
                  )
                : SvgPicture.asset(Assets.svg.icEmptyPopcon);
          } else {
            return SvgPicture.asset(Assets.svg.icEmptyPopcon);
          }
        },
      ),
    );
  }
}

class _BuildScreen extends StatefulWidget {
  AccountEntity currentEntity;
  AccountEntity newEntity;
  List<TicketEntity> ticketEntities;
  _BuildScreen({
    Key? key,
    required this.currentEntity,
    required this.newEntity,
    required this.ticketEntities,
  }) : super(key: key);

  @override
  State<_BuildScreen> createState() => _BuildScreenState();
}

class _BuildScreenState extends State<_BuildScreen> {
  ThemeData get theme => Theme.of(context);
  AccountBloc get bloc => BlocProvider.of<AccountBloc>(context);
  AccountEntity get entity => widget.currentEntity;
  AccountEntity get newEntity => widget.newEntity;
  List<TicketEntity> get ticketEntities => widget.ticketEntities;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(entity.photoURL);
    return Scaffold(
      appBar: _createAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildAvatar(),
          _buildUsernameTitle(),
          InformationSection(
            currentEntity: entity,
            newEntity: newEntity,
          ),
          SettingsSection(),
          PaymentHistorySection(entities: ticketEntities),
        ],
      )),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      scrolledUnderElevation: 0.0,
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
            onPressed: () {
              showMyAlertDialog(context);
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
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 200,
                  maxWidth: 300,
                  imageQuality: 30);
              if (image != null) {
                setState(() {
                  bloc.add(UpdateAccountAvatarEvent(image: image));
                });
              }
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: (entity.photoURL != null)
                  ? NetworkImage(entity.photoURL!)
                  : null,
              child: (entity.photoURL == null)
                  ? const Icon(
                      Icons.account_circle,
                      size: 70,
                    )
                  : null,
            ),
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

showMyAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(translates(context).cancle));
  Widget okButton = TextButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pop(context, true);
      },
      child: Text(translates(context).ok));
  AlertDialog alertDialog = AlertDialog(
    title: Text(translates(context).logout),
    content: Text(translates(context).areyousure),
    actions: [cancelButton, okButton],
  );
  showDialog(
    context: context,
    builder: (context) {
      return alertDialog;
    },
  ).then((value) {
    if (value) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreenRoute.screenName);
    }
  });
}
