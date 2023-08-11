import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String expression = '';
  String result = '0';

  void buttonpressed(String btntext) {
    setState(() {
      if (btntext == "AC") {
        equation = "0";
        result = "0";
      } else if (btntext == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (btntext == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = btntext;
        } else {
          equation = equation + btntext;
        }
      }
    });
  }

  Widget calButtons(
      String btntext, Color textcolor, Color btncolor, double btnwidth) {
    return InkWell(
      onTap: () => buttonpressed(btntext),
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnwidth,
        decoration: BoxDecoration(
          color: btncolor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btntext,
          style: TextStyle(
              color: textcolor, fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF19F3D),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          title: const Text(
            "Calculator",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                width: double.infinity,
                height: 90,
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Text(
                    equation,
                    style: TextStyle(color: Color(0xFFF19F3D), fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                width: double.infinity,
                height: 90,
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calButtons("AC", Colors.white, const Color(0xFF3D70F1), 80),
                  calButtons("⌫", Colors.white, const Color(0xFFF19F3D), 80),
                  calButtons("%", Colors.white, const Color(0xFFF19F3D), 80),
                  calButtons("÷", Colors.white, const Color(0xFF3D70F1), 80),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calButtons("7", Colors.white, Colors.white10, 80),
                  calButtons("8", Colors.white, Colors.white10, 80),
                  calButtons("9", Colors.white, Colors.white10, 80),
                  calButtons("×", Colors.white, const Color(0xFF3D70F1), 80),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calButtons("4", Colors.white, Colors.white10, 80),
                  calButtons("5", Colors.white, Colors.white10, 80),
                  calButtons("6", Colors.white, Colors.white10, 80),
                  calButtons("-", Colors.white, const Color(0xFF3D70F1), 80),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calButtons("1", Colors.white, Colors.white10, 80),
                  calButtons("2", Colors.white, Colors.white10, 80),
                  calButtons("3", Colors.white, Colors.white10, 80),
                  calButtons("+", Colors.white, const Color(0xFF3D70F1), 80),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calButtons("0", Colors.white, Colors.white10, 170),
                  calButtons(".", Colors.white, Colors.white10, 80),
                  calButtons("=", Colors.white, const Color(0xFF3D70F1), 80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
