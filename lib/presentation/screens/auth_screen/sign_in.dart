import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/presentation/screens/auth_screen/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late Size screenSize;
  final _formKey = GlobalKey<FormState>();
  late UserBloc userBloc = context.read<UserBloc>();

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: screenSize.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(onPressed: _signIn, child: Text('Sign In')),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signIn() async {
    if (_formKey.currentState!.validate()) {
      await Auth.signIn(context, userBloc);
      // if (result != null) {
      //   UserBloc userBloc = UserBloc();

      //   userBloc.add(SignIn(
      //       userState: UserState(
      //           id: result.id,
      //           firstname: result.firstname,
      //           middlename: result.middlename,
      //           lastname: result.lastname,
      //           birthdate: result.birthdate,
      //           idNumber: result.idNumber,
      //           accountStatus: result.accountStatus,
      //           prefix: result.prefix,
      //           suffix: result.suffix)));
      // }
    }
  }
}
