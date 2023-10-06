import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pregnanciesField = TextEditingController();
  TextEditingController glucoseField = TextEditingController();
  TextEditingController bloodPressureField = TextEditingController();
  TextEditingController skinThicknessField = TextEditingController();
  TextEditingController insulinField = TextEditingController();
  TextEditingController bmiField = TextEditingController();
  TextEditingController diabetesPedigreeFunctionField = TextEditingController();
  TextEditingController ageField = TextEditingController();
  String result = "";
  String baseUrl = "https://nz0bgxd0-5000.inc1.devtunnels.ms/";

  Future<void> _predictDiabetes() async {
    try {
      print("-----------predict----------");

      final response = await http.post(
        Uri.parse('$baseUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'Pregnancies': int.parse(pregnanciesField.text),
          'Glucose': int.parse(glucoseField.text),
          'BloodPressure': int.parse(bloodPressureField.text),
          'Insulin': int.parse(insulinField.text),
          'SkinThickness': int.parse(skinThicknessField.text),
          'DiabetesPedigreeFunction':
              int.parse(diabetesPedigreeFunctionField.text),
          'Age': int.parse(ageField.text),
          'BMI': int.parse(bmiField.text)
        }),
      );

      if (response.statusCode == 200) {
        String data = jsonDecode(response.body)['result'];

        setState(() {
          result = " You are :  ${data}";
        });
      } else {
        setState(() {
          "Error at: ${response.statusCode}";
        });
      }
    } catch (e) {
      print("some Exception occurs $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Diabetes Prediction'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/greengradient.png"))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: pregnanciesField,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Pregnancies'),
                  ),
                  TextField(
                    controller: glucoseField,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Glucose'),
                  ),
                  TextField(
                    controller: bloodPressureField,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'bloodPressureField'),
                  ),
                  TextField(
                    controller: skinThicknessField,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'skinThicknessField'),
                  ),
                  TextField(
                    controller: bmiField,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'bmiField'),
                  ),
                  TextField(
                    controller: diabetesPedigreeFunctionField,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'diabetesPedigreeFunctionField'),
                  ),
                  TextField(
                    controller: insulinField,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'insulinField'),
                  ),
                  TextField(
                    controller: ageField,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'ageField'),
                  ),
                  ElevatedButton(
                    onPressed: _predictDiabetes,
                    child: const Text('Predict Now'),
                  ),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 30, color: Colors.red),
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}
