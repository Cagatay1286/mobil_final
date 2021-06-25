import 'package:flutter/material.dart';

class hakkinda extends StatefulWidget {
  @override
  _hakkindaState createState() => _hakkindaState();
}

class _hakkindaState extends State<hakkinda> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hakkında"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedDefaultTextStyle(
                style: isSelected
                    ? TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)
                    : TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                    color: Colors.black),
                duration: const Duration(milliseconds: 200),
                child: Text('Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen "3311456" kodlu "Mobil Programlama" dersi kapsamında "183311009" numaralı "Çağatay" tarafından "25 Haziran 2021" günü yapılmıştır.'),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  child: Text("Bana tıkla!"))
            ],
          ),
        ),
      ),
    );
  }
}