import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  final sum = await SumService().sum(1, 2);
  print(sum);
}

class SumService {

  final endPoint = Uri.parse('https://fitech-api.deno.dev/sum-api');

  Future<int> sum(int first, int second) async {
    final body = json.encode({'one': first, 'two': second});
    final response = await http.post(endPoint, body: body);
    final data = json.decode(response.body);
    return int.parse(data['sum']);
  }
}

