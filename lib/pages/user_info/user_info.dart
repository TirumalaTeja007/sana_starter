import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';

import '../control_panel/control_panel_page.dart';

class UserInfoPage extends StatelessWidget {
  final DynamicController controller;

  const UserInfoPage(this.controller, {Key? key}) : super(key: key);

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black26),
        borderRadius: BorderRadius.circular(8.0));
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    return Form(
      key: formKey,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Tell us about you..",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18)),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.account_box,
                              color: Constants().activeColor[1.0]),
                          SizedBox(
                            width: Get.width * 0.6,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onSaved: (value) => name.text = value!,
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: const EdgeInsets.all(15),
                                  isDense: true,
                                  filled: true,
                                  errorMaxLines: 2,
                                  fillColor: Colors.white24,
                                  border: outlineBorder(),
                                  enabledBorder: outlineBorder(),
                                  focusedBorder: outlineBorder(),
                                  labelText: "Enter name",
                                  labelStyle: const TextStyle(
                                      fontSize: 14, color: Colors.black45),
                                  errorStyle: const TextStyle(height: 1),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto),
                              controller: name,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              GetStorage storage = GetStorage("user_info");
                              storage.write("user_name", name.text);
                              controller.openUserDialog.value = false;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Constants().activeColor[1.0]),
                          child: const Text("Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
