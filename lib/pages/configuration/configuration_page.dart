import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sana_starter/constants/constants.dart';
import 'package:sana_starter/controller/dynamic_controller.dart';

callConfigurationPage(DynamicController controller) {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();

  Get.defaultDialog(
    barrierDismissible: true,
    buttonColor: Colors.white,
    titlePadding: const EdgeInsets.only(top: 20),
    title: "Starter Settings",
    titleStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    content: Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.contact_phone_rounded,
                  color: Constants().activeColor[1.0]),
              const SizedBox(width: 10),
              SizedBox(
                width: Get.width * 0.55,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number should not be empty";
                    } else if (value.length < 10 ||
                        (value.contains(",") ||
                            value.contains(".") ||
                            value.contains(" ") ||
                            value.contains("-"))) {
                      return "Invalid phone number";
                    }
                  },
                  onSaved: (value) => mobileNumber.text = value!,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: false,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
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
                      labelText: "Enter mobile number",
                      labelStyle:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                      errorStyle: const TextStyle(height: 1),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                  controller: mobileNumber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  GetStorage storage = GetStorage("config_info");
                  storage.write("mobile_num", mobileNumber.text);
                  Get.back();
                  controller.starterMobileNumber.value = mobileNumber.text;
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Constants().activeColor[1.0]),
              child: const Text("Save",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500))),
        ],
      ),
    ),
    contentPadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
  );
}

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.circular(8.0));
}
