import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;
  String _text = '';
  String _message = '';

  void calculateBMI() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    if (height == null || weight == null) {
      setState(() {
        _text = "Please enter your Height and Weight";
      });
      return;
    }

    if (height <= 0 || weight <= 0) {
      setState(() {
        _text = "Your Height and Weight must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmi = weight / pow((height), 2);
      if (_bmi! < 18.5) {
        _message = "Underweight";
      } else if (_bmi! > 18.5 && _bmi! < 25) {
        _message = 'Normal weight';
      } else if (_bmi! > 25 && _bmi! < 30) {
        _message = 'Pre-Obesity';
      } else if (_bmi! > 30 && _bmi! < 35) {
        _message = 'Obesity class 1';
      } else if (_bmi! > 35 && _bmi! < 40) {
        _message = 'Obesity class 2';
      } else {
        _message = 'Obesity class 3';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _heightController,
                keyboardType:TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Height',
                    suffixText: 'Meters'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  suffixText: 'Kilograms'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: calculateBMI,
                    child: const Text('Calculate'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _text,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    )
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _bmi == null ? '' : _bmi!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 60,
                              color: Colors.indigo
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('BMI',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black45,
                              ),
                            ),

                            Text(_message,
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 5,
                      color: Colors.black45,
                      indent: 10,
                      endIndent: 10,
                    ),

                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Nutritional Status',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                                color: Colors.blue,
                            ),
                            child: const Center(child: Text('Underweight: Below 18.5')),
                          ),
                          Container(
                            color: Colors.green,
                            child: const Center(child: Text('Normal weight: 18.5 - 24.9')),
                          ),
                          Container(
                            color: Colors.yellow,
                            child: const Center(child: Text('Pre-Obesity: 25.0 - 29.9')),
                          ),
                          Container(
                            color: Colors.orange,
                            child: const Center(child: Text('Obesity class 1: 30.0 - 34.9')),
                          ),
                          Container(
                            color: Colors.deepOrange,
                            child: const Center(child: Text('Obesity class 2: 35.0 - 39.9')),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                              color: Colors.red,
                            ),
                            child: const Center(child: Text('Obesity class 3: Above 40')),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}



