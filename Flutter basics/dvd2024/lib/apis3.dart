import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';


main() {
  runApp(MaterialApp(home: Scaffold(body: JokeDisplayer())));
}

class JokeDisplayer extends StatefulWidget {
  @override
  State<JokeDisplayer> createState() => _JokeDisplayerState();
}

class _JokeDisplayerState extends State<JokeDisplayer> {
  Future<Joke>? _joke;
  String _punchline = '';

  getJoke() {
    _punchline = '';
    setState(() {
      _joke = JokeService().getRandomJoke();
    });
  }

  showPunchline(String line) {
    setState(() {
      _punchline = '$line';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(onPressed: getJoke, child: Text('Fetch joke!')),
      FutureBuilder<Joke>(
        future: _joke,
        builder: (BuildContext context, AsyncSnapshot<Joke> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Waiting for a joke.");
          } else if (snapshot.hasError) {
            return Text("Error in retrieving joke: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return Text("No jokes yet.");
          } else {
            Joke joke = snapshot.data!;
            return Column(children: [
              Text(joke.setup),
              Text(_punchline),
              ElevatedButton(onPressed: () => showPunchline(joke.punchline), child: Text('Tell me')),
            ]);
          }
        },
      )
    ]);
  }
}

class JokeService {
  final _endpoint = Uri.parse('https://simple-joke-api.deno.dev/random');

  Future<Joke> getRandomJoke() async {
    var response = await http.get(_endpoint);
    var data = jsonDecode(response.body);

    return Joke(data['setup'], data['punchline']);
  }
}

class Joke {
  String setup;
  String punchline;
  Joke(this.setup, this.punchline);
}


