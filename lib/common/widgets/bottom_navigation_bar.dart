import 'package:caparc/blocs/bottom_nav_bar_bloc/event.dart';
import 'package:caparc/common/widgets/models.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bottom_nav_bar_bloc/bloc.dart';

class BottomNavBar extends StatefulWidget {
  final int selected;
  final Function(int) onSelect;
  const BottomNavBar(
      {super.key, required this.selected, required this.onSelect});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late Size size;
  late EdgeInsets padding;
  late BottomNavBloc state;

  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.cloud_upload,
    CupertinoIcons.heart
  ];

  final List<BottomNavBarItem> items = [
    BottomNavBarItem(icon: CupertinoIcons.home, label: 'Home'),
    BottomNavBarItem(icon: CupertinoIcons.cloud_upload, label: 'Upload'),
    BottomNavBarItem(icon: CupertinoIcons.heart, label: 'Favorites'),
    BottomNavBarItem(
        icon: Icons.download_for_offline_outlined, label: 'Downloads'),
    BottomNavBarItem(icon: Icons.search, label: 'Search'),
  ];

  color(int val) {
    if (state.getSelected() == val) {
      return CAColors.accent;
    }
    return const Color.fromARGB(255, 92, 91, 91);
  }

  style(int val) {
    if (state.getSelected() == val) {
      return TextStyle(
          fontSize: 11, color: color(val), fontWeight: FontWeight.w700);
    }
    return TextStyle(fontSize: 10, color: color(val));
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    padding = MediaQuery.of(context).padding;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    state = context.read<BottomNavBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: padding.bottom),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            return InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                setState(() {
                  widget.onSelect(index);
                });
              },
              child: SizedBox(
                width: size.width / items.length,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Icon(
                          item.icon,
                          color: color(index),
                        ),
                      ),
                    ),
                    AnimatedDefaultTextStyle(
                        style: style(index),
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          item.label,
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
