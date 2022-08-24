import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sana_starter/constants/constants.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Constants().kWhite,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: Constants().kDarkBlue,
              elevation: 2,
              iconTheme: IconThemeData(color: Constants().kWhite),
              title: Text("Settings",
                  style: TextStyle(
                      color: Constants().kWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 20))),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Configuration",
                              style: TextStyle(
                                  color: Constants().kDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text("Enter the starter mobile number",
                              style: TextStyle(
                                  color:
                                      Constants().kDarkBlue.withOpacity(0.5))),
                          const SizedBox(height: 25),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.contact_phone_rounded,
                                    color: Constants().kOrange),
                                const SizedBox(width: 10),
                                textField(context)
                              ]),
                          const SizedBox(height: 15),
                          buttonWidget(context)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  textField(context) {
    return SizedBox(
      width: Get.width * 0.7,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) return "Phone number should not be empty";
          if (value.length < 10 ||
              value.contains(",") ||
              value.contains(".") ||
              value.contains(" ") ||
              value.contains("-")) {
            return "Invalid phone number";
          }
        },
        onSaved: (value) => mobileNumber.text = value!,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        style: TextStyle(color: Constants().kDarkBlue, fontSize: 16),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            isDense: true,
            filled: true,
            errorMaxLines: 2,
            fillColor: Colors.white24,
            border: outlineBorder(),
            enabledBorder: outlineBorder(),
            focusedBorder: outlineBorder(),
            labelText: "Mobile number",
            labelStyle: TextStyle(
                fontSize: 14, color: Constants().kDarkBlue.withOpacity(0.5)),
            errorStyle: const TextStyle(height: 1),
            floatingLabelBehavior: FloatingLabelBehavior.auto),
        controller: mobileNumber,
      ),
    );
  }

  buttonWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                GetStorage storage = GetStorage("config_info");
                storage.write("mobile_num", mobileNumber.text);
                Get.arguments["controller"].starterMobileNumber.value =
                    mobileNumber.text;
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Constants().kDarkBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            child: const Text("Save",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500))),
      ],
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black26),
        borderRadius: BorderRadius.circular(8.0));
  }
}
