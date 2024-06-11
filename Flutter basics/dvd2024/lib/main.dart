import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 64, 183, 58)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Vittu tää toimii'),
    );
  }
}

class HelloWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Hello!');
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: const Text("Main"),
      ),
    );
  }
}

class ColorfulTextWidget extends StatelessWidget {
  Color color;
  String text;

  ColorfulTextWidget({this.color = Colors.red, this.text = "Hello!"});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text(text),
    );
  }
}

//create row with 3 colorful text widgets
class RowsInColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("A"),
            Text("B"),
            Text("C"),
          ],
        ),
        Row(
          children: [
            Text("D"),
            Text("E"),
          ],
        ),
        Row(
          children: [
            Text("F"),
          ],
        ),
      ],
    );
  }
}

class ColumnExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(color: Colors.blue)),
        Expanded(child: Container(color: Colors.yellow)),
      ],
    );
  }
}

class ThreeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            print("Button pressed");
          },
          child: Text("Hello"),
        ),
        OutlinedButton(
          onPressed: () {
            print("Button pressed");
          },
          child: Text("world"),
        ),
        TextButton(
          onPressed: () {
            print("Button pressed");
          },
          child: Text("!"),
        ),
      ],
    );
  }
}

//create a button using elevated button class

class ElButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("Button pressed");
      },
      child: Text("Hello"),
    );
  }
}

class OutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        print("Button pressed");
      },
      child: Text("world"),
    );
  }
}

class TButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print("Button pressed");
      },
      child: Text("!"),
    );
  }
}

class NavButtonsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () => context.go("/y/1"),
          child: Text("Up"),
        ),
        OutlinedButton(
            onPressed: () => context.go("/y/-1"), child: Text("Down")),
        OutlinedButton(
          onPressed: () => context.go("/x/1"),
          child: Text("Right"),
        ),
        OutlinedButton(
            onPressed: () => context.go("/x/-1"), child: Text("Left")),
      ],
    );
  }
}

class NavButtonsRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Read"),
        OutlinedButton(
            onPressed: () => Navigator.pop(context, "/"), child: Text("Back")),
      ],
    );
  }
}

class NavButtonsWrite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Write"),
        OutlinedButton(
            onPressed: () => Navigator.pop(context, "/"), child: Text("Back")),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: NavButtonsHome()));
  }
}

class ReadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: NavButtonsRead()));
  }
}

class WriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: NavButtonsWrite()));
  }
}

class CoordinateScreen extends StatelessWidget {
  int x = 0;
  int y = 0;

  CoordinateScreen(this.x, this.y);

  @override
  Widget build(BuildContext context) {
    final addY = y + 1;
    final subY = y - 1;
    final addX = x + 1;
    final subX = x - 1;

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text("You are at ($x,$y)"),
          ElevatedButton(
            onPressed: () => context.go("/x/$x/y/$addY"),
            child: Text("Up"),
          ),
          ElevatedButton(
              onPressed: () => context.go("/x/$x/y/$subY"), child: Text("Down")),
          ElevatedButton(
            onPressed: () => context.go("/x/$addX/y/$y"),
            child: Text("Right"),
          ),
          ElevatedButton(
              onPressed: () => context.go("/x/$subX/y/$y"),
              child: Text("Left")),
        ],
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
