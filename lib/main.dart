import 'package:flutter/material.dart';
import 'package:info_vaksin_sleman/pages/faskes_list_page.dart';
import 'package:info_vaksin_sleman/repository/info_vaksin_sleman_api_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Vaksin Sleman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FaskesListPage(
        faskesRepository: InfoVaksinSlemanApiClient(),
      ),
    );
  }
}
