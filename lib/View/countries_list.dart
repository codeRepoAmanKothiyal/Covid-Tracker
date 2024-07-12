import 'package:covid_tracker/Api/api_service.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListPage extends StatefulWidget {
  const CountryListPage({super.key});

  @override
  State<CountryListPage> createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Api apiService = Api();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: Api().fatchCountrysListRecords(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                              baseColor:Colors.grey.shade700,
                              highlightColor : Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10, width: 89, color: Colors.white),
                                      subtitle:Container(height: 10, width: 89, color: Colors.white),
                                      leading: Container(height: 50, width: 50, color: Colors.white),
                                    ),
                                  ],
                                ),
                            );
                          });
                    }else{
                     return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                          String cName= snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                      cName: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeath: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      todaysRecovered: snapshot.data![index]['todayRecovered'],
                                      test: snapshot.data![index]['tests'],
                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country'].toString()),
                                    subtitle:Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else if(cName.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                      cName: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeath: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      todaysRecovered: snapshot.data![index]['todayRecovered'],
                                      test: snapshot.data![index]['tests'],
                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country'].toString()),
                                    subtitle:Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Container();
                          }

                      });
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
