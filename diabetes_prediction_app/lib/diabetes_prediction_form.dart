import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiabetesPredictionForm extends StatefulWidget {
  @override
  _DiabetesPredictionFormState createState() =>
      _DiabetesPredictionFormState();
}

class _DiabetesPredictionFormState extends State<DiabetesPredictionForm> {
  final ageController = TextEditingController();
  final hypertensionController = TextEditingController();
  final heartDiseaseController = TextEditingController();
  final bmiController = TextEditingController();
  final hba1cController = TextEditingController();
  final glucoseController = TextEditingController();

  String gender = 'Male';
  String smokingHistory = 'Never';
  String predictionResult = '';
  bool isHypertension = false;
  bool isHeartDisease = false;

  // Function to handle prediction
  Future<void> predictDiabetes() async {
    final url = 'http://127.0.0.1:5000/predict'; // Ganti sesuai dengan IP Flask Anda

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'features': [
            int.parse(ageController.text),
            isHypertension ? 1 : 0,
            isHeartDisease ? 1 : 0,
            double.tryParse(bmiController.text) ?? 0.0,
            double.tryParse(hba1cController.text) ?? 0.0,
            double.tryParse(glucoseController.text) ?? 0.0,
            gender == 'Male' ? 1 : 0,
            gender == 'Other' ? 1 : 0,
            smokingHistory == 'Ever' ? 1 : 0,
            smokingHistory == 'Never' ? 1 : 0,
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          predictionResult = data['prediction'] == 1 ? 'Diabetes' : 'No Diabetes';
        });
      } else {
        setState(() {
          predictionResult = 'Error: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes Prediction Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Age Input
              _buildInputField('Age', ageController, 'Masukkan umur anda', TextInputType.number),
              const SizedBox(height: 16),
              
              // Hypertension Row
              _buildSwitchRow('Hypertension', isHypertension, (value) {
                setState(() {
                  isHypertension = value;
                });
              }),
              const SizedBox(height: 16),

              // Heart Disease Row
              _buildSwitchRow('Heart Disease', isHeartDisease, (value) {
                setState(() {
                  isHeartDisease = value;
                });
              }),
              const SizedBox(height: 16),

              // BMI Input
              _buildInputField('BMI', bmiController, 'Masukkan BMI anda', TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: 16),

              // HbA1c Input
              _buildInputField('HbA1c', hba1cController, 'Masukkan nilai HbA1c anda', TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: 16),

              // Glucose Level Input
              _buildInputField('Glucose Level', glucoseController, 'Masukkan kadar glukosa darah anda', TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: 16),

              // Gender Radio Button
              Text(
                'Gender:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                      title: Text('Male'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                      title: Text('Female'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Smoking History Radio Button
              Text(
                'Smoking History:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Never',
                      groupValue: smokingHistory,
                      onChanged: (value) {
                        setState(() {
                          smokingHistory = value!;
                        });
                      },
                      title: Text('Never'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Ever',
                      groupValue: smokingHistory,
                      onChanged: (value) {
                        setState(() {
                          smokingHistory = value!;
                        });
                      },
                      title: Text('Ever'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Predict Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: predictDiabetes,
                    child: Text(
                      'Predict Diabetes',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Display result
              Text(
                predictionResult.isNotEmpty ? 'Prediction: $predictionResult' : '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, String hintText, TextInputType inputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          keyboardType: inputType,
        ),
      ],
    );
  }

  Widget _buildSwitchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
