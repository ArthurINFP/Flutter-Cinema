import 'package:cinema/core/common/enums/city.dart';
import 'package:cinema/core/common/enums/gender.dart';
import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/login/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:cinema/core/features/login/presentation/bloc/register_bloc/register_event.dart';
import 'package:cinema/core/features/login/presentation/bloc/register_bloc/register_state.dart';
import 'package:cinema/core/features/login/presentation/views/widgets/user_additional_form.dart';
import 'package:cinema/core/features/login/presentation/views/widgets/user_detail_form.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AccountEntity entity = AccountEntity(uid: "registerID");
  int _currentStep = 0;
  String _password = "";
  XFile? _image;
  RegisterBloc get bloc => BlocProvider.of<RegisterBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.state == BlocStatusState.loading) {
          EasyLoading.show();
        } else if (state.state == BlocStatusState.success) {
          EasyLoading.dismiss();
          (state.status != null)
              ? showMyAlertDialog(context, state.status!)
              : null;
        } else if (state.state == BlocStatusState.success) {
          EasyLoading.dismiss();
          (state.status != null)
              ? showMyAlertDialog(context, state.status!)
              : null;
        } else {
          EasyLoading.dismiss();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildForm(_currentStep),
        ),
      ),
    );
  }

  Widget _buildForm(int step) {
    switch (step) {
      case 0:
        return UserDetailsForm(onSubmitted: (email, phoneNumber, password) {
          setState(() {
            entity.email = email;
            entity.phoneNumber = phoneNumber;
            _password = password;
            _currentStep++;
          });
        });
      case 1:
        return AdditionalForm(
            onSubmitted: (displayName, dateOfBirth, gender, city, image) {
          setState(() {
            entity.displayName = displayName;
            entity.dateOfBirth = dateOfBirth;
            entity.gender = gender;
            entity.city = city;
            _image = image;
          });
          bloc.add(RegisterWithEmailEvent(
              entity: entity, password: _password, image: _image));
        });

      default:
        return Center(child: Text('Unknown step'));
    }
  }

  showMyAlertDialog(BuildContext context, SignUpStatus status) {
    // Widget cancelButton = TextButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //     child: Text(translates(context).cancle));
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(translates(context).ok));
    AlertDialog alertDialog = AlertDialog(
      title: Text(translates(context).inform),
      content: Text(status.getTranslated(context)),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    ).then(
      (value) {
        if (status == SignUpStatus.success) {
          Navigator.pop(context);
        }
      },
    );
  }
}
