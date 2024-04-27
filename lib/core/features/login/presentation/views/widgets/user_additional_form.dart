import 'dart:io';

import 'package:cinema/core/common/enums/city.dart';
import 'package:cinema/core/common/enums/gender.dart';
import 'package:cinema/core/themes/theme_data.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AdditionalForm extends StatefulWidget {
  final Function(String displayName, DateTime dateOfBirth, Gender gender,
      City city, XFile? image) onSubmitted;

  const AdditionalForm({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  _AdditionalFormState createState() => _AdditionalFormState();
}

class _AdditionalFormState extends State<AdditionalForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  Gender _selectedGender = Gender.other;
  City _selectedCity = City.hochiminh;
  TextEditingController dobController = TextEditingController();
  OutlineInputBorder get outlineBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF253554), width: 1));
  TextStyle get textStyle => TextStyle(
      fontSize: 16,
      color: darkTheme.colorScheme.primary,
      fontWeight: FontWeight.w500);
  DateTime? _selectedDate;
  XFile? _image;

  @override
  void initState() {
    // dobController.text =
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            _buildAvatar(),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _fullnameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box_sharp,
                  color: darkTheme.colorScheme.primary,
                ),
                hintText: translates(context).fullname,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: darkTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translates(context).required;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 24,
            ),
            _buildDateOfBirthRow(),
            const SizedBox(
              height: 24,
            ),
            _buildGenderRow(),
            const SizedBox(
              height: 24,
            ),
            _buildCityRow(),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Form is valid!');
                  widget.onSubmitted(_fullnameController.text, _selectedDate!,
                      _selectedGender, _selectedCity, _image);
                }
              },
              child: Text(
                translates(context).signup,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Row(
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
                maxHeight: 250,
                maxWidth: 350,
                imageQuality: 30);
            if (image != null) {
              setState(() {
                _image = image;
              });
            }
          },
          child: CircleAvatar(
            radius: 70,
            backgroundImage:
                (_image != null) ? FileImage(File(_image!.path)) : null,
            child: (_image == null)
                ? const Icon(
                    Icons.image_search_outlined,
                    size: 100,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthRow() {
    return _rowTemplate(
      title: translates(context).dateofbirth,
      rightWidget: IntrinsicWidth(
        child: GestureDetector(
          child: Container(
            padding: const EdgeInsets.only(bottom: 12),
            // constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
            child: TextFormField(
              readOnly: true,
              controller: dobController,
              textAlign: TextAlign.end,
              // style: textStyle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 2, left: 14),
                  // isCollapsed: true,
                  hintText: "Date of birth",
                  // hintStyle: hintStyle,
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
                    dobController.text = result;
                    _selectedDate = pickedDate;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translates(context).required;
                }
                return null;
              },
            ),
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
              style: TextStyle(fontSize: 14, color: color),
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
                  style: textStyle.copyWith(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _selectedCity = newValue;
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
}
