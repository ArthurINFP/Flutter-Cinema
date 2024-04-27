import 'package:cinema/core/common/bloc/app_bloc/app_bloc.dart';
import 'package:cinema/core/common/bloc/app_bloc/app_event.dart';
import 'package:cinema/core/common/bloc/app_bloc/app_state.dart';
import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsSection extends StatefulWidget {
  SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  AppBloc get appBloc => BlocProvider.of<AppBloc>(context);
  TextStyle textStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  ThemeData get theme => Theme.of(context);

  late String _selectedLocale;
  @override
  void initState() {
    super.initState();
    _selectedLocale = appBloc.state.locale?.languageCode ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                translates(context).settings,
                style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff637394)),
              ),
              _buildLocaleRow(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocaleRow() {
    return _rowTemplate(
        title: translates(context).language,
        rightWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _radioButton(
                locale: 'vi', icon: SvgPicture.asset(Assets.svg.icFlagsVN)),
            _radioButton(
                locale: 'en', icon: SvgPicture.asset(Assets.svg.icFlagsEN)),
          ],
        ));
  }

  Widget _radioButton({required String locale, required Widget icon}) {
    bool isActive = (locale == _selectedLocale);
    Color color = isActive ? Colors.white : const Color(0x1A6D9EFF);

    return GestureDetector(
      onTap: () {
        showAlertDialog(context, locale);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color, width: 1)),
        child: icon,
      ),
    );
  }

  Widget _rowTemplate({required String title, required Widget rightWidget}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: textStyle,
      ),
      rightWidget
    ]);
  }

  showAlertDialog(BuildContext context, String locale) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(translates(context).cancle));
    Widget okButton = TextButton(
        onPressed: () {
          setState(() {
            _selectedLocale = locale;
            appBloc.add(ChangeLanguageAppEvent(locale: Locale(locale)));
          });
          Navigator.pop(context);
        },
        child: Text(translates(context).ok));
    AlertDialog alertDialog = AlertDialog(
      title: Text(translates(context).changelanguage),
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
