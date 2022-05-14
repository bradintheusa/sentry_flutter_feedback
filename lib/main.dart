import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// this will need to be async.
void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://813c028c4b4741bcbd0830c06182d7b0@o169585.ingest.sentry.io/3260779';
    },
    // Init your App.
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter/Sentry Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    Sentry.addBreadcrumb(Breadcrumb(message: "_incrementCounter"));
    setState(() {
      _counter++;
      Sentry.captureMessage("Increment Stored:" + _counter.toString());
      
    });
  }

  @override
  void initState() {
    super.initState();
    final additionalData = {
      'developer': 'Brad',
      'channel': 'Alpha',
      'server': 'dev',
    };
    Sentry.configureScope((scope) => scope.setContexts('environment', additionalData));    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
