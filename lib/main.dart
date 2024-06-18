import 'package:calculator/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CurrencyConverter());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var problem = "";
  var solution = "";
  String ans = "";

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      "C",
      "DEL",
      "%",
      "/",
      "9",
      "8",
      "7",
      "x",
      "6",
      "5",
      "4",
      "-",
      "3",
      "2",
      "1",
      "+",
      "0",
      ".",
      "ANS",
      "=",
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("C A L C U L A T O R"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CurrencyConverter(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.currency_exchange)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        problem,
                        style:
                            const TextStyle(fontSize: 35, color: Colors.grey),
                      ),
                      Text(solution,
                          style: const TextStyle(
                              fontSize: 50,
                              color: Color.fromARGB(182, 0, 0, 0)))
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  color: Colors.grey.shade200,
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 1.37),
                    itemBuilder: (context, index) {
                      return myButton(buttons[index], index, () {
                        setState(() {
                          if (index == 0) {
                            problem = "";
                            solution = "";
                          } else if (index == 1) {
                            problem = problem.substring(0, problem.length - 1);
                          } else if (index == buttons.length - 1) {
                            calculate();
                          } else {
                            problem += buttons[index];
                          }
                        });
                      });
                    },
                  ),
                ),
              ))
            ],
          )),
    );
  }

  void calculate() {
    String question = problem.replaceAll("x", "*");
    question = question.replaceAll("ANS", ans);

    Parser p = Parser();
    Expression exp = p.parse(question);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    solution = eval.toString();
    ans = solution;
    problem = question;
  }
}

Widget myButton(String buttonName, int index, VoidCallback onpressed) {
  return GestureDetector(
    onTap: onpressed,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          color:
              check(index) ? const Color.fromARGB(182, 0, 0, 0) : Colors.grey,
          child: Center(
            child: Text(
              buttonName,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}

bool check(int index) {
  if (index == 0 ||
      index == 1 ||
      index == 2 ||
      index == 3 ||
      index == 7 ||
      index == 11 ||
      index == 15 ||
      index == 19) {
    return true;
  } else {
    return false;
  }
}
