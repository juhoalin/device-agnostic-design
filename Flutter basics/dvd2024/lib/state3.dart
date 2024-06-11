import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: Scaffold(body: Center(child: QuestionsWidget())))));
}

final counterProvider = StateProvider((ref) => 0);

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Column(
      children: [
        Text('Current count: $counter'),
        ElevatedButton(
          onPressed: () => ref.watch(counterProvider.notifier).update((value) => value + 1),
          child: Text('++'),
        ),
        ElevatedButton(
          onPressed: () => ref.watch(counterProvider.notifier).update((value) => value - 1),
          child: Text('--'),
        ),
        ElevatedButton(
          onPressed: () => ref.watch(counterProvider.notifier).update((value) => 0),
          child: Text('Reset')
        ),
      ],
    );
  }
}

final qAnswersProvider = StateProvider((ref) => 0);
final qCorrectProvider = StateProvider((ref) => 0);
final qWrongProvider = StateProvider((ref) => 0);



class QuestionsWidget extends ConsumerWidget {

  final questions = [
    'Is 2+2 4?',
    'Is 1+2 3?',
    'Is 1-1 0?',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qAnswers =  ref.watch(qAnswersProvider) < questions.length ? ref.watch(qAnswersProvider) : 0;
    final qCorrect = ref.watch(qCorrectProvider) < questions.length ? ref.watch(qCorrectProvider) : 0;
    final qWrong = ref.watch(qWrongProvider);

    final currentQuestion = qAnswers < questions.length ? questions[qAnswers] : 'All done';


    return Column(
      children: [
        Text('Questions asked: $qAnswers'),
        Text('Correct answers: $qCorrect'),
        Text("$currentQuestion"),
        ElevatedButton(
          onPressed: () {
            ref.watch(qAnswersProvider.notifier).update((value) => value + 1);
            ref.watch(qCorrectProvider.notifier).update((value) => value + 1);
          },
          child: Text('Yes'),
        ), 
        ElevatedButton(
          onPressed: () {
            ref.watch(qAnswersProvider.notifier).update((value) => value + 1);
            ref.watch(qWrongProvider.notifier).update((value) => value + 1);
          },
          child: Text('No'),
        ),
      ],
    );
  }
}

