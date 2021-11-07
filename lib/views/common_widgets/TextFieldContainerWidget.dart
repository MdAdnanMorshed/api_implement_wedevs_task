import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TextFieldContainerWidget extends StatelessWidget {
  final Widget child;
  const TextFieldContainerWidget({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      width: size.width * 0.90,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}