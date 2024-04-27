// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinema/core/features/account/presentation/bloc/account_bloc.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PaymentHistorySection extends StatefulWidget {
  List<TicketEntity> entities;
  PaymentHistorySection({
    Key? key,
    required this.entities,
  }) : super(key: key);

  @override
  State<PaymentHistorySection> createState() => _PaymentHistorySectionState();
}

class _PaymentHistorySectionState extends State<PaymentHistorySection> {
  ThemeData get theme => Theme.of(context);
  AccountBloc get bloc => BlocProvider.of<AccountBloc>(context);
  List<TicketEntity> get ticketEntities => widget.entities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 34, left: 16, right: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              translates(context).paymentshistory,
              style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: const Color(0xff637394)),
            ),
          ],
        ),
        _buildPaymentHistoryList(),
      ]),
    );
  }

  Widget _buildPaymentHistoryList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: ticketEntities.map((e) => _buildListItem(entity: e)).toList(),
    );
  }

  Widget _buildListItem({required TicketEntity entity}) {
    TextStyle? titleStyle = theme.textTheme.bodyLarge;
    TextStyle subTitleStyle = theme.textTheme.bodyMedium ?? const TextStyle();
    print((entity.id == null));
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: (entity.photoURL != null)
                ? Image.network(
                    entity.photoURL!,
                    height: 88,
                    width: 56,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(Assets.svg.icEmptyPopcon),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entity.title ?? "Updating",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
                Text(
                  (entity.time != null)
                      ? DateFormat.yMMMMd().add_jm().format(entity.time!)
                      : "Updating",
                  style: subTitleStyle,
                ),
                Text(
                  entity.theater ?? "Updating",
                  style: subTitleStyle.copyWith(color: const Color(0xff637394)),
                )
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                showMyAlertDialog(context, entity);
              },
              child: const Icon(Icons.delete_forever))
        ],
      ),
    );
  }

  showMyAlertDialog(BuildContext context, TicketEntity entity) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(translates(context).cancle));
    Widget okButton = TextButton(
        onPressed: () {
          (entity.id != null)
              ? bloc.add(DeleteTicketAccountEvent(
                  ticketId: entity.id!, entity: entity))
              : print("Failed find ID");
          Navigator.pop(context);
        },
        child: Text(translates(context).ok));
    AlertDialog alertDialog = AlertDialog(
      title: Text(translates(context).deleteticket),
      content: Text(translates(context).areyousure),
      actions: [cancelButton, okButton],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
