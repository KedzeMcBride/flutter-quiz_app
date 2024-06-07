import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/score/score_screenm.dart';

// Defining the Question class with required parameters
class QuestionMath {
  final int id, answer;
  final String question;
  final List<String> options;

  QuestionMath({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });
}

// Sample data with questions and answers
const List sample_data = [
  {
    "id": 1,
    "question":
        "1. An arithmetic progression (AsP) has first term 5 and common difference 2 What is the sum of the first 10 terms?",
    "options": ['100', '120', '210', '70'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question":
        "2. If the first term of a geometric progression (GP) is 2 and the common ratio is 3, what is the fifth term",
    "options": ['79', '82', '43', '54'],
    "answer_index": 3,
  },
  {
    "id": 3,
    "question":
        "The general solution of the differential equation dxdy​=ky depends on ?",
    "options": ['only x', 'both x and y', 'none of these', 'only y'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question":
        " The order of the differential equation  dx2d2y​+3dxdy​+2y=0 is?",
    "options": ['2', '3', '1', '5'],
    "answer_index": 0,
  },
  {
    "id": 5,
    "question":
        "A fair die is rolled twice. What is the probability of getting a sum of 8?",
    "options": ["5/36", "1/6", "1/12", "1/18"],
    "answer_index": 0,
  },
  {
    "id": 6,
    "question":
        "The population mean is 50 with a standard deviation of 10. What is the z-score for a value of 70?",
    "options": ["2", "1", "0", "-1"],
    "answer_index": 0,
  },
  {
    "id": 7,
    "question":
        "A box contains 3 red balls and 2 green balls. If two balls are drawn at random, what is the probability that both are red?",
    "options": ["1/10", "3/10", "1/2", "3/5"],
    "answer_index": 1,
  },
  {
    "id": 8,
    "question": "What is the solution to the integral ( int 1/x dx )?",
    "options": ["1/x^2 dx ", " e^x + C ", " x ln|x| + C ", "ln|x| + C "],
    "answer_index": 3,
  },
  {
    "id": 9,
    "question":
        "In a normal distribution, what percentage of data falls within one standard deviation from the mean?",
    "options": ["9.5%", "95%", "68%", "50%"],
    "answer_index": 2,
  },
  {
    "id": 10,
    "question":
        "If the odds of an event happening are 1 in 5, what is the probability of the event not happening?",
    "options": ["20%", "25%", "80%", "75%"],
    "answer_index": 2,
  },
];

// Controller class with the required mixins
class YourController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late PageController _pageController;

  final List<QuestionMath> _questions = sample_data
      .map(
        (question) => QuestionMath(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  bool _isAnswered = false;
  int? _correctAns;
  int? _selectedAns;
  RxInt _questionNumber = 1.obs;
  int _numOfCorrectAns = 0;

  Animation get animation => this._animation;
  PageController get pageController => this._pageController;
  List<QuestionMath> get questions => this._questions;
  bool get isAnswered => this._isAnswered;
  int get correctAns => this._correctAns!;
  int get selectedAns => this._selectedAns!;
  RxInt get questionNumber => this._questionNumber;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(QuestionMath question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(ScoreScreenM());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
