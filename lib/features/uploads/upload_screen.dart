import 'package:caparc/blocs/upload_bloc/bloc.dart';
import 'package:caparc/blocs/upload_bloc/event.dart';
import 'package:caparc/blocs/upload_bloc/state.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/buttons.dart';
import 'package:caparc/common/widgets/dialogs/success_dialog.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/stepper.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:caparc/features/uploads/widgets/form_details.dart';
import 'package:caparc/features/uploads/widgets/review.dart';
import 'package:caparc/features/uploads/widgets/steps.dart';
import 'package:caparc/features/uploads/widgets/form_verification.dart';
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
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    UploadState initialState = uploadBloc.state;
    data = initialState.data;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CAStepper(
                index: state.currentStep,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: bodyPadding),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        forms(state),
                        Spacers.formFieldSpacers(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (state.currentStep > 0)
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        uploadBloc.add(ReturnStep()),
                                    child: const Text("Return"),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            _continueButton(
                              () => _onContinue(state),
                              state.isVerifying,
                              state,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: bottomNavBarHeight,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget forms(UploadState state) {
    if (state.currentStep == 0) {
      return VerificationForm(
        formKey: _step1FormKey,
        isVerifying: state.isVerifying,
        initialData: state.data.title,
        onChange: (val) {
          if (mounted) {
            setState(() {
              data.title = val;
            });
          }
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
      );
    } else if (state.currentStep == 1) {
      return DetailsForm(
        formKey: _step2FormKey,
        data: data,
        onChanged: (updatedData) {
          data = updatedData;
        },
      );
    } else if (state.currentStep == 2) {
      return UploadReview(
        data: data,
      );
    }

    return Container();
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
          AddDetails(data.approvedOn!, data.projectAbstract!, data.pickedFile),
        );
      }
    } else {
      uploadBloc.add(SubmitProject(
        onSuccess: (project) {
          UploadState initialState = uploadBloc.state;
          data = initialState.data;
          showSuccessDialog(
            context: context,
            message: "\"${project.title}\" has been successfully submitted!",
          );
        },
      ));
    }
  }
}
