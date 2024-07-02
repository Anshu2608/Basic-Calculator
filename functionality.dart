import 'package:flutter/material.dart';

class Functionality extends StatefulWidget {
  final VoidCallback onClose;

  const Functionality({Key? key, required this.onClose}) : super(key: key);

  @override
  _FunctionalityState createState() => _FunctionalityState();
}

class _FunctionalityState extends State<Functionality> {
  String _output = "";
  String _currentNumber = "";
  double _num1 = 0;
  String _operand = "";
  bool _hasResult = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "";
        _currentNumber = "";
        _num1 = 0;
        _operand = "";
        _hasResult = false;
      } else if (buttonText == "<-") {
        // Handle backspace functionality
        if (_currentNumber.isNotEmpty) {
          _currentNumber = _currentNumber.substring(0, _currentNumber.length - 1);
          _output = _output.substring(0, _output.length - 1);
        } else if (_output.isNotEmpty) {
          int lastSpaceIndex = _output.lastIndexOf(" ");
          if (lastSpaceIndex != -1) {
            _output = _output.substring(0, lastSpaceIndex).trim();
            _operand = "";
          } else {
            _output = "";
            _operand = "";
          }
        }
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        // Handle operand buttons
        if (_currentNumber.isNotEmpty) {
          if (_hasResult) {
            _output = _num1.toString();
          }
          double num2 = double.parse(_currentNumber);
          _num1 = _performOperation(_num1, num2, _operand);
          _output += " $buttonText ";
          _currentNumber = "";
          _operand = buttonText;
          _hasResult = false;
        } else if (_output.isNotEmpty && _output[_output.length - 1] != " ") {
          _operand = buttonText;
          _output += " $buttonText ";
        }
      } else if (buttonText == ".") {
        // Handle decimal point button
        if (!_currentNumber.contains(".")) {
          _currentNumber += ".";
          _output += ".";
        }
      } else if (buttonText == "=") {
        // Handle equal button
        if (_currentNumber.isNotEmpty && _operand.isNotEmpty) {
          double num2 = double.parse(_currentNumber);
          double result = _performOperation(_num1, num2, _operand);
          _output += "  = $result";
          _num1 = result;
          _currentNumber = "";
          _operand = "";
          _hasResult = true;
        }
      } else {
        // Handle number and other buttons
        _currentNumber += buttonText;
        _output += buttonText;
      }
    });
  }

  double _performOperation(double num1, double num2, String operand) {
    switch (operand) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        if (num2 != 0) {
          return num1 / num2;
        } else {
          return double.infinity;
        }
      default:
        return num2;
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: TextButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(18.0),
          textStyle: const TextStyle(fontSize: 27.0, color: Colors.orange),
        ),
        onPressed: () {
          _buttonPressed(buttonText);
          setState(() {}); // Update UI after button press
        },
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output.isEmpty ? "0" : _output,
                style: const TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton("2nd"),
              _buildButton("deg"),
              _buildButton("sin"),
              _buildButton("cos"),
              _buildButton("tan"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("xy"),
              _buildButton("lg"),
              _buildButton("In"),
              _buildButton("("),
              _buildButton(")"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("√x"),
              _buildButton("C"),
              _buildButton("<-"),
              _buildButton("%"),
              _buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("x!"),
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("1/x"),
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("π"),
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("+"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("^"),
              _buildButton("e"),
              _buildButton("0"),
              _buildButton("."),
              _buildButton("="),
            ],
          ),
        ],
      ),
    );
  }
}
