import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz/components/quiz_screenm.dart';

import '../quiz/quiz_screen.dart';

class SubjectSelectionScreen extends StatefulWidget {
  @override
  _SubjectSelectionScreenState createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animationGreen;
  late Animation<Color?> _animationBlue;
  late Animation<Color?> _animationYellow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animationGreen = ColorTween(
      begin: Colors.green,
      end: Colors.green[700],
    ).animate(_controller);
    _animationBlue = ColorTween(
      begin: Colors.blue,
      end: Colors.blue[700],
    ).animate(_controller);
    _animationYellow = ColorTween(
      begin: Colors.yellow,
      end: Colors.yellow[700],
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Quiz Subject'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/icons/library.jpg"), // replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationGreen,
                builder: (BuildContext context, Widget? child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          _animationGreen.value!),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(200, 60)), // Set the minWidth and height
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QuizScreen()), // Navigate to Screen class
                      );
                    },
                    child: Text('BIOLOGY'),
                  );
                },
              ),
              SizedBox(height: 40), // 40px Space between buttons
              AnimatedBuilder(
                animation: _animationBlue,
                builder: (BuildContext context, Widget? child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          _animationBlue.value!),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(200, 60)), // Set the minWidth and height
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QuizScreenM()), // Navigate to Screen class
                      );
                    },
                    child: Text('MATHS'),
                  );
                },
              ),
              SizedBox(height: 40), // 40px Space between buttons
              AnimatedBuilder(
                animation: _animationYellow,
                builder: (BuildContext context, Widget? child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          _animationYellow.value!),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(200, 60)), // Set the minWidth and height
                    ),
                    onPressed: () {
                      // Navigate to Civics Quiz
                    },
                    child: Text('CIVICS'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
