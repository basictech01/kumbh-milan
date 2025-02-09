import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';

class DetailPage extends StatelessWidget {
  final ProfileModel profileModel;

  const DetailPage({Key? key, required this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Text('This is the detail page'),
      ),
    );
  }
}