import 'package:caparc/presentation/screens/auth_screen/register.dart';
import 'package:caparc/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/auth_screen/wrapper.dart';

final Map<String, Widget Function(BuildContext)> caRoutes = {
  '/': (context) => Wrapper(),
  '/register': (context) => RegisterScreeen(),
  '/home/profile': (context) => ProfileScreen()
};
