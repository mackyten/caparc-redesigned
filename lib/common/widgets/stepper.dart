import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CAStepper extends StatelessWidget {
  final int index;
  const CAStepper({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(builder: (_, constraints) {
        final elementWidth = constraints.maxWidth / 3;
        return Column(
          children: [
            iconTab(),
            const SizedBox(
              height: 10,
            ),
            tagTab(),
          ],
        );
        // return Expanded(
        //     child: Row(
        //   children: [
        //     Container(
        //       color: Colors.black12,
        //       width: elementWidth,
        //       child: Element(index == 0, "Verification"),
        //     ),
        //     Container(
        //       color: Colors.black12,
        //       width: elementWidth,
        //       child: Element(index == 1, "Details"),
        //     ),
        //     Container(
        //       color: Colors.black12,
        //       width: elementWidth,
        //       child: Element(index == 3, "Review"),
        //     ),
        //   ],
        // ));
      }),
    );
  }

  Widget iconTab() {
    return Row(
      children: [
        individualIconElement(isDone(0), 0),
        individualIconElement(isDone(1), 1),
        individualIconElement(isDone(2), 2),
      ],
    );
  }

  Widget tagTab() {
    return Row(
      children: [
        Expanded(child: tag(isDone(0), "Verification", 0)),
        Expanded(child: tag(isDone(1), "Details", 1)),
        Expanded(child: tag(isDone(2), "Review", 2)),
      ],
    );
  }

  Text tag(bool done, String val, int number) {
    return Text(
      val,
      style: GoogleFonts.poppins(
        color: done || index == number ? CAColors.accent : CAColors.deactivated,
        fontWeight:
            done || index == number ? FontWeight.w600 : FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget individualIconElement(bool done, int index) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: index == 0
                  ? null
                  : const Divider(
                      color: CAColors.accent,
                    ),
            ),
          ),
          sIcon(done),
          Expanded(
            child: SizedBox(
              child: index == 2
                  ? null
                  : const Divider(
                      color: CAColors.accent,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sIcon(bool done) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      child: done
          ? const Icon(
              Icons.check_circle,
              color: CAColors.success,
            )
          : const Icon(
              Icons.panorama_fish_eye,
              color: CAColors.deactivated,
            ),
    );
    // if (done) {

    // }
  }

  bool isDone(int num) {
    return index > num;
  }
}
