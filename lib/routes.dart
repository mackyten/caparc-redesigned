import 'package:caparc/presentation/screens/account_security/account_security.dart';
import 'package:caparc/presentation/screens/auth_screen/register.dart';
import 'package:caparc/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/auth_screen/wrapper.dart';

final Map<String, Widget Function(BuildContext)> caRoutes = {
  '/': (context) => const Wrapper(),
  '/register': (context) => const RegisterScreeen(),
  '/home/profile': (context) => const ProfileScreen(),
  '/home/account-security': (context) => const AccountAndSecurity()
};
