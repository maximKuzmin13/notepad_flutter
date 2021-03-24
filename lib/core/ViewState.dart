import 'package:flutter/cupertino.dart';

abstract class ViewState {}

class Idle extends ViewState {}

class Loading extends ViewState {}

class Error extends ViewState {
  String text;

  Error({@required this.text});
}

class Success extends ViewState {
  List fakeNotes;

  Success({@required this.fakeNotes});
}
