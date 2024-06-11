import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final counterProvider = StateProvider<int>((ref) => 0);

void main() {

  final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => EditScreen(),
    ),
  ],
);

  runApp(ProviderScope(
      child: MaterialApp.router(
    routerConfig: router,
  )));
}

class HomeScreen extends ConsumerWidget {
  _navigateToCounter(BuildContext context) {
    context.go('/edit');
  }

  HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCount = ref.watch(counterProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(currentCount.toString()),
            ElevatedButton(
                onPressed: () => _navigateToCounter(context), child: Text("Edit"))
          ],
        ),
      ),
    );
  }
}

class EditScreen extends ConsumerWidget {
  _navigateToHome(BuildContext context) {
    context.go('/');
  }

  _addToCounter(BuildContext context, WidgetRef ref) {
    ref.watch(counterProvider.notifier).update((value) => value + 1);
  }

  EditScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCount = ref.watch(counterProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => _addToCounter(context, ref), child: Text("Add")),
            ElevatedButton(
                onPressed: () => _navigateToHome(context), child: Text("Back"))
          ],
        ),
      ),
    );
  }
}
