import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/common/widgets/course_picker/course_picker.dart';
import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  final UserModel data;
  final Function(UserModel data) onChanged;
  final GlobalKey<FormState> formKey;
  const ProfileForm(
      {super.key,
      required this.data,
      required this.onChanged,
      required this.formKey});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late UserModel dataCopy = widget.data;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [
              // CAFormField.textField(
              //   initialValue: widget.data.lastname,
              //   keyboardType: TextInputType.name,
              //   textCapitalization: TextCapitalization.words,
              //   labelText: "Lastname",
              //   onChange: (val) {
              //     if (val == null) return;
              //     dataCopy.lastname = val;
              //     widget.onChanged(dataCopy);
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Lastname is required";
              //     }
              //     return null;
              //   },
              // ),

              TextFormField(
                initialValue: widget.data.lastname,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text("Lastname"),
                ),
                onChanged: (val) {
                  dataCopy.lastname = val;
                  widget.onChanged(dataCopy);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lastname is required";
                  }
                  return null;
                },
              ),
              Spacers.formFieldSpacers(),
              // CAFormField.textField(
              //   initialValue: widget.data.firstname,
              //   keyboardType: TextInputType.name,
              //   textCapitalization: TextCapitalization.words,
              //   labelText: "Firstname",
              //   onChange: (val) {
              //     if (val == null) return;
              //     dataCopy.firstname = val;
              //     widget.onChanged(dataCopy);
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Firstname is required";
              //     }
              //     return null;
              //   },
              // ),

              TextFormField(
                initialValue: widget.data.firstname,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text("Firstname"),
                ),
                onChanged: (val) {
                  dataCopy.firstname = val;
                  widget.onChanged(dataCopy);
                },
              ),
              Spacers.formFieldSpacers(),
              // CAFormField.textField(
              //   initialValue: widget.data.middlename,
              //   keyboardType: TextInputType.name,
              //   textCapitalization: TextCapitalization.words,
              //   labelText: "Middlename",
              //   onChange: (val) {
              //     dataCopy.middlename = val;
              //     widget.onChanged(dataCopy);
              //   },
              // ),
              TextFormField(
                initialValue: widget.data.firstname,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text("Middlename"),
                ),
                onChanged: (val) {
                  dataCopy.middlename = val;
                  widget.onChanged(dataCopy);
                },
              ),

              Spacers.formFieldSpacers(),
              Row(
                children: [
                  Expanded(
                    child: CADateFormField(
                      initialValue: widget.data.birthdate,
                      label: "Birthdate",
                      onPicked: (val) {
                        setState(() {
                          dataCopy.birthdate = val;
                        });
                        widget.onChanged(dataCopy);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Birthdate is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 90,
                    // child: CAFormField.textField(
                    //   enabled: false,
                    //   keyboardType: TextInputType.name,
                    //   textCapitalization: TextCapitalization.words,
                    //   labelText: "Age",
                    //   initialValue: widget.data.getAge(),
                    // ),
                    child: TextField(
                      decoration: InputDecoration(label: Text("Age")),
                    ),
                  ),
                ],
              ),
              Spacers.formFieldSpacers(),
              CoursePicker(
                initialValue: widget.data.course,
                onItemPicked: (CourseModel val) {
                  setState(() {
                    dataCopy.course = val;
                  });
                  widget.onChanged(dataCopy);
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Course is required";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
