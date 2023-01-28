//importing

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String eq = "0";
  String re = "0";
  String ex = "0";
  double eqFontSize = 38.0;
  double reFontSize = 48.0;

  buttonPressed(String buttonText){

    setState(() {
      if(buttonText == "C"){

        eq = "0";
        re = "0";
        eqFontSize = 38.0;
        reFontSize = 48.0;

      }

      else if(buttonText == "⌫"){

        eq = eq.substring(0, eq.length -  1);
        if(eq == ""){
          eq = "0";
        }
        eqFontSize = 48.0;
        reFontSize = 38.0;

      }

      else if(buttonText == "="){

        eqFontSize = 38.0;
        reFontSize = 48.0;

        ex = eq;
        ex = ex.replaceAll('X', '*');
        try{
          Parser p = Parser();
          Expression exp = p.parse(ex);
          ContextModel cm = ContextModel();
          re = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          re = "Error";
        }

      }

      else{

        eqFontSize = 48.0;
        reFontSize = 38.0;
        if(eq == "0"){
          eq = buttonText;
        }
        else{
          eq = eq + buttonText;
        }
      }
    });

  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        'Simple Calculator',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35.0
        ) ,
      )
      ),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(eq, style: TextStyle(fontSize: eqFontSize)),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(re, style: TextStyle(fontSize: reFontSize)),
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
                       buildButton("C", 1, Colors.redAccent),
                       buildButton("⌫", 1, Colors.blue),
                       buildButton("/", 1, Colors.blue),
                     ]
                   ),

                   TableRow(
                       children: [
                         buildButton("7", 1, Colors.black54),
                         buildButton("8", 1, Colors.black54),
                         buildButton("9", 1, Colors.black54),
                       ]
                   ),

                   TableRow(
                       children: [
                         buildButton("4", 1, Colors.black54),
                         buildButton("5", 1, Colors.black54),
                         buildButton("6", 1, Colors.black54),
                       ]
                   ),

                   TableRow(
                       children: [
                         buildButton("1", 1, Colors.black54),
                         buildButton("2", 1, Colors.black54),
                         buildButton("3", 1, Colors.black54),
                       ]
                   ),

                   TableRow(
                       children: [
                         buildButton(".", 1, Colors.black54),
                         buildButton("0", 1, Colors.black54),
                         buildButton("00", 1, Colors.black54),
                       ]
                   )
                 ],
               ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("X", 1, Colors.blue),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.redAccent),
                        ]
                    )
                  ],
                )
              )
            ],
          )
        ],
      )
    );
  }
}

