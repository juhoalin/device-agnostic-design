import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dataProvider = StateProvider<List<String>>((ref) => []);

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ListWidget(),
              AddButton('Yes'),
              AddButton('No'),
            ],
          ),
    )))));
}


class AddButton extends ConsumerWidget {
  final text;
  AddButton(this.text);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref.watch(dataProvider.notifier).update((state) => [...state, text]),
      child: Text('$text'),
    );
  }
}


class ListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> data = ref.watch(dataProvider);
    return Column(
      children: 
        data.map((e) => Text(e)).toList(),
    );
  }
}