import 'package:flutter/material.dart';
import 'package:tmk/screens/test.dart';
import 'core/static/test_class.dart';
import 'core/widgets/textfields/default_text_field.dart';
import 'core/widgets/textfields/default_text_field_number_picker.dart';
import 'core/widgets/time_pickers/seconds_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _name = TextEditingController();
  bool _withOptionsValue = false;

  int _cifras = 2;
  int _valores = 2;
  int _preguntas = 10;
  int seconsInitialValue = 60;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('TMK')),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    'TKM',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTextField(
                    width: 200,
                    height: 40,
                    fontSize: 13,
                    labelText: 'Nombre',
                    controller: _name,
                  ),
                  NumberPicker(
                    title: 'Cifras',
                    min: 1,
                    max: 9,
                    initialNumber: _cifras,
                    onChanged: (value) {
                      _cifras = value;                      
                    },
                  ),
                  NumberPicker(
                    title: 'Valores',
                    min: 2,
                    max: 9,
                    initialNumber: _valores,
                    onChanged: (value) {
                      _valores = value;                      
                    },
                  ),
                  NumberPicker(
                    title: 'Preguntas',
                    min: 5,
                    max: 100,
                    interval: 5,
                    initialNumber: _preguntas,
                    onChanged: (value) {
                      _preguntas = value;                      
                    },
                  ),
                  
                  const SizedBox(height: 20,),

                  SeconsPicker(                       
                    labelText: 'seg/p',
                    initialValue: seconsInitialValue,                
                    onChanged: (value) {
                      seconsInitialValue = value;                                        
                    },
                  ),
                  
                  

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _withOptionsValue ? 'Con opciones' : 'Simple',
                        style:const  TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                          value: _withOptionsValue,
                          onChanged: (v) =>
                              setState(() => _withOptionsValue = v)),
                    ],
                  ),
                 
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                      onPressed: (){
                        final test = TestOptions(
                          name: _name.text.isEmpty ? 'unnamed' : _name.text,
                          cifras: _cifras,
                          valores: _valores,
                          preguntas: _preguntas,
                          secondsPerQuestion: seconsInitialValue,
                          withOptions: _withOptionsValue,
                        );
                        
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => TestScreen(test: test,)),
                          );
                      },
                      child: const Text('Empezar'))
                ],
              ),
            ),
          )),
    );
  }
}
