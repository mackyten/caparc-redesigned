import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/modals/change_email_modal.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import '../../common/widgets/modals/change_password_modal.dart';

class AccountAndSecurity extends StatefulWidget {
  const AccountAndSecurity({super.key});

  @override
  State<AccountAndSecurity> createState() => _AccountAndSecurityState();
}

class _AccountAndSecurityState extends State<AccountAndSecurity> {
  late UserBloc userBloc = context.read<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CAColors.appBG,
      appBar: AppBar(
        surfaceTintColor: CAColors.appBG,
        backgroundColor: CAColors.appBG,
        title: const Text("Account and Security"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: bodyPadding),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(300),
                  image: const DecorationImage(
                      image: AssetImage("assets/png/5337779.jpg"),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  "This helps to keep you account secure. Manage your password and email for authentication.",
                  style: valueStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    item(
                      title: "Change email",
                      iconData: MingCuteIcons.mgc_mail_line,
                      onTap: () => showChangeEmailModal(
                        context,
                        userBloc.state!.toUserModel(),
                      ),
                    ),
                    item(
                      title: "Change password",
                      iconData: MingCuteIcons.mgc_lock_line,
                      onTap: () => showChangePasswordModal(context: context),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget item(
      {required String title,
      required IconData iconData,
      required Function()? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.transparent,
          child: Row(
            children: [
              Icon(
                iconData,
                color: CAColors.accent,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: subtitleStyle,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: CAColors.accent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
