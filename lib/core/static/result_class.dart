import 'package:tmk/core/data/share_preferences.dart';
import 'package:tmk/core/static/test_class.dart';

import 'addition_class.dart';

class ResultTest {
  final TestOptions testOptions;
  final List<Adition> testQuestions;
  final int? secondsRemaining;

  ResultTest(
      {required this.testOptions,
      this.secondsRemaining,
      required this.testQuestions});

  int get correctAnswers =>
      testQuestions.where((element) => element.isCorrect ==true ).length;

  int get incorrectAnswers =>  testQuestions.where((element) => element.isCorrect == false ).length;

  int get notAnswered => testQuestions.where((element) => element.selectedOption == null ).length;

  int get score => correctAnswers * 10;


  int? get recordCorrectAnswers => UserSimplePreferences.getNumberWithKey('record');

  bool get isRecord => recordCorrectAnswers == null || correctAnswers > recordCorrectAnswers!;

  Future<void> saveRecord() async => await UserSimplePreferences.setNumberWithKey('record', correctAnswers);

  ResultTest.fromJson(Map<String, dynamic> json)
      : testOptions = TestOptions.fromJson(json['test']),
        secondsRemaining = json['secondsRemaining'],
        testQuestions = json['testQuestions'];

  Map<String, dynamic> toJson() => {
        'test': testOptions.toJson(),
        'secondsRemaining': secondsRemaining,
        'testQuestions': testQuestions.map((e) => e.toJson()).toList()
      };
}
