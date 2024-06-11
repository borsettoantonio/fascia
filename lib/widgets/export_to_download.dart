import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportToDownload extends StatefulWidget {
  const ExportToDownload({super.key});

  @override
  State<ExportToDownload> createState() => _ExportToDownloadState();
}

class _ExportToDownloadState extends State<ExportToDownload> {
  bool sending = false;
  double progress = 0.0;
  String message = '';

  @override
  void initState() {
    sendFile();
    super.initState();
  }

  @override
  void didUpdateWidget(ExportToDownload oldWidget) {
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
        message = 'Database copiato';
      } else {
        message = 'Errore nella copia';
      }
      sending = false;
    });
  }

  Future<File> getDB() async {
    String dbPath = await getDatabasesPath();
    dbPath += '/pazienti.db';
    return File(dbPath);
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
          File sourceFile = await getDB();
          File destFile = File('storage/emulated/0/Download/pazienti.db');
          if (await destFile.exists()) {
            await destFile.delete();
          }
          await sourceFile.copy('/storage/emulated/0/Download/pazienti.db');
          return true;
        } else {
          return false;
        }
      } else if (Platform.isWindows) {
        File sourceFile = await getDB();
        String nomeDest =
            '${(await getDownloadsDirectory())!.path}\\pazienti.db';
        File destFile = File(nomeDest);
        if (await destFile.exists()) {
          await destFile.delete();
        }
        await sourceFile.copy(nomeDest);
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
