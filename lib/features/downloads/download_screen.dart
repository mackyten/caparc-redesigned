import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/dialogs/confirm_dialog.dart';
import 'package:caparc/common/widgets/empty_item.dart';
import 'package:caparc/features/downloads/widgets/downloaded_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/dload_bloc/dload_bloc.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late DloadBloc dloadBloc = context.read<DloadBloc>();

  @override
  void initState() {
    dloadBloc.add(GetDownLoads());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DloadBloc, DloadState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Emptyitem(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(bodyPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(state.items.length, (index) {
                    final item = state.items[index];
                    return DownloadedItem(
                      item: item,
                      deleteItem: _onLongPress,
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onLongPress(String path) {
    showConfirmDialog(
      context: context,
      title: "Delete file",
      message: "Would you like to proceed?",
      onPressed: () => dloadBloc.add(DeleteFile(filePath: path)),
    );
  }
}
