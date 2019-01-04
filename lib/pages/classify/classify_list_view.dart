import 'package:flutter/material.dart';

class ClassifyListView extends StatefulWidget {

  final String title;

  ClassifyListView(this.title);

  @override
  _ClassifyListViewState createState() => _ClassifyListViewState();
}

class _ClassifyListViewState extends State<ClassifyListView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}