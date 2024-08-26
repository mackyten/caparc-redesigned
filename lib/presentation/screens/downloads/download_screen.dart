import 'package:caparc/presentation/screens/downloads/widgets/downloaded_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dload_bloc/dload_bloc.dart';

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
          return SingleChildScrollView(
            child: Column(
              children: [
                Text("Items: ${state.items.length}"),
                ...List.generate(state.items.length, (index) {
                  final item = state.items[index];
                  return DownloadedItem(
                    item: item,
                  );
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
