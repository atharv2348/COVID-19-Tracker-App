import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/View/countries_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WorldStatesServcies statesServcies = WorldStatesServcies();
    return Scaffold(
      appBar: AppBar(
        title: const Text("World States"),
        centerTitle: true,
        // It removes default back-arrow given by flutter, coz we don't want to navigate back to the splash screen
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: statesServcies.fetchWorldStatesApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  PieChart(
                    dataMap: {
                      "Total": double.parse(snapshot.data!.cases.toString()),
                      "Recovered":
                          double.parse(snapshot.data!.recovered.toString()),
                      "Death": double.parse(snapshot.data!.deaths.toString()),
                    },
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left),
                    animationDuration: const Duration(milliseconds: 1200),
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true),
                    chartType: ChartType.ring,
                    colorList: const [
                      Color(0xFF4285F4),
                      Color(0xFF1AA260),
                      Color(0xFFD35246),
                    ],
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.width * 0.07)),
                  Card(
                    child: Column(
                      children: [
                        ReusableRow(
                            title: "Total",
                            value: snapshot.data!.cases.toString()),
                        ReusableRow(
                            title: "Deaths",
                            value: snapshot.data!.deaths.toString()),
                        ReusableRow(
                            title: "Recovered",
                            value: snapshot.data!.recovered.toString()),
                        ReusableRow(
                            title: "Active",
                            value: snapshot.data!.active.toString()),
                        ReusableRow(
                            title: "Critical",
                            value: snapshot.data!.critical.toString()),
                        ReusableRow(
                            title: "Today Deaths",
                            value: snapshot.data!.todayDeaths.toString()),
                        ReusableRow(
                            title: "Today Recovered",
                            value: snapshot.data!.todayRecovered.toString()),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesStates()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(212, 8, 160, 26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(child: Text("Track Countries", style: TextStyle(fontSize: 20),)),
                    ),
                  )
                ],
              );
            } else {
              return SpinKitFadingCircle(
                  color: Colors.white, controller: _controller, size: 50);
            }
          },
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          // SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
