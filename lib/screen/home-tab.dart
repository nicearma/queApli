import 'package:flutter/material.dart';

class TabModel {
  TabModel({this.title, this.icon, this.body});

  final String title;
  final IconData icon;
  final Widget body;
}

List<TabModel> tabs = <TabModel>[
  TabModel(
      title: 'Photos',
      icon: Icons.camera,
      body: new Builder(builder: (context) {
        return GestureDetector(
            onTap: () {
              _goToPhoto(context);
            },
            child: Text('Hello'));
      })),
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

_goToPhoto(context) {
  Navigator.pushNamed(context, '/camera');
}
