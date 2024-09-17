import 'dart:async';

import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/features/auth_screen/sign_in.dart';
import 'package:caparc/features/landing_page/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late UserBloc userBloc;
  StreamSubscription<User?>? authSubscription;

  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null && user.emailVerified) {
        if (userBloc.state != null && user.email != userBloc.state!.email) {
          // Email has changed, and it's verified
          if (kDebugMode) {
            print("USER HAS VERIFIED NEW EMAIL!");
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState?>(
        bloc: userBloc,
        builder: (BuildContext context, currentUser) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  currentUser != null &&
                  snapshot.data!.emailVerified) {
                // User is signed in
                return const LandingPage();
              } else if (snapshot.hasData &&
                  currentUser != null &&
                  !snapshot.data!.emailVerified) {
                return const Text("Please verify your email first");
              } else if (currentUser != null &&
                  snapshot.hasData &&
                  snapshot.data!.emailVerified &&
                  snapshot.data?.email != currentUser.email) {
                return Material(
                  child: Center(
                    child: Text("Should update userBloc first \n"
                        "snapshot.hasData:${snapshot.hasData}\n"
                        "snapshot.data!.emailVerified: ${snapshot.data!.emailVerified}\n"
                        "snapshot.data?.email != currentUser?.email: ${snapshot.data?.email != currentUser.email}"),
                  ),
                );
              } else {
                // User is not signed in
                return const SignInScreen();
              }
            },
          );
        });
  }
}
