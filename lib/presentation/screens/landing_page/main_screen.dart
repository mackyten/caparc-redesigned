import 'package:caparc/blocs/bottom_nav_bar_bloc/bloc.dart';
import 'package:caparc/blocs/bottom_nav_bar_bloc/state.dart';
import 'package:caparc/common/widgets/bottom_navigation_bar.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:caparc/presentation/screens/downloads/download_screen.dart';
import 'package:caparc/presentation/screens/favorites/favorites_screen.dart';
import 'package:caparc/presentation/screens/home/home_screen.dart';
import 'package:caparc/presentation/screens/landing_page/end_drawer.dart';
import 'package:caparc/presentation/screens/search/search_screen.dart';
import 'package:caparc/presentation/screens/uploads/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/bottom_nav_bar_bloc/event.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late BottomNavBloc bottomNavState;
  late Size screenSize;

  @override
  void initState() {
    bottomNavState = context.read<BottomNavBloc>();
    _test();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  _test() async {
    // final DocumentReference document = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('O38n1BShQeYS3MkHvnSVWanxW9o1');

    // await document.get().then((DocumentSnapshot snapshot) {
    //   print('Document data: ${snapshot.data()}');
    //   print(snapshot.data().runtimeType);
    //   UserModel user =
    //       UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

    //   print(user.firstname);
    // });
  }

  @override
  Widget build(BuildContext context) {
    int selected = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CAColors.accent,
        foregroundColor: CAColors.white,
      ),
      endDrawer: const EndDrawerMenu(),
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
          bloc: bottomNavState,
          builder: (_, state) {
            return screen(state.selected);
          }),
      bottomNavigationBar: BottomNavBar(
        selected: selected,
        onSelect: (val) {
          bottomNavState.add(SelectItem(val));
        },
      ),
    );
  }

  Widget screen(int val) {
    switch (val) {
      case 0:
        return const HomeScreen();
      case 1:
        return const UploadScreen();
      case 2:
        return const FavoritesScreen();
      case 3:
        return const DownloadScreen();
      case 4:
        return const SearchScreen();
      default:
        return const Text("test");
    }
  }
}
