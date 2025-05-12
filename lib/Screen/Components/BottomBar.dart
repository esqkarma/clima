import 'package:clima/Screen/Components/Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/weatherDataProvider.dart';

class BottomBar extends StatelessWidget {
  final bool isDetailCard;
  const BottomBar({required this.isDetailCard,super.key});



  @override
  Widget build(BuildContext context) {
    final TextEditingController captionController = TextEditingController();
    double width = MediaQuery.of(context).size.width;

    return isDetailCard?Row(
      key: ValueKey(true),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AnimatedContainer(
              height: width * 0.15,
              width: width * 0.60,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15)),
              child: CustomTextfield(customController: captionController,
                hintText: 'type city',)
          ),
        ),
      ],
    ):SizedBox.shrink();
  }
}
