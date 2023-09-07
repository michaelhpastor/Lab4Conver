import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: cronometro(),
    );
  }
}

class cronometro extends StatefulWidget {
  const cronometro({super.key});

  @override
  State<cronometro> createState() => _cronometroState();
}

class _cronometroState extends State<cronometro> {
  int segundos = 0, minutos = 0, horas = 0;
  String digSeg = "00", digMin = "00", digHor = "00";
  Timer? timer;
  bool inicio = false;

  void stop(){
    timer!.cancel();
    setState(() {
      inicio = false;
    });
  }

  void reset(){
    timer!.cancel();
    setState(() {
      segundos = 0;
      minutos = 0;
      horas = 0;

      digSeg = "00";
      digMin = "00";
      digHor = "00";

      inicio = false;
    });
  }

  void start(){
    if(inicio!=true){
    inicio = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer){
      int segundosLocal = segundos+1;
      int minutosLocal = minutos;
      int horasLocal = horas;

      if(segundosLocal > 59){
        if(minutosLocal > 59){
          horasLocal++;
          minutosLocal = 0;
        } else{
          minutosLocal++;
          segundosLocal = 0;
        }
      }

      setState(() {
        segundos = segundosLocal;
        minutos =minutosLocal;
        horas=horasLocal;
        digSeg = (segundos>=10)? "$segundos": "0$segundos";
        digMin = (minutos>=10)? "$minutos": "0$minutos";
        digHor = (horas>=10)? "$horas": "0$horas";
      });
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(50),
              child: Text("$digHor:$digMin:$digSeg", style: TextStyle(fontSize: 38.0),),
            ),
          ),
          Center(
            child: ElevatedButton(onPressed: () {
              start();
            }, 
            child: Text("Start")
            ),
          ),
          Center(
            child: ElevatedButton(onPressed: () {
              stop();
            }, 
            child: Text("Stop")
            ),
          ),
          Center(
            child: ElevatedButton(onPressed: () {
              reset();
            }, 
            child: Text("Reset")
            ),
          )
        ],
      ),
    );
  }
}