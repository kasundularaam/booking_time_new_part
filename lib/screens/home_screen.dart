import 'package:booking_time/api/restaurent_service.dart';
import 'package:booking_time/components/rounded_restaurant.dart';
import 'package:booking_time/models/restaurent_model.dart';
import 'package:flutter/material.dart';
import 'package:booking_time/components/rounded_containers.dart';
// import 'package:search_widget/search_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RestaurentServices _restaurentServices = RestaurentServices();
  bool _isSearch = false;
  String _searchText;

  Future<List<Restaurent>> getRestaurents(bool isSearch) async {
    if (isSearch && _searchText.isNotEmpty) {
      List<Restaurent> filteredList = await _restaurentServices
          .searchRestByName(_searchText.trim().toLowerCase());
      return filteredList;
    } else {
      List<Restaurent> restaurentList =
          await _restaurentServices.getRestaurentsByLoc();
      return restaurentList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Booking Time",
                      style: TextStyle(
                        fontSize: 37.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/logo.png"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                    if (value.isNotEmpty) {
                      _isSearch = true;
                    } else {
                      _isSearch = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Restaurant",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60)),
                  filled: true,
                  errorStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: buildTopChip("Suggestions", true),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getRestaurents(_isSearch),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    List<Restaurent> restList = snapshot.data;
                    if (restList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: restList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Restaurent rest = restList[index];
                          return RoundedRest(
                            image:
                                "https://images.pexels.com/photos/3676531/pexels-photo-3676531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                            rName: rest.rName,
                            restId: rest.id,
                          );
                        },
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
