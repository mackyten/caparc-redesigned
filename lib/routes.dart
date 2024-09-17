import 'package:caparc/features/account_security/account_security.dart';
import 'package:caparc/features/auth_screen/register.dart';
import 'package:caparc/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'features/auth_screen/wrapper.dart';

final Map<String, Widget Function(BuildContext)> caRoutes = {
  '/': (context) => const Wrapper(),
  '/register': (context) => const RegisterScreeen(),
  '/home/profile': (context) => const ProfileScreen(),
  '/home/account-security': (context) => const AccountAndSecurity()
};
