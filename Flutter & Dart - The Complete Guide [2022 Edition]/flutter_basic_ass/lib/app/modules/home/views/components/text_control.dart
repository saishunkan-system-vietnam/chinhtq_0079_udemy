import 'package:flutter/material.dart';
import 'package:flutter_basic_ass/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_basic_ass/app/modules/home/views/components/text_output.dart';
import 'package:get/get.dart';

class TextControl extends StatelessWidget {
  TextControl({Key? key}) : super(key: key);

  String textValue(bool isChange){
    if(isChange){
      return "Change text value successful!!";
    }
    return "Hello!! Welcome to my app";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: (){
                _.isChange(!_.isChange.value);
                _.update();
              },
              child: Text("Change Text",style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            TextOutput(textValue: textValue(_.isChange.value))
          ],
        ),
      );
    });
  }
}
