import 'package:flutter/material.dart';
import 'package:tmk/core/static/addition_class.dart';
import 'package:tmk/core/static/result_class.dart';
import 'package:tmk/home.dart';

class ResultScreen extends StatefulWidget {
  final ResultTest resultTest;
  const ResultScreen({super.key, required this.resultTest});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Navigator.canPop(context) ? Navigator.pop(context) : null,
      child: Scaffold(
        
        bottomSheet: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.05,
            minChildSize: 0.05,
            maxChildSize: 0.6,
            builder: (context, controller) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,                    
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2 ,
                    child: const Divider(
                      height: 1,                    
                      color: Colors.white,
                      thickness: 3,
                    ),
                  ),  
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        ListTile(
                          title: const Text('TestOptions'),
                          trailing:
                              Text(widget.resultTest.testOptions.toFormmatedString()),
                        ),
                        ListTile(
                          title: const Text('Preguntas'),
                          trailing:
                              Text(widget.resultTest.testQuestions.length.toString()),
                        ),
                        ListTile(
                          title: const Text('Correctas'),
                          trailing: Text(widget.resultTest.correctAnswers.toString()),
                        ),
                        ListTile(
                          title: const Text('Incorrectas'),
                          trailing:
                              Text(widget.resultTest.incorrectAnswers.toString()),
                        ),
                        ListTile(
                          title: const Text('Sin responder'),
                          trailing: Text(widget.resultTest.notAnswered.toString()),
                        ),
                        ListTile(
                          title: const Text('Puntaje'),
                          trailing: Text(widget.resultTest.score.toString()),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Resultados'),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: const Icon(Icons.home))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: widget.resultTest.testQuestions.length,
                  itemBuilder: (context, index) {
                    final questionNumber = (index + 1).toString();
                    final adition = widget.resultTest.testQuestions[index];
                
                    return ListTile(
                      tileColor:
                          _getColorWithCorrect(adition.isCorrect).withOpacity(0.2),
                      title: Text('Pregunta $questionNumber.'),
                      subtitle: _buildQuestion(adition),
                      trailing: _getIconWithCorrect(adition.isCorrect),
                    );
                  }),
            ),
          const SizedBox(height: 35,)
          ],
        ),        
      ),
    );
  }

  Widget _buildQuestion(Adition adition) {
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
                width: widget.resultTest.testOptions.cifras * 10,
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
            IgnorePointer(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: RadioListTile<bool?>(
                  title: const Text('Correcto'),
                  value: true,
                  toggleable: true,
                  groupValue: adition.selectedOption,
                  onChanged: (value) {},
                ),
              ),
            ),
            IgnorePointer(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: RadioListTile<bool?>(
                  title: const Text('Incorrecto'),
                  toggleable: true,
                  value: false,
                  groupValue: adition.selectedOption,
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
        Text('Respuesta: ${adition.result}')
      ],
    );
  }

  Widget _getIconWithCorrect(bool? isCorrect) {
    switch (isCorrect) {
      case null:
        return const Icon(Icons.horizontal_rule, color: Colors.grey);
      case true:
        return const Icon(Icons.check, color: Colors.green);
      case false:
        return const Icon(Icons.close, color: Colors.red);
      default:
        return const Icon(Icons.horizontal_rule, color: Colors.grey);
    }
  }

  Color _getColorWithCorrect(bool? isCorrect) {
    switch (isCorrect) {
      case null:
        return Colors.grey;
      case true:
        return Colors.green;
      case false:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
