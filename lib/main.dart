import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//**CODE FOR THEME CHANGER** */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.darkThemeEnabled,
        initialData: false,
        builder: (context, snapshot) => MaterialApp(
              theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
              home: Scaffold(
                appBar: AppBar(
                  title: Text("Dynamic switching"),
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return {'logout', 'setting'}.map((String choice) {
                          return PopupMenuItem(
                              value: choice, child: Text(choice));
                        }).toList();
                      },
                      onSelected: handleClick,
                    )
                  ],
                ),
                body: Center(
                  child: Text("Hello folks"),
                ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 150,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://cdn.thewirecutter.com/wp-content/uploads/2020/04/laptops-lowres-2x1--1024x512.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text("Neha Soni"),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text("Enable dark theme"),
                        trailing: Switch(
                          value: snapshot.data,
                          onChanged: bloc.changeTheme,
                        ),
                      ),
                      ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Enable light theme"),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
void handleClick(String value) {
  switch (value) {
    case 'logout':
      print("logging");
      break;
    case 'setting':
      print("Breaking");
      break;
  }
}
