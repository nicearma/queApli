import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

part 'chat.screen.g.dart';

class Message {
  final String userId;
  final DateTime date;
  final String message;

  Message({this.userId, this.date, this.message});
}

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  @observable
  ObservableList<String> userIds = ObservableList.of([]);
  @observable
  ObservableList<Message> messages = ObservableList.of([]);

  @action
  addMessage(String message) {
    messages
        .add(new Message(message: 'TODO', userId: '1', date: DateTime.now()));
    developer.log('log me ${messages.length}', name: 'my.app.category');
  }
}

class ChatScreen extends StatelessWidget {
  final _chat = ChatStore();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text('Title'), Text('Users or status')],
          ),
        ),
        body: Stack(
          children: <Widget>[

            Observer(
                builder: (_) => ListView.builder(
                      itemCount: _chat.messages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: index.isEven
                                      ? Border.all()
                                      : Border.fromBorderSide(BorderSide(
                                          color:
                                              Color.fromRGBO(255, 0, 0, 0.5)))),
                              child: Align(
                                alignment: index.isEven
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Text(_chat.messages[index].message),
                              ),
                            ));
                      },
                    )),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(),
                        RaisedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _chat.addMessage('nicearma');
                          },
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
