import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

final currencyProvider = StateProvider<String>((ref) => 'Press to retreive');

void main() {
  runApp(ProviderScope(child: MaterialApp( home: CurrencyWidget())));
}

class CurrencyWidget extends ConsumerWidget {

  _updateCurrencyUSD(WidgetRef ref) async {
     String conversion = await CurrencyServiceUSD().getRate();
    ref.watch(currencyProvider.notifier).update((state) => conversion);
  }

  _updateCurrencySEK(WidgetRef ref) async {
     String conversion = await CurrencyServiceSEK().getRate();
    ref.watch(currencyProvider.notifier).update((state) => conversion);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(children: [
      Text(ref.watch(currencyProvider)),
      ElevatedButton(
        onPressed: () => _updateCurrencyUSD(ref),
        child: const Text("Convert to USD"),
      ),
      ElevatedButton(
        onPressed: () => _updateCurrencySEK(ref),
        child: const Text("Convert to SEK"),
      ),
    ]));
  }
}

class CurrencyServiceUSD {

  final _endPoint = Uri.parse('https://api.frankfurter.app/latest?from=EUR&to=USD');

  Future<String> getRate() async {
    final response = await http.get(_endPoint);
    final data = jsonDecode(response.body);
     final conversion = data['rates']['USD'] * 100;
    return conversion.toString();
  }
}

class CurrencyServiceSEK {

  final _endPoint = Uri.parse('https://api.frankfurter.app/latest?from=EUR&to=SEK');

  Future<String> getRate() async {
    final response = await http.get(_endPoint);
    final data = jsonDecode(response.body);
     final conversion = data['rates']['SEK'] * 100;
    return conversion.toString();
  }
}



