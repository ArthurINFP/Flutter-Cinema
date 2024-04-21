// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/common/widget/customize_button.dart';
import 'package:cinema/core/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:cinema/core/features/ticket/presentation/bloc/ticket_event.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';

import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TicketScreen extends StatefulWidget {
  TicketEntity entity;
  TicketScreen({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  TicketBloc get bloc => BlocProvider.of<TicketBloc>(context);
  TicketEntity get entity => widget.entity;
  ThemeData get theme => Theme.of(context);
  TextStyle? textTitleStyle =
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translates(context).payforticket,
          style: textTitleStyle,
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            child: Column(
              children: [
                _buildInformationSection(context),
                _buildTearLine(),
                PhoneInputField(context: context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomizeButton(
                          backgroundColor: theme.colorScheme.primary,
                          borderRadius: 8,
                          onPressed: () {
                            bloc.add(CreateTicketEvent(entity: entity));
                          },
                          text: "Continue",
                          height: 56,
                          widget: double.infinity,
                          textStyle:
                              textTitleStyle!.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.entity.title ?? "Movie",
            style: textTitleStyle,
          ),
          const SizedBox(
            height: 16,
          ),
          _buildDetailRow(
              translates(context).cinema, entity.theater ?? "Theater",
              extraInfo: entity.filmFormat ?? ""),
          _buildDetailRow(
            translates(context).date,
            (entity.time != null)
                ? DateFormat.yMMMMd().add_jm().format(entity.time!)
                : DateTime.now().toString(),
          ),
          _buildDetailRow(
              translates(context).runtime, "${entity.runtime ?? 0} minutes"),
          _buildDetailRow(
              translates(context).seats, entity.seats?.join(", ") ?? ""),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF253554),
            ),
          ),
          _buildBillRow(
              "${entity.seats?.length ?? 0} x ${translates(context).adult}",
              "${entity.unitPrice ?? 0} \$"),
          _buildBillRow(translates(context).total,
              "${(entity.seats?.length ?? 0) * (entity.unitPrice ?? 0)} \$")
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String content,
      {String extraInfo = ""}) {
    TextStyle? hintStyle = TextStyle(
        color: theme.colorScheme.primaryContainer,
        fontSize: 14,
        fontWeight: FontWeight.w400);
    TextStyle? textStyle = const TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            title,
            style: hintStyle,
          )),
          Expanded(
              flex: 3,
              child: (extraInfo.isEmpty)
                  ? Text(
                      content,
                      style: textStyle,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          content,
                          style: textStyle,
                        ),
                        Text(
                          extraInfo,
                          style: hintStyle,
                        )
                      ],
                    ))
        ],
      ),
    );
  }

  Widget _buildBillRow(String title, String content) {
    TextStyle? hintStyle = TextStyle(
        color: theme.colorScheme.primaryContainer,
        fontSize: 16,
        fontWeight: FontWeight.w500);
    TextStyle? textStyle = const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Text(
                title,
                style: hintStyle,
              )),
              Expanded(flex: 3, child: Text(content, style: textStyle))
            ]));
  }

  Widget _buildTearLine() {
    List<Widget> result = [];
    result.add(SvgPicture.asset(Assets.svg.icLeftHalfEllipse));
    result.addAll(
        List.generate(16, (index) => SvgPicture.asset(Assets.svg.icEllipse)));
    result.add(SvgPicture.asset(Assets.svg.icRightHalfEllipse));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: result,
    );
  }
}

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  TextEditingController phoneController = TextEditingController();
  String? _errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          errorText: _errorText,
          hintText: translates(context).phonenumber,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF253554), width: 1)),
        ),
        onChanged: (value) => phoneController.text = value,
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.unfocus();

          setState(() {
            if (phoneController.text == "") {
              _errorText = "Required";
            } else {
              _errorText = null;
            }
          });
        },
      ),
    );
  }
}
