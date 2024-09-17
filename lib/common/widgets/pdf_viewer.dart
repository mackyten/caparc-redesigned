import 'dart:io';

import 'package:caparc/common/values.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class CAPDFViewer extends StatefulWidget {
  final String path;

  const CAPDFViewer({super.key, required this.path});

  @override
  State<CAPDFViewer> createState() => _CAPDFViewerState();
}

class _CAPDFViewerState extends State<CAPDFViewer> {
  PDFDocument? document;
  int? pages;
  int? currentPage;

  @override
  void initState() {
    _initiate();
    super.initState();
  }

  Future<void> _initiate() async {
    await _preventScreenshots();
    final doc = await PDFDocument.fromFile(File(widget.path));
    setState(() {
      document = doc;
    });
  }

  Future<void> _preventScreenshots() async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  void _allowScreenshots() {
    if (Platform.isAndroid) {
      FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  @override
  void dispose() {
    _allowScreenshots();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.path.split("/").last,
          style: titleStyle,
        ),
        surfaceTintColor: Colors.white,
      ),
      body: document == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: CAColors.appBG,
              child: PDFViewer(
                document: document!,
                scrollDirection: Axis.vertical,
                showPicker: false,
                showNavigation: false,
                backgroundColor: CAColors.appBG,
              ),
            ),
    );
  }
}
