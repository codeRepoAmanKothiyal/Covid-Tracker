import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String cName;
  String image;
  int totalCases,  totalDeath, todaysRecovered, active,critical,test;
  DetailScreen({required this.cName,
    required this.image,
    required this.totalCases,
    required this.totalDeath,
    required this.todaysRecovered,
    required this.active,
    required this.critical,
    required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: MediaQuery.of(context).size.width/2.5,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                        ReusableRow(title: "Country Name", value: widget.cName.toString()),
                        ReusableRow(title: "Cases", value: widget.totalCases.toString()),
                        ReusableRow(title: "Total Deaths", value: widget.totalDeath.toString()),
                        ReusableRow(title: "Todays Recovered", value: widget.todaysRecovered.toString()),
                        ReusableRow(title: " Active Cases", value: widget.active.toString()),
                        ReusableRow(title: "Critical Cases", value: widget.critical.toString()),
                        ReusableRow(title: "Tests", value: widget.test.toString())
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),)


              ],
            )
          ],
        ),
      ),
    );
  }
}
