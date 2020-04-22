import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home-option.g.dart';

class TabHomeStore = _TabHomeStore with _$TabHomeStore;

abstract class _TabHomeStore with Store {
  @observable
  int selectedTab = 1;

  @action
  changeTab(int newSelectedTab) {
    selectedTab = newSelectedTab;
  }
}

var tabHomeStore = TabHomeStore();

showOptionBasedAtIndex(TapDownDetails details, BuildContext context) {
  var offset = details.globalPosition;
  double left = offset.dx;
  double top = offset.dy;
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    items: _getItemPopMenu(),
    elevation: 8.0,
  );
}

List<PopupMenuEntry<dynamic>> _getItemPopMenu() {
  var details = {
    1: _getItemPopMenuChat(),
    2: _getItemPopMenuStatus(),
    3: _getItemPopMenuCall(),
  };

  return details[tabHomeStore.selectedTab];
}

var configurationMenuItem = PopupMenuItem(

  child: new Builder(builder: (context) {
    return GestureDetector(
      onTap: () {
        _goToConfiguration(context);
      },
      child: Text("Configruation"),
    );
  }),
);


_goToConfiguration(context) {
  Navigator.pushNamed(context, '/configuration');
}

List<PopupMenuEntry<dynamic>> _getItemPopMenuChat() {
  return [
    PopupMenuItem(
      child: Text("Option chat 1"),
    ),
    configurationMenuItem
  ];
}

List<PopupMenuEntry<dynamic>> _getItemPopMenuStatus() {
  return [
    PopupMenuItem(
      child: Text("Option status 1"),
    ),
    configurationMenuItem
  ];
}

List<PopupMenuEntry<dynamic>> _getItemPopMenuCall() {
  return [
    PopupMenuItem(
      child: Text("Option call 1"),
    ),
    configurationMenuItem
  ];
}
