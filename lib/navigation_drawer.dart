import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kripto_uygulamasi/giris_Yap.dart';

import 'cuzdanim.dart';
import 'favoriler.dart';
import 'hakkinda.dart';

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Cüzdanım"),
            leading: Icon(Icons.money),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => cuzdanim()));
            },
          ),
          ListTile(
            title: Text("Favoriler"),
            leading: Icon(Icons.favorite),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => favoriler()));
            },
          ),
          ListTile(
            title: Text("Hakkında"),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => hakkinda()));
            },
          ),
          ListTile(
            title: Text("Çıkış yap"),
            leading: InkWell(child: Icon(Icons.exit_to_app)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => GirisEkrani()));
            },

          ),
        ],
      ),
    );
  }
}
