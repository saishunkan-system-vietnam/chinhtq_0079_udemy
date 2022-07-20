import 'package:deep_dive_ass/app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/components/body/body_form_input.dart';

class HomeController extends GetxController {
  final listTransaction = <Transaction>[].obs;
  final isHideFloatBtn = false.obs;
  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputAmount = TextEditingController();
  TextEditingController inputDate = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void submit(){
    Get.back();
    final model = Transaction();
    model.title = inputTitle.text;
    model.amount = double.parse(inputAmount.text);
    model.date = DateTime.parse(inputDate.text);
    listTransaction.add(model);
    update();
  }

  void getDateTime() async {
    inputDate.text = await selectDate(Get.context!,
        initialDate: inputDate.text.isEmpty
            ? DateTime.now()
            : DateTime.parse(inputDate.text));
    update();
  }

  Future<String> selectDate(BuildContext context,
      {String initResult = "", required DateTime initialDate}) async {
    final f = DateFormat("yyyy-MM-dd");
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      return f.format(pickedDate);
    }
    return initResult;
  }

  void handleShowFormInput(){
    isHideFloatBtn(true);
    update();
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: Get.context!,
        isScrollControlled: true,
        builder: (context) {
          return const BodyFormInput();
        }).whenComplete(() {
      isHideFloatBtn(false);
      update();
    });
  }
}
