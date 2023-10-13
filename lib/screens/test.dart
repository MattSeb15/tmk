import 'package:flutter/material.dart';
import 'package:tmk/core/static/addition_class.dart';
import 'package:tmk/core/static/app_math_class.dart';
import 'package:tmk/core/static/result_class.dart';
import 'package:tmk/core/widgets/timers/countdown_timer.dart';
import 'package:tmk/screens/result.dart';

import '../core/static/test_class.dart';

class TestScreen extends StatefulWidget {
  final TestOptions test;
  const TestScreen({super.key, required this.test});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isPaused = false;
  int? secondsRemaining;

  List<Adition> testQuestions = [];

  int getRandomOptionsOrResult(int result) {
    final randomBool = AppMath.getRandomBool();
    if (randomBool) {
      return result;
    } else {
      final randomInt =
          AppMath.getRandomNumberMinMax(1, AppMath.getMaxWithNumber(result));
      final isPositive = AppMath.getRandomBool();
      return isPositive ? result + randomInt : result - randomInt;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testQuestions = List.generate(widget.test.preguntas, (index) {
      var ad = Adition(
          numbers: List.generate(widget.test.valores,
              (index) => AppMath.getRandomNumberWithC(widget.test.cifras)));
      ad.randomOptionOrResult = getRandomOptionsOrResult(ad.result);

      return ad;
    });

    debugPrint(testQuestions.map((e) => e.numbers.toString()).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          '${widget.test.preguntas} preguntas - ${widget.test.cifras} cifra(s) - ${widget.test.valores} valores | ${widget.test.secondsPerQuestion} seg/p',
          style: const TextStyle(fontSize: 13),
        )),
        body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: widget.test.preguntas,
            itemBuilder: (context, index) {
              final questionNumber = (index + 1).toString();

              final question = testQuestions[index];

              return _buildQuestion(index);
            }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CountdownTimer(
                secondsRemaining:
                    widget.test.secondsPerQuestion * widget.test.preguntas,
                isPaused: isPaused,
                onChanged: (val) {
                  secondsRemaining = val;
                  if (secondsRemaining == 0) {
                    setState(() {
                      isPaused = true;
                    });

                    final resultTest = ResultTest(
                        testOptions: widget.test,
                        secondsRemaining: secondsRemaining,
                        testQuestions: testQuestions);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (x) =>
                                ResultScreen(resultTest: resultTest)),
                        (route) => false);
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPaused = true;
                  });

                  final resultTest = ResultTest(
                      testOptions: widget.test,
                      secondsRemaining: secondsRemaining,
                      testQuestions: testQuestions);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (x) => ResultScreen(resultTest: resultTest)),
                      (route) => false);
                },
                child: const Text('Terminar'),
              ),
            ],
          ),
        ));
  }

  Widget _buildQuestion(int index) {
    final questionNumber = (index + 1).toString();

    final question = testQuestions[index];

    return ListTile(
      title: Text(
        'Pregunta $questionNumber.',
        style: const TextStyle(
            color: Color.fromARGB(255, 153, 129, 218), fontSize: 20),
      ),
      /* leading: Text(
        '$randomOptionWithResult | ${question.result}',
        style: TextStyle(color: question.isCorrect(randomOptionWithResult) ? Colors.green : Colors.red ),
      ), */
      subtitle: additionWidget(question, index),
    );
  }

  Widget additionWidget(Adition adition, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('+'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      adition.numbers.map((e) => Text(e.toString())).toList(),
                ),
              ],
            ),
            SizedBox(
                width: widget.test.cifras * 10,
                child: const Divider(
                  height: 1,
                  color: Colors.white,
                  thickness: 1,
                )),
            Text(
              adition.randomOptionOrResult.toString(),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: RadioListTile<bool?>(
                title: const Text('Correcto'),
                value: true,
                toggleable: true,
                groupValue: adition.selectedOption,
                onChanged: (value) {
                  setState(() {
                    testQuestions[index].selectedOption = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: RadioListTile<bool?>(
                title: const Text('Incorrecto'),
                toggleable: true,
                value: false,
                groupValue: adition.selectedOption,
                onChanged: (value) {
                  setState(() {
                    testQuestions[index].selectedOption = value;
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
