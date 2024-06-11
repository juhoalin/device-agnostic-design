import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

main() {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SumScreen()),
      GoRoute(
          path: '/:first',
          builder: (context, state) =>
              SumScreen.first(int.parse(state.pathParameters['first']!))),
      GoRoute(
          path: '/:first/:second/:sum',
          builder: (context, state) =>
              SumScreen.second(int.parse(state.pathParameters['first']!), int.parse(state.pathParameters['second']!), int.parse(state.pathParameters['sum']!))),
    ],
  );

  runApp(MaterialApp.router(routerConfig: router));
}

class SumScreen extends StatelessWidget {
  final int? firstNum;
  final int? secondNum;
  final int? sum;

  SumScreen()
      : firstNum = null,
        secondNum = null,
        sum = null;
  SumScreen.first(this.firstNum)
      : secondNum = null,
        sum = null;
  SumScreen.second(this.firstNum, this.secondNum, this.sum);

  _proceedFirst(BuildContext context, int firstNum) {
    print(firstNum);
    context.go('/$firstNum');
  }

  _proceedSecond(BuildContext context, int first, int second) async {
    print('$first, $second');
    var sum = await SumApi().sum(first, second);
    context.go('/$first/$second/$sum');
  }

  @override
  Widget build(BuildContext context) {
    bool readyToCount = firstNum != null;
    bool readyToDisplay = sum != null;
    String display = readyToDisplay ? '$firstNum + $secondNum = $sum' : '';
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('$display'),
            ElevatedButton(
              onPressed: () => readyToCount
                  ? _proceedSecond(context, firstNum!, 1) 
                  : _proceedFirst(context, 1),
              child: Text('1'),
            ),
            ElevatedButton(
              onPressed: () => readyToCount
                  ? _proceedSecond(context, firstNum!, 2) 
                  : _proceedFirst(context, 2),
              child: Text('2'),
            ),
            ElevatedButton(
              onPressed: () => readyToCount
                  ? _proceedSecond(context, firstNum!, 3) 
                  : _proceedFirst(context, 3),
              child: Text('3'),
            ),
            ElevatedButton(
              onPressed: () => readyToCount
                  ? _proceedSecond(context, firstNum!, 4) 
                  : _proceedFirst(context, 4),
              child: Text('4'),
            ),
            ElevatedButton(
              onPressed: () => readyToCount
                  ? _proceedSecond(context, firstNum!, 5) 
                  : _proceedFirst(context, 5),
              child: Text('5'),
            ),
      ]),
      ),
    );
  }
}

class SumApi {
  Future<int> sum(int first, int second) async {
    var response = await http.post(
      Uri.parse('https://fitech-api.deno.dev/sum-api'),
      body: jsonEncode({'one': first, 'two': second}),
    );

    var data = jsonDecode(response.body);
    return data['sum'];
  }
}
