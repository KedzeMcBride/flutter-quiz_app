import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
//import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:quiz_app/screens/welcome/option.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/icons/background.png",
              fit: BoxFit.fill), // background
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), // 2/6
                  Text(
                    "Let's Play Quiz,",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text("Enter your information below"),
                  Spacer(), // 1/6
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Player Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Spacer(), // 1/6
                  InkWell(
                    onTap: () => Get.to(
                        SubjectSelectionScreen()), //loads quiz_screen & selection screen
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Let's Start Quiz",
                        style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: Colors.black) ??
                            TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(flex: 2), // It will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
