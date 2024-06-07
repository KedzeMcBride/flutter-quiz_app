import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/controller_math.dart';
import 'package:quiz_app/models/QuestionMath.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key, // Make Key nullable
    required this.question, // Use required keyword
  }) : super(key: key);

  final QuestionMath question;

  @override
  Widget build(BuildContext context) {
    QuestionControllerMath _controller = Get.put(QuestionControllerMath());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                    .textTheme
                    .titleLarge // Updated to titleLarge
                    ?.copyWith(color: kBlackColor) ??
                TextStyle(), // Use null-aware operators
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => _controller.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
