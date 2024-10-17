import 'package:caparc/blocs/home_bloc/bloc.dart';
import 'package:caparc/blocs/home_bloc/event.dart';

import 'package:caparc/blocs/home_bloc/state.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/enums/time_of_day.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/enums/account_status.dart';
import 'package:caparc/common/widgets/capstone_book.dart';
import 'package:caparc/common/widgets/empty_item.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size screenSize;
  late double _personalProfile;

  late UserState currentUser;
  late HomeScreenBloc homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);

  @override
  void initState() {
    currentUser = context.read<UserBloc>().state!;
    homeScreenBloc.add(GetProjects(currentUser.toUserModel()));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    _personalProfile = (screenSize.width -
            ((bodyPadding + insidePadding) * 2) -
            avatarSize.width) -
        4;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDayModel timeOfDay = TimeOfDayModel.getTimeOfDay(
      DateTime.now(),
    );
    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState?>(
        builder: (context, state) {
          final AccountStatusModel accountStatus =
              AccountStatusHelper.getStringValue(currentUser.accountStatus);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(bodyPadding),
                  width: screenSize.width,
                  constraints: const BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: timeOfDay.colors,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: defaultBoxShadow,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16)),
                    child: Padding(
                      padding: EdgeInsets.all(insidePadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(colors: [
                                  Colors.white38,
                                  Colors.white24,
                                  Colors.white12,
                                ])),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: _personalProfile,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentUser.getFullname(),
                                        style: titleStyle,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.badge,
                                            color: CAColors.secondary,
                                            size: iconsSize,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          SizedBox(
                                            width: _personalProfile -
                                                iconsSize -
                                                2,
                                            child: Text(
                                              currentUser.idNumber,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: detailSize,
                                                color: CAColors.accent,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          accountStatus.icon,
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          SizedBox(
                                            width: _personalProfile -
                                                iconsSize -
                                                2,
                                            child: Text(
                                              accountStatus.stringValue,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: detailSize,
                                                color: CAColors.accent,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          timeOfDay.icon,
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          SizedBox(
                                            width: _personalProfile -
                                                iconsSize -
                                                2,
                                            child: Text(
                                              timeOfDay.greeting,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: detailSize,
                                                color: CAColors.accent,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: avatarSize.width,
                                  height: avatarSize.height,
                                  decoration: BoxDecoration(
                                    color: CAColors.deactivated,
                                    borderRadius: BorderRadius.circular(
                                      avatarSize.width,
                                    ),
                                    image: currentUser.avatarLink == null
                                        ? null
                                        : DecorationImage(
                                          fit: BoxFit.cover,
                                            image: NetworkImage(
                                                currentUser.avatarLink!),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(insidePadding),
                                width: (screenSize.width / 2) -
                                    ((bodyPadding + (insidePadding * 1.5))),
                                decoration: BoxDecoration(
                                    color: CAColors.secondary.withOpacity(1),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: defaultBoxShadow),
                                child: Column(
                                  children: [
                                    Text(
                                      'Approved Projects',
                                      style: TextStyle(
                                          fontSize: detailSize,
                                          color: CAColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '${state?.myApprovedProjects.length ?? 0}',
                                      style: TextStyle(
                                          fontSize: titleSize,
                                          color: CAColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: insidePadding,
                              ),
                              Container(
                                padding: EdgeInsets.all(insidePadding),
                                width: (screenSize.width / 2) -
                                    ((bodyPadding + (insidePadding * 1.5))),
                                decoration: BoxDecoration(
                                  boxShadow: defaultBoxShadow,
                                  color: CAColors.warning.withOpacity(1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Pending Projects',
                                      style: TextStyle(
                                          fontSize: detailSize,
                                          color: CAColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '${state?.myPendingProjects.length ?? 0}',
                                      style: TextStyle(
                                          fontSize: titleSize,
                                          color: CAColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: bodyPadding,
                ),
                Padding(
                  padding: EdgeInsets.only(left: bodyPadding),
                  child: Text(
                    "New Projects",
                    style: subtitleStyle,
                  ),
                ),
                state?.newProjects == null || state!.newProjects.isEmpty
                    ? const SizedBox(height: 200, child: Emptyitem())
                    : SizedBox(
                        height: 280,
                        width: screenSize.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.newProjects.length,
                            itemBuilder: (_, i) {
                              final project = state.newProjects[i];
                              return CapstoneBook(
                                screenSize: screenSize,
                                project: project,
                                currentUser: currentUser,
                              );
                            }),
                      ),
                SizedBox(
                  height: bodyPadding,
                ),
                Padding(
                  padding: EdgeInsets.only(left: bodyPadding),
                  child: Text(
                    "My Approved Projects",
                    style: subtitleStyle,
                  ),
                ),
                state?.myApprovedProjects == null ||
                        state!.myApprovedProjects.isEmpty
                    ? const SizedBox(height: 200, child: Emptyitem())
                    : SizedBox(
                        height: 280,
                        width: screenSize.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.myApprovedProjects.length,
                            itemBuilder: (_, i) {
                              final project = state.myApprovedProjects[i];
                              return CapstoneBook(
                                screenSize: screenSize,
                                project: project,
                                currentUser: currentUser,
                              );
                            }),
                      ),
                SizedBox(
                  height: bodyPadding,
                ),
                Padding(
                  padding: EdgeInsets.only(left: bodyPadding),
                  child: Text(
                    "My Pending Projects",
                    style: subtitleStyle,
                  ),
                ),
                state?.myPendingProjects == null ||
                        state!.myPendingProjects.isEmpty
                    ? const SizedBox(height: 200, child: Emptyitem())
                    : SizedBox(
                        height: 280,
                        width: screenSize.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.myPendingProjects.length,
                            itemBuilder: (_, i) {
                              final project = state.myPendingProjects[i];
                              return CapstoneBook(
                                screenSize: screenSize,
                                project: project,
                                currentUser: currentUser,
                              );
                            }),
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
