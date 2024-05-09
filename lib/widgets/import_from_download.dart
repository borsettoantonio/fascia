import 'dart:io';

import 'package:fascia/providers/pazienti_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';

class ImportToDownload extends StatefulWidget {
  ImportToDownload({super.key});

  @override
  State<ImportToDownload> createState() => _ImportToDownloadState();
}

class _ImportToDownloadState extends State<ImportToDownload> {
  bool sending = false;
  double progress = 0.0;
  String message = '';

  @override
  void initState() {
    sendFile();
    super.initState();
  }

  @override
  void didUpdateWidget(ImportToDownload oldWidget) {
    super.didUpdateWidget(oldWidget);
    sendFile();
  }

  @override
  Widget build(BuildContext context) {
    return sending
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: progress,
              ),
            ),
          )
        : Center(
            child: Text(
            message,
            style: const TextStyle(fontSize: 30),
          ));
  }

  void sendFile() async {
    setState(() {
      sending = true;
      progress = 0;
    });

    bool res = await sendDatabase();
    setState(() {
      if (res) {
        message = 'Database importato';
      } else {
        message = 'Errore nell\'import';
      }
      Provider.of<Pazienti>(context, listen: false).resetPazienti();
      sending = false;
    });
  }

  Future<String> getDB() async {
    String dbPath = await getDatabasesPath();
    return '$dbPath/pazienti.db';
  }

  Future<bool> sendDatabase() async {
    //print((await getDownloadsDirectory())!.absolute);
    try {
      if (Platform.isAndroid) {
        PermissionStatus status1 = await Permission.storage.request();
        PermissionStatus status2 =
            await Permission.manageExternalStorage.request();
        // status2 isGranted for Android >= 11
        // status1 isGranted for Android < 11
        if (status1.isGranted || status2.isGranted) {
          String dest = await getDB();
          File destFile = File(dest);
          File sourceFile = File('storage/emulated/0/Download/pazienti.db');
          if (await destFile.exists()) {
            await destFile.delete();
          }
          await sourceFile.copy(dest);
          return true;
        } else {
          return false;
        }
      } else if (Platform.isWindows) {
        String dest = await getDB();
        File destFile = File(dest);
        String nomeSource =
            '${(await getDownloadsDirectory())!.path}\\pazienti.db';
        File sourceFile = File(nomeSource);
        if (await destFile.exists()) {
          await destFile.delete();
        }
        await sourceFile.copy(dest);
        return true;
      } else {
        // inserire la versione per iOS
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
