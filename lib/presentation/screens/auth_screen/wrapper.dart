import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/presentation/screens/auth_screen/sign_in.dart';
import 'package:caparc/presentation/screens/landing_page/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState?>(
        bloc: userBloc,
        builder: (BuildContext context, currentUser) {
          // if (currentUser == null) {
          //   return const SignInScreen();
          // } else {
          //   return const LandingPage();
          // }

          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData && currentUser != null) {
                // User is signed in
                return LandingPage();
              } else {
                // User is not signed in
                return SignInScreen();
              }
            },
          );
        });
  }
}
