import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesStates extends StatefulWidget {
  const CountriesStates({super.key});

  @override
  State<CountriesStates> createState() => _CountriedStatesState();
}

class _CountriedStatesState extends State<CountriesStates>
    with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this);

  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WorldStatesServcies statesServcies = WorldStatesServcies();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) =>
                    setState(() {}), // 'll update the UI while typing
                decoration: InputDecoration(
                    hintText: "Search with country name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: statesServcies.fetchCountriesStatesApi(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name =
                                snapshot.data![index]["country"].toString();

                            if (_searchController.text.isEmpty) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            name: snapshot.data![index]
                                                ["country"],
                                            image: snapshot.data![index]
                                                ["countryInfo"]["flag"],
                                            totalCases: snapshot.data![index]
                                                ["cases"],
                                            totalDeaths: snapshot.data![index]
                                                ["deaths"],
                                            totalRecovered: snapshot.data![index]
                                                ["recovered"],
                                            active: snapshot.data![index]
                                                ["active"],
                                            critical: snapshot.data![index]
                                                ["critical"],
                                            todayRecovered: snapshot.data![index]
                                                ["todayRecovered"],
                                            tests: snapshot.data![index]["tests"]))),
                                child: ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]))),
                              );
                            } else if (name.toLowerCase().contains(
                                _searchController.text.toLowerCase())) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            name: snapshot.data![index]
                                                ["country"],
                                            image: snapshot.data![index]
                                                ["countryInfo"]["flag"],
                                            totalCases: snapshot.data![index]
                                                ["cases"],
                                            totalDeaths: snapshot.data![index]
                                                ["deaths"],
                                            totalRecovered: snapshot.data![index]
                                                ["recovered"],
                                            active: snapshot.data![index]
                                                ["active"],
                                            critical: snapshot.data![index]
                                                ["critical"],
                                            todayRecovered: snapshot.data![index]
                                                ["todayRecovered"],
                                            tests: snapshot.data![index]["tests"]))),
                                child: ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]))),
                              );
                            } else {
                              return Container();
                            }
                          });
                      // Shimmer Effect
                    } else {
                      return ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade700,
                              child: ListTile(
                                  title: Container(
                                      width: 90,
                                      height: 10,
                                      color: Colors.white),
                                  subtitle: Container(
                                      width: 90,
                                      height: 10,
                                      color: Colors.white),
                                  leading: Container(
                                    height: 50,
                                    color: Colors.white,
                                    width: 50,
                                  )),
                            );
                          });
                    }
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
