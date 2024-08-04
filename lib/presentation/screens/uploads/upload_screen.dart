import 'package:caparc/common/values.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late Size screenSize;
  int noOfSteps = 3;

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double progress = 1;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(bodyPadding),
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 20,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: screenSize.width,
                          height: 6,
                          decoration: BoxDecoration(
                              color: CAColors.disabledFields,
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width:
                              (screenSize.width - (bodyPadding * 2)) * progress,
                          height: 6,
                          decoration: BoxDecoration(
                              color: CAColors.success,
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: progress > 0.33
                            ? CAColors.success
                            : CAColors.deactivated,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 20,
                      width: 20,
                      child: Center(
                        child: progress > 0.33
                            ? const Icon(
                                Icons.check,
                                size: 12,
                                color: CAColors.white,
                              )
                            : Container(),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: progress >= 0.66
                            ? CAColors.success
                            : CAColors.deactivated,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 20,
                      width: 20,
                      child: Center(
                        child: progress >= 0.66
                            ? const Icon(
                                Icons.check,
                                size: 12,
                                color: CAColors.white,
                              )
                            : Container(),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: progress >= 1
                            ? CAColors.success
                            : CAColors.deactivated,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 20,
                      width: 20,
                      child: Center(
                        child: progress >= 1
                            ? const Icon(
                                Icons.check,
                                size: 12,
                                color: CAColors.white,
                              )
                            : Container(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
