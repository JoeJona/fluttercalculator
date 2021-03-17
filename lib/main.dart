import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPress(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 30.0,
              color: Colors.white),
        ),
      ),
    );
  }

  String equ = "0";
  String result = "0";
  String expr = "";
  double efs = 38.0;
  double rfs = 48.0;

  buttonPress(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equ = "0";
        result = "0";
        efs = 38.0;
        rfs = 48.0;
      } else if (buttonText == "<") {
        efs = 48.0;
        rfs = 38.0;
        equ = equ.substring(0, equ.length - 1);
        if (equ == "") {
          equ = "0";
        }
      } else if (buttonText == "=") {
        efs = 38.0;
        rfs = 48.0;
        expr = equ;
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expr);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "ERROR";
        }
      } else {
        rfs = 38.0;
        efs = 48.0;
        if (equ == "0") {
          equ = buttonText;
        } else {
          equ = equ + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equ, style: TextStyle(fontSize: efs)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: rfs)),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('<', 1, Colors.blue),
                        buildButton('/', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('9', 1, Colors.grey),
                        buildButton('8', 1, Colors.grey),
                        buildButton('7', 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('6', 1, Colors.grey),
                        buildButton('5', 1, Colors.grey),
                        buildButton('4', 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('3', 1, Colors.grey),
                        buildButton('2', 1, Colors.grey),
                        buildButton('1', 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.grey),
                        buildButton('0', 1, Colors.grey),
                        buildButton('00', 1, Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('*', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
