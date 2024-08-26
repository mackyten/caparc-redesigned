import 'package:caparc/bloc/counter_bloc.dart';
import 'package:caparc/blocs/bottom_nav_bar_bloc/bloc.dart';
import 'package:caparc/blocs/dload_bloc/dload_bloc.dart';
import 'package:caparc/blocs/favorites_bloc/bloc.dart';
import 'package:caparc/blocs/home_screen_bloc/bloc.dart';
import 'package:caparc/blocs/search_bloc/search_bloc.dart';
import 'package:caparc/blocs/upload_screen_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/firebase_options.dart';
import 'package:caparc/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => BottomNavBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => UploadBloc()),
        BlocProvider(create: (context) => HomeScreenBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
        BlocProvider(create: (context) => DloadBloc()),
        BlocProvider(create: (context) => SearchBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true),
        routes: caRoutes,
        initialRoute: '/',
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final counterBloc = CounterBloc();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             BlocBuilder<CounterBloc, CounterState>(
//                 bloc: counterBloc,
//                 builder: (BuildContext context, state) {
//                   return Text(state.count.toString());
//                 })
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Container(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FloatingActionButton(
//               onPressed: () {
//                 counterBloc.add(Decrement());
//               },
//               tooltip: 'Increment',
//               child: const Text("-"),
//             ),
//             const SizedBox(
//               width: 80,
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 // context.read<CounterCubit>().increment();

//                 counterBloc.add(Increment());
//               },
//               tooltip: 'Increment',
//               child: const Icon(Icons.add),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
