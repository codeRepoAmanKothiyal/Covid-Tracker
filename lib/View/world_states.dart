import 'package:covid_tracker/Api/api_service.dart';
import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList =<Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)

  ];

  @override
  Widget build(BuildContext context) {
    Api apiService = Api();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                FutureBuilder(future: apiService.fatchWorldStatesRecords(),
                    builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  }else{
                    return Column(
                      children: [
                        PieChart(dataMap: {
                          "Total": double.parse(snapshot.data!.cases.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered.toString()),
                          "Death":double.parse(snapshot.data!.deaths.toString())
                        },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          animationDuration: Duration(milliseconds: 1200),
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: "Cases", value: snapshot.data!.cases.toString()),
                                ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                                ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                ReusableRow(title: "Today Cases", value: snapshot.data!.todayCases.toString()),
                                ReusableRow(title: "Total Tests", value: snapshot.data!.tests.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListPage()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("Track Countries", style: TextStyle(fontSize: 18),),
                            ),
                          ),
                        ),

                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
        ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}


