import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Emptyitem extends StatefulWidget {
  const Emptyitem({super.key});

  @override
  State<Emptyitem> createState() => _EmptyitemState();
}

class _EmptyitemState extends State<Emptyitem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(150)),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: CAColors.primary,
                      borderRadius: BorderRadius.circular(100)),
                  child: SvgPicture.asset(
                    'assets/svg/book-shelfv2.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: CAColors.primary.withOpacity(.60),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    color: CAColors.primary.withOpacity(.60),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 10,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                    color: CAColors.primary.withOpacity(.60),
                    borderRadius: BorderRadius.circular(13)),
              ),
            ),
            Positioned(
              top: 30,
              right: 5,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                    color: CAColors.primary.withOpacity(.60),
                    borderRadius: BorderRadius.circular(13)),
              ),
            ),
            const Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: SizedBox(
                    child: Text(
                  'Your shelf is empty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CAColors.primary, fontWeight: FontWeight.w600),
                )))
          ],
        ),
      ),
    );
  }
}
