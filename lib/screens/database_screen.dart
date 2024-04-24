import 'package:fascia/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/export_to_download.dart';

enum FilterOptions {
  download,
  email,
}

class DatabaseScreen extends StatefulWidget {
  static const routeName = '/database';
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  FilterOptions? scelta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Import/Export Database'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.download) {
                  scelta = FilterOptions.download;
                } else {
                  scelta = FilterOptions.email;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.download,
                child: Text('Export to Download'),
              ),
              const PopupMenuItem(
                value: FilterOptions.email,
                child: Text('Export to email'),
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: switch(scelta)
      {
         FilterOptions.download => ExportToDownload(),
         FilterOptions.email => Container(child:Text('email')),
         null => null,
      },
     
    );
  }
}
