import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/buttons.dart';
import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:caparc/presentation/screens/uploads/widgets/steps.dart';
import 'package:caparc/services/firebase_queries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import 'widgets/upload_details_form.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late Size screenSize;
  bool isVerifying = false;
  int currentStep = 0;
  List<Step> steps = [];
  final _step1FormKey = GlobalKey<FormState>();

  ProjectModel data = ProjectModel(
    id: "",
    createdAt: DateTime.now(),
  );

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              child: Stepper(
                onStepContinue: _onContinue,
                onStepCancel: () {
                  if (currentStep > 0) {
                    setState(() {
                      currentStep--;
                    });
                  }
                },
                type: StepperType.horizontal,
                elevation: 0,
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _continueButton(details.onStepContinue!),
                        if (currentStep > 0)
                          Buttons.cancelButton(details.onStepCancel!)
                      ],
                    ),
                  );
                },
                steps: [
                  UploadsSteps.step1(
                    formKey: _step1FormKey,
                    currentStep: currentStep,
                    isVerifying: isVerifying,
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

                  // Step(
                  //   isActive: currentStep == 1,
                  //   title: Text("Details"),
                  //   content: UploadDetailsForm(
                  //     initialData: data,
                  //   ),
                  // ),

                  UploadsSteps.step2(
                    isActive: currentStep == 1,
                    data: data,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _continueButton(VoidCallback onTap) {
    if (currentStep == 0) {
      return Buttons.verifyButton(onTap: onTap, isVerifying: isVerifying);
    } else if (currentStep == 1) {
      return Buttons.continueButton(onTap: onTap);
    }

    return Container();
  }

  void _onContinue() async {
    if (currentStep == 0) {
      if (_step1FormKey.currentState!.validate()) {
        setState(() => isVerifying = true);
        final bool isExisting =
            await FirebaseQueries.checkTitleIfExists(data.title!);
        if (isExisting) {
          //TODO: ADD AN ERROR MODAL;
          print("Title already exists.");
          return;
        }

        await Future.delayed(const Duration(seconds: 2)).then((_) {
          setState(() {
            isVerifying = false;
            currentStep++;
          });
        });
      }
    }
  }
}
