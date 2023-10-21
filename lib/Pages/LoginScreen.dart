import 'package:flutter/material.dart';


class LoginScreen  extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context){
    return Container(
      color: const Color.fromARGB(255, 29, 29, 29),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                margin:const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius:  BorderRadius.circular(20),
                  boxShadow:  const[
                    BoxShadow(
                      color: Colors.blue,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3)
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Text("Login", style: TextStyle(fontWeight: FontWeight.bold,fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize),)
                  ],
                ),
              )
              
            ],
          ),
      
        ),
      ),
    );
  }
}