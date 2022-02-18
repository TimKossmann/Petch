import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Petch - Your personal Pet Match';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('Petch', style: TextStyle(color: Colors.blue, fontSize: 80.0)),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Navigation'),
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
              },
            ),
            ListTile(
              title: const Text('Über Petch'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()),);
              },
            ),
            ListTile(
              title: const Text('Über uns'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()),);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Über Petch')),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: 	
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 36),
            children: <TextSpan>[
              TextSpan(text: 'LOGIN', style: TextStyle(fontSize: 80.0))
        ],
    ),
    textScaleFactor: 0.5,
  ),
        ));
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Über Petch')),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: 	
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 36),
            children: <TextSpan>[
              TextSpan(text: 'Alles über '),
              TextSpan(text: 'Petch ', style: TextStyle(color: Colors.blue)),
              TextSpan(text: 'dot '),
              TextSpan(text: 'com' , style: TextStyle(decoration: TextDecoration.underline)),
              TextSpan(text: 'finden Sie genau hier... '),
              TextSpan(text: 'irgendwann.. ', style: TextStyle(fontSize: 20.0))
        ],
    ),
    textScaleFactor: 0.5,
  ),
        ));
  }
}


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Über Uns')),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: 	
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 36),
            children: <TextSpan>[
              TextSpan(text: 'Dieses Team besteht aus mutigen und '),
              TextSpan(text: 'übernächtigten ', style: TextStyle(decoration: TextDecoration.underline)),
              TextSpan(text: 'Mitgliedern aus '),
              TextSpan(text: 'WI und IW. \n\n'),
              TextSpan(text: 'Um Genau zu sein aus: \n'),
              TextSpan(text: 'Tim, Kai und Timucin \n', style: TextStyle(fontSize: 60.0, color: Colors.blue)),
              TextSpan(text: 'Sie opferten Ihren Schlaf für einpaar Extrapunkte.. ', style: TextStyle(fontSize: 20.0))
        ],
    ),
    textScaleFactor: 0.5,
  ),
        ));
  }
}