
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<List<String>>((ref) => ItemService().getItems());

main() {
  runApp(ProviderScope(child: FormApp()));
}

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
      TextFieldForm(),
      EnteredData(),
    ])));
  }
}

class TextFieldForm extends ConsumerWidget {

  _filterItems(String value, WidgetRef ref) {
    final items = ItemService().getItems();
    ref.watch(nameProvider.notifier).update((state) => items.where((element) => element.contains(value)).toList());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (String value) =>
          _filterItems(value, ref),
      decoration: const InputDecoration(
        hintText: 'Name',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class EnteredData extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: ref.watch(nameProvider).map((e) => Text(e)).toList(),
    );
  }
}

class ItemService {
  List<String> getItems() {
    return [
      'Mini hand squirrel',
      'Cheeseburger telephone',
      'Bacon-scented soap',
      'Thumb piano'
    ];
  }
}