import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final stringProvider = StateProvider<String>((ref) => '');

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/text',
      builder: (context, state) => TextInputScreen(),
    ),
  ],
);

main() {
  runApp(ProviderScope(child: MaterialApp.router(routerConfig: routes)));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElevatedButton(
            onPressed: () => context.go('/text'),
            child: const Text("To input screen")));
  }
}

class TextInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      MyTextField(),
      ElevatedButton(
        onPressed: () => context.go('/'),
        child: const Text("To home screen"),
      )
    ]));
  }
}

class MyTextField extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends ConsumerState<MyTextField> {
  final _controller = TextEditingController();

    _update() {
    ref
        .read(stringProvider.notifier)
        .update((state) => _controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(stringProvider);
    _controller.addListener(_update);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: _controller);
  }
}
