import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/events.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/snackbar.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/common/enums/account_status.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:caparc/services/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreeen extends StatefulWidget {
  const RegisterScreeen({super.key});

  @override
  State<RegisterScreeen> createState() => _RegisterScreeenState();
}

class _RegisterScreeenState extends State<RegisterScreeen> {
  late Size screenSize;
  final _formKey = GlobalKey<FormState>();
  TextEditingController idNumber = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController prefix = TextEditingController();
  TextEditingController suffix = TextEditingController();
  TextEditingController middlename = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserModel newUser = UserModel(
      id: '',
      firstname: '',
      middlename: '',
      lastname: '',
      birthdate: DateTime.now(),
      idNumber: '',
      accountStatus: AccountStatus.none,
      email: '',
      password: '');

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: bodyPadding, right: bodyPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Spacers.formFieldSpacers(),
                TextFormField(
                  controller: idNumber,
                  decoration: const InputDecoration(
                    labelText: 'ID Number',
                  ),
                  validator: _validator,
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: _validator,
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: _validator,
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: lastname,
                        decoration: const InputDecoration(
                          labelText: 'Lastname *',
                        ),
                        validator: _validator,
                      ),
                    ),
                    SizedBox(
                      width: bodyPadding,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: firstname,
                        decoration: const InputDecoration(
                          labelText: 'Firstname *',
                        ),
                        validator: _validator,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.20,
                      child: TextFormField(
                        controller: prefix,
                        decoration: const InputDecoration(
                          labelText: 'Prefix',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: bodyPadding,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.20,
                      child: TextFormField(
                        controller: suffix,
                        decoration: const InputDecoration(
                          labelText: 'Suffix',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: bodyPadding,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: middlename,
                        decoration: const InputDecoration(
                          labelText: 'Middle name',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                CADateFormField(
                  label: 'Date of Birth',
                  validator: _validator,
                  onPicked: (val) {
                    newUser.birthdate = val;
                  },
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _register, child: const Text('Register')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _register() async {
    if (_formKey.currentState!.validate()) {
      newUser
        ..idNumber = idNumber.text
        ..lastname = lastname.text
        ..firstname = firstname.text
        ..prefix = prefix.text.isEmpty ? null : prefix.text
        ..suffix = suffix.text.isEmpty ? null : suffix.text
        ..middlename = middlename.text
        ..email = email.text
        ..password = password.text;
      IFirebaseAuthService firebaseAuthService = FirebaseAuthService();

      final result = await firebaseAuthService.register(newUser: newUser);
      _handleResult(result);
    }
  }

  _handleResult(dynamic result) {
    if (result is UserModel) {
      UserBloc userBloc = BlocProvider.of<UserBloc>(context);
      UserState currentUser = UserState(
        id: result.id,
        firstname: result.firstname,
        middlename: result.middlename,
        lastname: result.lastname,
        birthdate: result.birthdate,
        idNumber: result.idNumber,
        accountStatus: result.accountStatus,
        prefix: result.prefix,
        suffix: result.suffix,
        email: result.email,
      );
      userBloc.add(SetUser(userState: currentUser));

      Navigator.of(context).pop();
    } else {
      CASnackbar.error(
          context, (result as FirebaseAuthException).message ?? 'error');
    }
  }

  String? _validator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required';
    }
    return null;
  }
}
