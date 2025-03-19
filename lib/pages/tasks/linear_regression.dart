import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

class LinearRegression extends StatefulWidget {
  const LinearRegression({super.key});

  @override
  State<LinearRegression> createState() => _LinearRegressionState();
}

class _LinearRegressionState extends State<LinearRegression> {
  String _trainDataset = "";
  String _testDataset = "";
  String _targetVariable = "";
  String _output = "";
  bool isLoading = false;

  Future<void> _pickTrainDataset() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (result != null) {
        setState(() {
          _trainDataset = result.files.single.path!;
        });
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickTestDataset() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (result != null) {
        setState(() {
          _testDataset = result.files.single.path!;
        });
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _trainModel() async {
    setState(() {
      isLoading = true;
      _output = "";
    });
    try {
      final trainDataframe = await fromCsv(_trainDataset, columnDelimiter: ",", headerExists: false);
      final shuffledDataframe = trainDataframe.shuffle();
      final splits = splitData(shuffledDataframe, [0.8]);
      final trainData = splits[0];
      final testData = splits[1];
      final model = LinearRegressor(trainData, _targetVariable);
      final error = model.assess(testData, MetricType.mape);
      final testDataframe = await fromCsv(_testDataset, columnDelimiter: ",", headerExists: false);
      final prediction = model.predict(testDataframe);
      setState(() {
        _output = "Model Training Loss: $error. Model Prediction: $prediction";
      });
    } catch (error) {
      setState(() {
        _output = error.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Linear Regression"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        children: [
          FilledButton(
            onPressed: isLoading ? () {} : _pickTrainDataset,
            child:
                isLoading
                    ? CircularProgressIndicator.adaptive()
                    : Text("Pick Train Dataset"),
          ),
          Text(_trainDataset),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Target Variable",
            ),
            onChanged: (value) {
              setState(() {
                _targetVariable = value;
              });
            },
            readOnly: isLoading,
          ),
          SizedBox(height: 5),
          FilledButton(
            onPressed: isLoading ? () {} : _trainModel,
            child: Text("Train Model"),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: isLoading ? () {} : _pickTestDataset,
            child:
            isLoading
                ? CircularProgressIndicator.adaptive()
                : Text("Pick Test Dataset"),
          ),
          Text(_testDataset),
          SizedBox(height: 10),
          Text(_output),
        ],
      ),
    );
  }
}
