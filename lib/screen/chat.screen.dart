import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
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
            ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: index.isEven
                              ? Border.all()
                              : Border.fromBorderSide(BorderSide(
                                  color: Color.fromRGBO(255, 0, 0, 0.5)))),
                      child: Align(
                        alignment: index.isEven
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text('Message ${index}'),
                      ),
                    ));
              },
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 500,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Form(
                    child: TextFormField(),
                  ),
                ))
          ],
        ));
  }
}
