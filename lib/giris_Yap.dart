import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kripto_uygulamasi/main.dart';

import 'kayit_Ol.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  String email, sifre;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Giriş Ekranı"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (alinanEmail) {
                    setState(() {
                      email = alinanEmail;
                    });
                  },
                  validator: (alinanEmail) {
                    return alinanEmail.contains("@") ? null : "Geçersiz kullanıcı veya şifre girdiniz!";
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (alinanSifre) {
                    setState(() {
                      sifre = alinanSifre;
                    });
                  },
                  validator: (alinanSifre) {
                    return alinanSifre.length >= 6
                        ? null
                        : "En az 6 karakter giriniz.";
                  },
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    girisYap();
                  },
                  child: Text("Giriş"),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KayitEkrani(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Üye ol",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void girisYap() {
    if (formKey.currentState.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }).catchError((hata) {
        debugPrint("Hata aldınız. $hata");
      });
    }
  }
}
