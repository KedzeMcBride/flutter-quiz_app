import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/score/score_screen.dart';

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
        "1. The basic unit of life that carries out activities on its own is?",
    "options": ['Tissue', 'Cell', 'Organ', 'System'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "2. Which of the following is a by-product of photosynthesis?",
    "options": ['Helium', 'Nitrogen', 'CO2', 'Oxygen'],
    "answer_index": 3,
  },
  {
    "id": 3,
    "question":
        "The process by which food is broken down to release energy is?",
    "options": ['Photosynthesis', 'Respiration', 'Mitosis', 'Meiosis'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question":
        "Which of the following is not a function of the human skeleton?",
    "options": [
      'Secretion of hormones',
      'Provides support and body posture',
      'Stores minerals',
      'Produces RBC'
    ],
    "answer_index": 0,
  },
  {
    "id": 5,
    "question": "Which organ is used for bile production?",
    "options": ['Heart', 'Lung', 'Liver', 'Kidney'],
    "answer_index": 2,
  },
  {
    "id": 6,
    "question":
        " The process by which living organisms obtain characteristics from parents is called?",
    "options": [' Metabolism', 'Adaptation', 'Evolution', 'Heredity'],
    "answer_index": 3,
  },
  {
    "id": 7,
    "question":
        " What is the number of chromosomes needed to form a human embryo?",
    "options": ['46', '58', '40', ' 23'],
    "answer_index": 0,
  },
  {
    "id": 8,
    "question":
        "What gas is broken down at the root nodules of leguminous plants?",
    "options": ['CO2', 'Nitrogen', 'Helium', 'Fluorine'],
    "answer_index": 1,
  },
  {
    "id": 9,
    "question": "The building block of a protein molecule is called?",
    "options": ['Peptides', 'Glucose', 'Aldehydes', 'Amino acids'],
    "answer_index": 3,
  },
  {
    "id": 10,
    "question": "what is the chemical formula for glucose",
    "options": ['C6H12O6', 'C2H4O2', 'C6H12H12', 'C6O6'],
    "answer_index": 0,
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
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
