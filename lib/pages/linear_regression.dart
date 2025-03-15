import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:file_picker/file_picker.dart';

class LinearRegression extends StatefulWidget {
  const LinearRegression({super.key});

  @override
  State<LinearRegression> createState() => _LinearRegressionState();
}

class _LinearRegressionState extends State<LinearRegression> {
  String? _trainingFilePath;
  String? _testFilePath;
  String _targetVariable = '';
  String _output = '';

  Future<void> _pickTrainingFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _trainingFilePath = result.files.single.path;
      });
    }
  }

  Future<void> _pickTestFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _testFilePath = result.files.single.path;
      });
    }
  }

  Future<void> _trainModel() async {
    if (_trainingFilePath == null ||
        _targetVariable.isEmpty ||
        _testFilePath == null) {
      setState(() {
        _output = 'Please select both files and enter a target variable';
      });
      return;
    }
    try {
      final trainingDataset = await fromCsv(_trainingFilePath!);
      final model = LinearRegressor.SGD(trainingDataset, _targetVariable);
      final testDataset = await fromCsv(_testFilePath!);
      final predictions = model.predict(testDataset);
      setState(() {
        _output = predictions.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linear Regression"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickTrainingFile,
              child: Text('Select Training CSV File'),
            ),
            if (_trainingFilePath != null)
              Text('Training file selected: $_trainingFilePath'),
            ElevatedButton(
              onPressed: _pickTestFile,
              child: Text('Select Training CSV File'),
            ),
            if (_testFilePath != null)
              Text('Training file selected: $_testFilePath'),
            TextField(
              onChanged: (value) => _targetVariable = value,
              decoration: InputDecoration(labelText: 'Target Variable'),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _trainModel, child: Text('Train Model')),
            SizedBox(height: 16),
            Text(_output),
          ],
        ),
      ),
    );
  }
}
