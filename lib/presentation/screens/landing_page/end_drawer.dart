import 'package:caparc/blocs/profile_bloc/profile_bloc.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/data/models/end_drawer_item_model.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:caparc/presentation/screens/auth_screen/firebase_auth/firebase_auth.dart';
import 'package:caparc/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class EndDrawerMenu extends StatefulWidget {
  const EndDrawerMenu({super.key});

  @override
  State<EndDrawerMenu> createState() => _EndDrawerMenuState();
}

class _EndDrawerMenuState extends State<EndDrawerMenu> {
  late Size screenSize = MediaQuery.of(context).size;
  late ProfileBloc profileBloc = context.read<ProfileBloc>();

  final List<EndDrawerItemModel> items = [
    EndDrawerItemModel(
      onTap: () {},
      title: "Profile",
      icon: MingCuteIcons.mgc_user_3_fill,
      screen: "/home/profile",
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
                final item = items[i];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(item.screen)
                          .then((value) {
                        profileBloc.add(ResetState());
                      });
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            item.title,
                            style: titleStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Spacer(),
              InkWell(
                onTap: () {
                  Auth.signOut();
                },
                child: Container(
                  height: 60,
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: CAColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}