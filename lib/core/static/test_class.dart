class TestOptions {
  String name;
  int cifras;
  int valores;
  int preguntas;
  int secondsPerQuestion;
  bool withOptions;

  TestOptions(
      {required this.name,
      required this.cifras,
      required this.valores,
      required this.preguntas,
      required this.secondsPerQuestion,
      required this.withOptions});

  TestOptions.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cifras = json['cifras'],
        valores = json['valores'],
        preguntas = json['preguntas'],
        secondsPerQuestion = json['secondsPerQuestion'],
        withOptions = json['withOptions'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'cifras': cifras,
        'valores': valores,
        'preguntas': preguntas,
        'secondsPerQuestion': secondsPerQuestion,
        'withOptions': withOptions
      };

  String toFormmatedString() {
    return '$name - $cifras cifra(s) - $valores valores | $secondsPerQuestion seg/p';
  }

  @override
  String toString() {
    return 'TestOptions{name: $name, cifras: $cifras, valores: $valores, preguntas: $preguntas, secondsPerQuestion: $secondsPerQuestion, withOptions: $withOptions}';
  }
}
