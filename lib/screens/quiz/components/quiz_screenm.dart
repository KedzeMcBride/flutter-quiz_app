import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/controller_math.dart';

import 'package:quiz_app/screens/quiz/components/bodym.dart';

class QuizScreenM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionControllerMath _controller = Get.put(QuestionControllerMath());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter shows the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _controller.nextQuestion,
            child: Text("Skip"),
            style: TextButton.styleFrom(
              foregroundColor:
                  Colors.white, // Use foregroundColor instead of primary
            ),
          ),
        ],
      ),
      body: Bodym(),
    );
  }
}
