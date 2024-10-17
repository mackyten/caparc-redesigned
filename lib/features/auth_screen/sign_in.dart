import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late Size screenSize;
  final _formKey = GlobalKey<FormState>();
  late UserBloc userBloc = context.read<UserBloc>();
  IFirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final List<String> otherAuths = [
    'assets/png/auth_icons/facebook.png',
    'assets/png/auth_icons/google.png',
    'assets/png/auth_icons/instagram.png',
  ];

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            constraints: const BoxConstraints(
              maxWidth: 520,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: CustomClipPath(),
                  child: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 10.0,
                    shadowColor: Colors.red,
                    child: Container(
                      width: double.infinity,
                      height: screenSize.height * .35,
                      decoration: const BoxDecoration(
                        color: CAColors.accent,
                      ),
                      child: Center(
                        child: LayoutBuilder(builder: (_, constraints) {
                          return Container(
                            height: constraints.maxHeight * .60,
                            width: constraints.maxWidth * .60,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                scale: .5,
                                image: AssetImage(
                                  'assets/png/caparc_logo.png',
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signIn,
                          child: const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New User?",
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: CAColors.text,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text("or"),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: CAColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(otherAuths.length, (i) {
                            final item = otherAuths[i];
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage(item),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const Text(
                        "Sign in with other accounts",
                        style: TextStyle(
                          color: CAColors.text,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signIn() async {
    if (_formKey.currentState!.validate()) {
      await firebaseAuthService.signIn(context, userBloc);
    }
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final Path path = Path();

    path.lineTo(0, h);

    path.quadraticBezierTo(
      w * .10,
      h * .80,
      w * .25,
      h * .8,
    );

    path.lineTo(
      w * .75,
      h * .8,
    );

    path.quadraticBezierTo(
      w * .90,
      h * .80,
      w,
      h * .70,
    );

    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
