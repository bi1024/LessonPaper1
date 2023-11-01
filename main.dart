import 'dart:math';

import 'package:flutter/material.dart';

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
        // the application has a blue toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
  var list = [
    'Bun bo',
    'Bun cha',
    'Xoi',
  ];
  TextEditingController _textFieldController = TextEditingController();

  int counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
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
    final screenHeight = MediaQuery.of(context).size.height;
    final percentageHeight = 0.5; // Set your desired percentage (e.g., 50%)
    final desiredHeight = screenHeight * percentageHeight;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Choose a dish: "),
          ),
          Center(
            child: Text(list[counter]),
          ),
          Center(
              child: MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.more_horiz),
                      tooltip: 'Show menu',
                    );
                  },
                  menuChildren: [
                Text("data"),
                Text(
                  "data",
                )
              ])),
          // Center(
          //   child: Text(String.fromCharCode(counter)),
          // ),
          ElevatedButton(
              onPressed: () {
                counter = Random().nextInt(list.length);
                print(counter);
                setState(() {});
              },
              child: Text("Randomize"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                  height: desiredHeight * 0.3,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Restaurant List"),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context,
                                      StateSetter
                                          setState /*You can rename this!*/) {
                                return SizedBox(
                                  height: desiredHeight,
                                  child: Center(
                                    child: Column(
                                      // mainAxisAlignement : MainAxisAlignment.start,
                                      // crossAxisAlignement : CrossAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: ElevatedButton(
                                            child: const Text('Close'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: desiredHeight * 0.8,
                                          child: ListView.builder(
                                            itemCount: list.length,
                                            itemBuilder: (context, index) {
                                              final listItem =
                                                  list[index]; //for removing
                                              return ListTile(
                                                title: Text(list[index]),
                                                trailing: GestureDetector(
                                                  onTap: () {
                                                    // Handle the tap on the icon here

                                                    print(
                                                        'Tapped on the icon for ${list[index]}');
                                                    list.remove(listItem);
                                                    // setState.
                                                    setState(() {});
                                                  },
                                                  child: Icon(Icons
                                                      .arrow_forward), // Add the trailing icon here
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        },
                      ),
                      ListTile(
                        title: Text("Add a Restaurant"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('TextField in Dialog'),
                                content: TextField(
                                  controller: _textFieldController,
                                  decoration: InputDecoration(
                                      hintText: "Text Field in Dialog"),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        list.add(_textFieldController.text);
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK")),
                                ],
                                // actions:
                                // <Widget>[
                                //   FlatButton(
                                //     child: Text('CANCEL'),
                                //     onPressed: () {
                                //       Navigator.pop(context);
                                //     },
                                //   ),
                                //   FlatButton(
                                //     child: Text('OK'),
                                //     onPressed: () {
                                //       print(_textFieldController.text);
                                //       Navigator.pop(context);
                                //     },
                                //   ),
                                // ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}
