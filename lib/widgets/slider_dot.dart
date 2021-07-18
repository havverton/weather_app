import 'package:flutter/material.dart';

class SliderDot extends StatelessWidget {
 final bool isActive;
  const SliderDot(this.isActive);


  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      width: isActive ? 12 : 5,
      height: 5,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(  borderRadius: BorderRadius.circular(5), color:  isActive ? Colors.white : Colors.white54), duration: Duration(milliseconds: 250),
    );
  }
}
