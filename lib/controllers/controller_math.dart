import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/QuestionMath.dart';
import 'package:quiz_app/screens/score/score_screenm.dart';

class QuestionControllerMath extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Marking _animationController and _animation as late
  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController; // Marking _pageController as late
  PageController get pageController => this._pageController;

  final List<QuestionMath> _questions = sample_data
      .map(
        (question) => QuestionMath(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<QuestionMath> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int? _correctAns; // Making _correctAns nullable
  int get correctAns => this._correctAns!;

  int? _selectedAns; // Making _selectedAns nullable
  int get selectedAns => this._selectedAns!;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update(); // This replaces the need for setState
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
