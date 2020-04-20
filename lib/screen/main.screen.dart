import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabModel {
  TabModel({this.title, this.icon, this.body});

  final String title;
  final IconData icon;
  final Widget body;
}

List<TabModel> tabs = <TabModel>[
  TabModel(title: 'Photos', icon: Icons.camera, body: Text('TODO: Camera')),
  TabModel(
      title: 'Chats',
      icon: Icons.chat,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _goToChat(context);
            },
            child: Card(
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text('Title ${index}'),
                subtitle: Text('Last message'),
              ),
            ),
          );
        },
      )),
  TabModel(title: 'Status', icon: Icons.search, body: Text('TODO: Status')),
  TabModel(title: 'Calls', icon: Icons.access_alarms, body: Text('TODO: Calls'))
];

_goToChat(context) {
  Navigator.pushNamed(context, '/chat');
}

class MainScreen extends StatelessWidget {
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
                      Icon(Icons.more_vert)
                    ],
                  )
                ],
                bottom: TabBar(
                  isScrollable: true,
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
            )));
  }
}
