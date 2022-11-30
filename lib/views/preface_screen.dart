import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gks_hymn/helpers/database_helper.dart';
import 'package:gks_hymn/models/config.dart';
import 'package:gks_hymn/views/hymns_screen.dart';

class PrefaceScreen extends StatelessWidget {
  const PrefaceScreen({Key? key}) : super(key: key);

  static const route = "/preface";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Config>(
            future: DatabaseHelper.instance.getConfig('preface'),
            builder: (context, AsyncSnapshot<Config> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('loading...'),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Html(data: snapshot.data?.value),
                  ElevatedButton(
                    onPressed: () {
                      print('hymns screen');
                      Navigator.pushReplacementNamed(
                          context, HymnsScreen.route);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
