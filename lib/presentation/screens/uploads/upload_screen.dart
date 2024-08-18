import 'package:caparc/blocs/upload_screen_bloc/bloc.dart';
import 'package:caparc/blocs/upload_screen_bloc/event.dart';
import 'package:caparc/blocs/upload_screen_bloc/state.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/common/widgets/buttons.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:caparc/presentation/screens/uploads/widgets/steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late Size screenSize;
  double bottomNavBarHeight = 0;
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  ProjectModel data = ProjectModel(
    id: "",
    createdAt: DateTime.now(),
    authorAccounts: [],
  );

  late UploadBloc uploadBloc = BlocProvider.of<UploadBloc>(context);
  //UploadState? state;

  @override
  void initState() {
    final userBloc = context.read<UserBloc>();
    uploadBloc.add(AddAuthor(UserModel(
      id: userBloc.state!.id,
      firstname: userBloc.state!.firstname,
      middlename: userBloc.state!.middlename,
      lastname: userBloc.state!.lastname,
      birthdate: userBloc.state!.birthdate,
      idNumber: userBloc.state!.idNumber,
      accountStatus: userBloc.state!.accountStatus,
      email: "",
      password: "",
    )));

    // data.authorAccounts?.add(

    // );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bottomNavBar = Scaffold.of(context).widget.bottomNavigationBar;
      if (bottomNavBar != null) {
        bottomNavBarHeight = 30;
        // setState(() {
        //   bottomNavBarHeight = (bottomNavBar as SizedBox).height ?? 0.0;
        // });
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    UploadState initiastate = uploadBloc.state;
    data = initiastate.data;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Stepper(
                    onStepContinue: () => _onContinue(state),
                    onStepCancel: () => uploadBloc.add(ReturnStep()),
                    type: StepperType.horizontal,
                    elevation: 0,
                    currentStep: state.currentStep,
                    controlsBuilder: (context, details) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _continueButton(
                              details.onStepContinue!,
                              state.isVerifying,
                              state,
                            ),
                            if (state.currentStep > 0)
                              Buttons.cancelButton(
                                ontap: state.isSubmitting
                                    ? null
                                    : details.onStepCancel!,
                                label: "RETURN",
                              )
                          ],
                        ),
                      );
                    },
                    steps: [
                      UploadsSteps.step1(
                        formKey: _step1FormKey,
                        currentStep: state.currentStep,
                        isVerifying: state.isVerifying,
                        initialData: state.data.title,
                        onChange: (val) {
                          setState(() {
                            data.title = val;
                          });
                        },
                        validator: (val) {
                          if (val == null ||
                              data.title == null ||
                              val.isEmpty ||
                              data.title!.isEmpty) {
                            return "Please enter your title.";
                          }
                          return null;
                        },
                      ),
                      UploadsSteps.step2(
                        formKey: _step2FormKey,
                        isActive: state.currentStep == 1,
                        data: state.data,
                        onChanged: (val) {
                          setState(() {
                            data = val;
                          });
                        },
                      ),
                      UploadsSteps.step3(
                        isActive: state.currentStep == 2,
                        item: state.data,
                        bottomNavBarHeight: bottomNavBarHeight,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _continueButton(
      VoidCallback onTap, bool isVerifying, UploadState state) {
    if (state.currentStep == 0) {
      return Buttons.verifyButton(
        onTap: onTap,
        isVerifying: isVerifying,
      );
    } else if (state.currentStep == 1) {
      return Buttons.continueButton(onTap: onTap);
    } else {
      return Buttons.sumbitButton(
        onTap: onTap,
        isSubmitting: state.isSubmitting,
      );
    }
  }

  void _onContinue(UploadState state) async {
    if (state.currentStep == 0) {
      if (_step1FormKey.currentState!.validate()) {
        uploadBloc.add(VerifyTitle(data.title!));
      }
    } else if (state.currentStep == 1) {
      if (_step2FormKey.currentState!.validate()) {
        uploadBloc.add(
          AddDetails(data.approvedOn!, data.projectAbstract!),
        );
      }
    } else {
      uploadBloc.add(SubmitProject(
        onSuccess: (project) {},
      ));
    }
  }
}
