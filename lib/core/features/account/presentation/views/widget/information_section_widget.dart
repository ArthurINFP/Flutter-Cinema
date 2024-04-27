// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/common/enums/city.dart';
import 'package:cinema/core/common/enums/gender.dart';
import 'package:cinema/core/common/widget/customize_button.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_bloc.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:cinema/core/utils/localizations.dart';

class InformationSection extends StatefulWidget {
  AccountEntity currentEntity;
  AccountEntity newEntity;
  InformationSection({
    Key? key,
    required this.currentEntity,
    required this.newEntity,
  }) : super(key: key);

  @override
  State<InformationSection> createState() => _InformationSectionState();
}

class _InformationSectionState extends State<InformationSection> {
  ThemeData get theme => Theme.of(context);
  AccountEntity get currentEntity => widget.currentEntity;
  AccountBloc get bloc => BlocProvider.of<AccountBloc>(context);

  OutlineInputBorder get outlineBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF253554), width: 1));

  TextStyle textStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  late TextStyle hintStyle = textStyle.copyWith(
      color: const Color(0xff637394), fontStyle: FontStyle.italic);
  // Controller
  TextEditingController fullnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late Gender _selectedGender;
  late City _selectedCity;
  AccountEntity get newEntity => widget.newEntity;

  @override
  void initState() {
    super.initState();
    fullnameController.text = newEntity.displayName ?? "";
    dobController.text = (newEntity.dateOfBirth != null)
        ? DateFormat("dd/MM/yyyy").format(newEntity.dateOfBirth!)
        : "";
    phonenumberController.text =
        (newEntity.phoneNumber != null) ? newEntity.phoneNumber! : "";
    emailController.text = (newEntity.email != null) ? newEntity.email! : "";
    _selectedGender = newEntity.gender ?? Gender.other;
    _selectedCity = newEntity.city ?? City.hochiminh;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translates(context).infomation,
                style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff637394)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                _buildFullnameRow(),
                _buildDateOfBirthRow(),
                _buildPhonenumberRow(),
                _buildEmailRow(),
                _buildGenderRow(),
                _buildCityRow(),
                _buildSaveButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFullnameRow() {
    return _rowTemplate(
      title: translates(context).fullname,
      rightWidget: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: 50,
              minHeight: 50,
              maxWidth: MediaQuery.of(context).size.width / 2),
          child: TextField(
            controller: fullnameController,
            keyboardType: TextInputType.name,
            textAlign: TextAlign.end,
            style: textStyle,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 12, top: 8, right: 12, bottom: 10),
                isCollapsed: true,
                hintText: translates(context).yourname,
                hintStyle: hintStyle,
                border: outlineBorder),
            onChanged: (value) {
              setState(() {
                print("Fullname changed");
                newEntity.displayName = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateOfBirthRow() {
    return _rowTemplate(
      title: translates(context).dateofbirth,
      rightWidget: IntrinsicWidth(
        child: GestureDetector(
          child: Container(
            padding: const EdgeInsets.only(bottom: 12),
            constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
            child: TextField(
              readOnly: true,
              controller: dobController,
              textAlign: TextAlign.end,
              style: textStyle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 2, left: 14),
                  isCollapsed: true,
                  hintText: "Date of birth",
                  hintStyle: hintStyle,
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  border: outlineBorder),
              onTap: () async {
                final pickedDate = await showDatePicker(
                    context: context,
                    currentDate: (dobController.text == "")
                        ? DateTime.now()
                        : DateFormat("dd/MM/yyyy").parse(dobController.text),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now());
                final result = (pickedDate != null)
                    ? DateFormat("dd/MM/yyyy").format(pickedDate)
                    : "";
                if (result != "") {
                  setState(() {
                    print("DOB changed");
                    dobController.text = result;
                    newEntity.dateOfBirth = pickedDate!;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhonenumberRow() {
    return _rowTemplate(
      title: translates(context).phonenumber,
      rightWidget: IntrinsicWidth(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
          child: TextField(
            controller: phonenumberController,
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.end,
            style: textStyle,
            readOnly: (currentEntity.phoneNumber != null),
            maxLength: 10,
            decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.only(
                    left: 12, top: 8, right: 12, bottom: 10),
                isCollapsed: true,
                prefixIconConstraints:
                    const BoxConstraints(maxWidth: 33, maxHeight: 15),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.icFlagsVN,
                      ),
                    ],
                  ),
                ),
                hintText: translates(context).phonenumber,
                hintStyle: hintStyle,
                border: outlineBorder),
            onChanged: (value) {
              setState(() {
                print("Phone changed");
                newEntity.phoneNumber = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmailRow() {
    return _rowTemplate(
      title: translates(context).email,
      rightWidget: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: 50,
              minHeight: 50,
              maxWidth: MediaQuery.of(context).size.width / 2),
          child: TextField(
            controller: emailController,
            readOnly: (currentEntity.email != null),
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.end,
            style: textStyle,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 12, top: 8, right: 12, bottom: 10),
                isCollapsed: true,
                hintText: translates(context).youremail,
                hintStyle: hintStyle,
                border: outlineBorder),
            onChanged: (value) {
              setState(() {
                print("Email changed");
                newEntity.email = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGenderRow() {
    return _rowTemplate(
        title: translates(context).gender,
        rightWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _radioButton(gender: Gender.male),
            _radioButton(gender: Gender.female),
            _radioButton(gender: Gender.other)
          ],
        ));
  }

  Widget _radioButton({required Gender gender}) {
    bool isActive = (gender == _selectedGender);
    Color color = isActive ? Colors.white : const Color(0x1A6D9EFF);
    Icon radioIcon = isActive
        ? const Icon(
            Icons.radio_button_checked,
            color: Colors.white,
          )
        : const Icon(
            Icons.radio_button_off,
            color: Color(0x1A6D9EFF),
          );
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
          newEntity.gender = _selectedGender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        margin: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            radioIcon,
            const SizedBox(
              width: 2,
            ),
            Text(
              gender.getTranslateTitle(context),
              style: TextStyle(fontSize: 12, color: color),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCityRow() {
    return _rowTemplate(
        title: translates(context).city,
        rightWidget: Container(
          constraints: const BoxConstraints(maxHeight: 40),
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.only(left: 12, right: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF253554), width: 1)),
          child: DropdownButton<City>(
            value: _selectedCity,
            underline: SizedBox(),
            dropdownColor: const Color(0xB21F293D),
            items: <City>[
              City.hochiminh,
              City.hanoi,
              City.danang,
            ].map((City value) {
              return DropdownMenuItem<City>(
                value: value,
                child: Text(
                  value.getTranslateString(context),
                  style: textStyle,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _selectedCity = newValue;
                  newEntity.city = newValue;
                }
              });
            },
            style: const TextStyle(color: Colors.white),
          ),
        ));
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

  Widget _buildSaveButton() {
    return (currentEntity == newEntity)
        ? const SizedBox(
            height: 48,
          )
        : CustomizeButton(
            text: translates(context).save,
            textStyle: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w700),
            onPressed: () =>
                bloc.add(UpdateAccountInfoEvent(newEntity: newEntity)),
          );
  }
}
