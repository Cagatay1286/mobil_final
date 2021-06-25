import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kripto_uygulamasi/main.dart';

import 'giris_Yap.dart';


class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  String email, sifre;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase KAYİT"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (alinanEmail) {
                  setState(() {
                    email = alinanEmail;
                  });
                },
                validator: (alinanEmail) {
                  return alinanEmail.contains("@") ? null : "Mail Geçersizdir.";
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email giriniz",
                  hintText: "email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (alinanSifre) {
                  setState(() {
                    sifre = alinanSifre;
                  });
                },
                validator: (alinanSifre) {
                  return alinanSifre.length >= 6
                      ? null
                      : "Şİfreniz en az 6 karakterli olmalıdır.";
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre Giriniz",
                  hintText: "Şifre",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    kayitEkle();
                  },
                  child: Text(
                    "Kaydol",
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GirisEkrani()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Zaten hesabım var.",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void kayitEkle() {
    if (_formKey.currentState.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => GirisEkrani()),
                (Route<dynamic> route) => false);
      }).catchError((hata) {
        debugPrint("hatanız var $hata");
      });
    }
  }
}