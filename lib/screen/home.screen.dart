import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queappli/screen/home-option.dart';
import 'package:queappli/screen/home-tab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
                title: Text('QueApli'),
                actions: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      Icon(Icons.search),
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          showOptionBasedAtIndex(details, context);
                        },
                        child: Icon(Icons.more_vert),
                      )

                    ],
                  )
                ],
                bottom: TabBar(
                  isScrollable: true,
                  onTap: (index) {
                    tabHomeStore.changeTab(index);
                  },
                  tabs: tabs.map((TabModel tab) {
                    return Tab(
                      text: tab.title,
                      icon: Icon(tab.icon),
                    );
                  }).toList(),
                )),
            body: TabBarView(
              children: tabs.map((TabModel tab) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: tab.body,
                );
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _goToContacts(context),
              tooltip: 'Increment Counter',
              child: const Icon(Icons.message),
            )
        ));
  }
}



_goToContacts(context) {
  Navigator.pushNamed(context, '/contacts');
}

