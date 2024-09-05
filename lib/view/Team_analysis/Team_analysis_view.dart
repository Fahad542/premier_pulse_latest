import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';


class Team_analysis extends StatefulWidget {
  const Team_analysis({super.key});

  @override
  State<Team_analysis> createState() => _Team_analysisState();
}

class _Team_analysisState extends State<Team_analysis>
{

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text("Team Analysis"),
      ),
      body: Column(
        children: [
        Container(
          decoration: BoxDecoration(color: AppColors.greencolor,),
          height: 35,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, index)
          {
            return InkWell(
              onTap: (){

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: [Text("data", style: TextStyle(color: Colors.white),)],),
              ),
            );
          }
          )
        )],),
    );
  }
}

