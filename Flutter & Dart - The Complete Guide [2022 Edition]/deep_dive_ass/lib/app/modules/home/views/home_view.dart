import 'package:deep_dive_ass/app/modules/home/views/components/bar_chart/chart.dart';
import 'package:deep_dive_ass/app/modules/home/views/components/body/body_form_input.dart';
import 'package:deep_dive_ass/app/modules/home/views/components/list/item_list.dart';
import 'package:deep_dive_ass/app/modules/home/views/components/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 300,
                  margin: EdgeInsets.only(top: 20),
                  child: Chart(listTransaction: _.listTransaction)),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.listTransaction.length,
                  itemBuilder: (context, index) {
                    return ItemList(
                        deleteTx: () {
                          _.listTransaction.removeAt(index);
                          _.update();
                        },
                        title: _.listTransaction[index].title!,
                        date: _.listTransaction[index].date!,
                        amount: _.listTransaction[index].amount!);
                  })
            ],
          ),
        ),
        floatingActionButton: _.isHideFloatBtn.value
            ? const SizedBox.shrink()
            : FloatingActionButton(
                onPressed: () => _.handleShowFormInput(),
                child: const Icon(Icons.add, color: Colors.black54),
              ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
