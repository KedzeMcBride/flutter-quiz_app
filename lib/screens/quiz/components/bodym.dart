import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/controller_math.dart';
import 'package:flutter_svg/svg.dart';

import 'progress_bar.dart';
import 'cardMath.dart';

class math_body extends StatelessWidget {
  const math_body({
    Key? key, // Updated to Key?
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // So that we have access to our controller
    QuestionControllerMath _questionController =
        Get.put(QuestionControllerMath());
    return Stack(
      children: [
        SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                // Pass a UniqueKey or any other Key to ProgressBar
                child: ProgressBar(key: UniqueKey()),
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${_questionController.questionNumber.value}",
                      style: Theme.of(context)
                              .textTheme
                              .headlineMedium // Updated to headlineMedium
                              ?.copyWith(color: kSecondaryColor) ??
                          TextStyle(),
                      children: [
                        TextSpan(
                          text: "/${_questionController.questions.length}",
                          style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall // Updated to headlineSmall
                                  ?.copyWith(color: kSecondaryColor) ??
                              TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(thickness: 1.5),
              SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      question: _questionController.questions[index]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
