import 'app_math_class.dart';

class Adition {
  List<int> numbers = [];
  int? randomOptionOrResult;
  bool? selectedOption;

  Adition(
      {required this.numbers, this.selectedOption, this.randomOptionOrResult});

  int get result => numbers.reduce((value, element) => value + element);
  bool? get isCorrect => selectedOption == null
      ? null
      : selectedOption ==true 
      ? randomOptionOrResult == result && selectedOption == true : randomOptionOrResult != result && selectedOption == false;

  Adition.fromJson(Map<String, dynamic> json, this.randomOptionOrResult)
      : numbers = json['numbers'],
        selectedOption = json['selectedOption'];

  Map<String, dynamic> toJson() =>
      {'numbers': numbers, 'selectedOption': selectedOption};
}
