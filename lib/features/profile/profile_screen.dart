import 'package:caparc/blocs/profile_bloc/profile_bloc.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/common/enums/account_status.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/avatar_default.dart';
import 'package:caparc/common/widgets/buttons/profile_button.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/features/profile/profile_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Size screenSize = MediaQuery.of(context).size;
  late ProfileBloc profileBloc = context.read<ProfileBloc>();
  late UserBloc userBloc = context.read<UserBloc>();
  late UserModel dataCopy = userBloc.state!.toUserModel();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileBlocState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            forceMaterialTransparency: true,
            foregroundColor: CAColors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                header(state),
                const SizedBox(
                  height: 41,
                ),
                _bodyBuiler(state),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            margin: const EdgeInsets.symmetric(horizontal: 33),
            child: ProfileButton(
              isLoading: state.isSubmitting,
              onPressed: () {
                if (state.isEditting && formKey.currentState!.validate()) {
                  profileBloc.add(
                    Submit(
                        data: dataCopy,
                        userBloc: userBloc,
                        onSuccessfulUpdate: () {
                          profileBloc.add(ResetState());
                          userBloc = context.read<UserBloc>();
                        }),
                  );
                } else if (!state.isEditting) {
                  profileBloc.add(SetEdit());
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state.isEditting
                        ? MingCuteIcons.mgc_check_2_fill
                        : MingCuteIcons.mgc_pencil_fill,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    state.isEditting ? "Update" : "Update Profile",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget header(ProfileBlocState state) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 5),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: CAColors.accent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            height: 300,
            width: double.infinity,
          ),
          Positioned(
            right: -41,
            top: -66,
            child: Container(
              width: 374,
              height: 366,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.15,
                ),
                borderRadius: BorderRadius.circular(
                  374,
                ),
              ),
            ),
          ),
          Positioned(
            right: -41,
            top: -66,
            child: Container(
              width: 221,
              height: 214,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.15,
                ),
                borderRadius: BorderRadius.circular(
                  374,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: animationDuration,
                    width: state.isEditting ? 120 : 80,
                    height: state.isEditting ? 120 : 80,
                    child: AvatarDefault(
                      isEditting: state.isEditting,
                      link: dataCopy.avatarLink,
                      pickedFile: dataCopy.pickedAvatar,
                      onFilePicked: (FilePickerResult? file) {
                        if (file != null) {
                          setState(() {
                            dataCopy.pickedAvatar = file.files.first;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AnimatedSwitcher(
                    duration: animationDuration,
                    child: state.isEditting
                        ? Container()
                        : Text(
                            userBloc.state!.getFullname(),
                            style: GoogleFonts.poppins(
                                color: CAColors.white,
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  AnimatedSwitcher(
                    duration: animationDuration,
                    child: state.isEditting
                        ? Container()
                        : Text(
                            userBloc.state!.idNumber,
                            style: GoogleFonts.poppins(
                              color: CAColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyBuiler(ProfileBlocState state) {
    return AnimatedSwitcher(
      duration: animationDuration,
      child: state.isEditting
          ? ProfileForm(
              formKey: formKey,
              data: dataCopy,
              onChanged: (data) {
                dataCopy = data;
              },
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: <Widget>[
                  _contentItem(
                    "Email",
                    MingCuteIcons.mgc_mail_fill,
                    userBloc.state!.email,
                  ),
                  _contentItem(
                    "Program Course",
                    MingCuteIcons.mgc_mortarboard_fill,
                    userBloc.state!.course?.description ?? "",
                  ),
                  _contentItem(
                    "Birthdate",
                    MingCuteIcons.mgc_cake_fill,
                    DateFormat("MMMM dd, yyyy").format(
                      userBloc.state!.birthdate,
                    ),
                  ),
                  _contentItem(
                    "Account Status",
                    MingCuteIcons.mgc_user_follow_fill,
                    AccountStatusHelper.getStringValue(
                            userBloc.state!.accountStatus)
                        .stringValue,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _contentItem(String title, IconData iconData, String value) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 30,
        top: 30,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: CAColors.accent,
            size: 22,
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: CAColors.accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  shadows: [
                    const Shadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 3,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
