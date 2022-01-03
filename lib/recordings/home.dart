import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'list.dart';
import 'view.dart';

class Recodinghome extends StatefulWidget {
  Recodinghome({Key? key}) : super(key: key);

  @override
  _RecodinghomeState createState() => _RecodinghomeState();
}

class _RecodinghomeState extends State<Recodinghome> {
  late Directory? appDir;
  late List<String>? records;

  @override
  void initState() {
    super.initState();
    records = [];
    getExternalStorageDirectory().then((value) {
      appDir = value!;
      Directory appDirec = Directory("${appDir!.path}/Audiorecords/");
      appDir = appDirec;
      appDir!.list().listen((onData) {
        records!.add(onData.path);
      }).onDone(() {
        records = records!.reversed.toList();
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    appDir = null;
    records = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.grey,
      //   onPressed: () {},
      //   child: InkWell(
      //     child: Icon(Icons.mic),
      //     onTap: () {
      //       show(context);
      //     },
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                show(context);
              },
              child: Icon(
                Icons.mic,
                size: 250,
                color: Colors.grey,
              ),
            ),
            height: 300,
            width: double.infinity,
          ),
          Expanded(
            flex: 2,
            child: Records(
              records: records!,
            ),
          ),
        ],
      ),
    );
  }

  _onFinish() {
    records!.clear();
    print(records!.length.toString());
    appDir!.list().listen((onData) {
      records!.add(onData.path);
    }).onDone(() {
      records!.sort();
      records = records!.reversed.toList();
      setState(() {});
    });
  }

  void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white70,
          child: Recorder(
            save: _onFinish,
          ),
        );
      },
    );
  }
}
