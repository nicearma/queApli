// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home-option.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabHomeStore on _TabHomeStore, Store {
  final _$selectedTabAtom = Atom(name: '_TabHomeStore.selectedTab');

  @override
  int get selectedTab {
    _$selectedTabAtom.context.enforceReadPolicy(_$selectedTabAtom);
    _$selectedTabAtom.reportObserved();
    return super.selectedTab;
  }

  @override
  set selectedTab(int value) {
    _$selectedTabAtom.context.conditionallyRunInAction(() {
      super.selectedTab = value;
      _$selectedTabAtom.reportChanged();
    }, _$selectedTabAtom, name: '${_$selectedTabAtom.name}_set');
  }

  final _$_TabHomeStoreActionController =
      ActionController(name: '_TabHomeStore');

  @override
  dynamic changeTab(int newSelectedTab) {
    final _$actionInfo = _$_TabHomeStoreActionController.startAction();
    try {
      return super.changeTab(newSelectedTab);
    } finally {
      _$_TabHomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'selectedTab: ${selectedTab.toString()}';
    return '{$string}';
  }
}
