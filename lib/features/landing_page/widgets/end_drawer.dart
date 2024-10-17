import 'package:caparc/blocs/profile_bloc/profile_bloc.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/features/landing_page/models/end_drawer_item_model.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import '../../../common/widgets/dialogs/error_dialog.dart';

class EndDrawerMenu extends StatefulWidget {
  const EndDrawerMenu({super.key});

  @override
  State<EndDrawerMenu> createState() => _EndDrawerMenuState();
}

class _EndDrawerMenuState extends State<EndDrawerMenu> {
  late Size screenSize = MediaQuery.of(context).size;
  late ProfileBloc profileBloc = context.read<ProfileBloc>();
  IFirebaseAuthService firebaseAuthService = FirebaseAuthService();

  final List<EndDrawerItemModel> items = [
    EndDrawerItemModel(
      title: "Profile",
      icon: MingCuteIcons.mgc_user_3_fill,
      screen: "/home/profile",
    ),
    EndDrawerItemModel(
      title: "Account Security",
      icon: MingCuteIcons.mgc_lock_fill,
      screen: "/home/account-security",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: screenSize.width * .70,
        color: CAColors.accent,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
          ),
          child: Column(
            children: [
              ...List.generate(items.length, (i) {
                final menu = items[i];
                return item(
                  tag: menu.title,
                  icon: menu.icon,
                  onClicked: ()=> Navigator.of(context).pushNamed(menu.screen),
                );
              }),
              const Spacer(),
              item(
                  tag: "Logout",
                  icon: MingCuteIcons.mgc_exit_fill,
                  onClicked: firebaseAuthService.signOut),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget item(
      {required String tag, IconData? icon, required VoidCallback onClicked}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClicked,
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                tag,
                style: titleStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
