import 'package:flutter/cupertino.dart';
import 'package:food_pal/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  Color? backgroundColor;
  BigText({Key? key, this.color = const Color(0xFF332d2b),
    this.backgroundColor,
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size==0?Dimensions.font20:size,
        color: color,
        backgroundColor: backgroundColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
