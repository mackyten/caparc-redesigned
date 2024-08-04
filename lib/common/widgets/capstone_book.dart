import 'package:caparc/common/values.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CapstoneBook extends StatelessWidget {
  final Size screenSize;
  final String title;
  const CapstoneBook(
      {super.key, required this.screenSize, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(insidePadding),
          height: 280,
          width: 200,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 24, 53, 99),
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 24, 53, 99),
                    offset: Offset(7, 7)),
                BoxShadow(
                    color: Color.fromARGB(255, 224, 220, 220),
                    offset: Offset(5, 5)),
              ]),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 3,
                color: CAColors.accent,
                height: 250,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                width: 174,
                height: 250,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 168,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.amber.shade600,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Times',
                            overflow: TextOverflow.ellipsis),
                        maxLines: 8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '63 Views | 14 Downloads',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: Icon(
              Icons.favorite,
              color: Colors.grey,
            )),
      ],
    );
    // return Container(
    //   height: 280,
    //   width: screenSize.width,
    //   child: ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: 10,
    //       itemBuilder: (_, i) {

    //       }),
    // );
  }
}
