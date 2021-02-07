import 'package:deleteable_tile/deleteable_tile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<int> _children = [];

  void _incrementCounter() {
    setState(() {
      _children.add(_counter++);
    });
  }

  Widget _buildChild(BuildContext context, int index) {
    final value = _children[index];
    // show a variety of axisAlignments
    final axisAlignment = (value % 5) / 2 - 1;
    // show a variety of durations
    final duration = Duration(milliseconds: 500 - (value % 6) * 100);
    if (value % 2 == 0) {
      return DeleteableTile(
        key: ValueKey(value),
        onDeleted: () => _children.remove(value),
        axisAlignment: axisAlignment,
        duration: duration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Delete me! $value"),
        ),
      );
    } else {
      return Deleteable(
        duration: duration,
        builder: (context, delete) => Card(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () async {
                      await delete();
                      _children.remove(value);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.delete),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                child: Center(
                  child: Text("Delete me as well! $value"),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: _buildChild,
        itemCount: _children.length,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //for (var x = 0; x < 20; x++) {
          _incrementCounter();
          //}
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
