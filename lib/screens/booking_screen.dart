import 'package:booking_time/api/menue_services.dart';
import 'package:booking_time/api/restaurent_service.dart';
import 'package:booking_time/components/rounded_buttons.dart';
import 'package:booking_time/models/menue_mdel.dart';
import 'package:booking_time/models/restaurent_model.dart';
import 'package:booking_time/screens/feedbacks_screen.dart';
import 'package:booking_time/screens/reservation_screen.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  static const String id = "booking_screen";
  const BookingScreen({Key key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  MenueService _menueService = MenueService();
  int _rId;
  void getArguments(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) _rId = arguments['rId'];
  }

  @override
  Widget build(BuildContext context) {
    getArguments(context);

    ///  var onPressed2 = null;
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 35),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Restaurant",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
                filled: true,
                errorStyle: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 24),
            buildHeroContainer(),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Booking Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            buildBookingDetail(_rId),
            buildBookingEndStrip(context),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Menu",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: _menueService.getMenuesByRid(_rId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  snapshot.error.toString(),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              List<Menue> menueList = snapshot.data;

                              if (menueList.isNotEmpty) {
                                return Table(
                                  children: buildMenueTableRows(menueList),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "no menues available",
                                  ),
                                );
                              }
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            buildBookingButton(context, _rId),
          ],
        ),
      ),
    );
    ;
  }
}

Widget buildBookingButton(BuildContext context, int restId) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 44),
    width: double.infinity,
    child: RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, ReservationScreen.id,
            arguments: {"rId": restId});
        //TODO
      },
      color: Colors.orange[900],
      textColor: Colors.white,
      elevation: 2,
      child: Text(
        'Book Now',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),
  );
}

Widget buildBookingEndStrip(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(flex: 2, child: buildMarkerIcon()),
        Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.purple,
              ),
              child: Center(
                child: Text("Feedbacks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    )),
              ),
            )),
      ],
    ),
  );
}

Widget buildBookingDetail(int rId) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      16,
      16,
      16,
      0,
    ),
    child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: buildLeftFlex(),
            flex: 2,
          ),
          Flexible(
            child: buildRightFlex(rId),
            flex: 8,
          ),
        ],
      ),
    ),
  );
}

Widget buildRightFlex(int rId) {
  return Container(
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: 24),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      //boxShadow: [raisedBoxShadow],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildTablePicture(),
        Flexible(
          fit: FlexFit.tight,
          child: buildTableDescriptions(rId),
        )
      ],
    ),
  );
}

Widget buildTableDescriptions(int rId) {
  RestaurentServices _restService = RestaurentServices();

  return FutureBuilder(
    future: _restService.getRestaurentById(rId),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) {}
      if (snapshot.hasData) {
        Restaurent rest = snapshot.data;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("${rest.rName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("R.no: ${rest.registeredNumber}"),
            SizedBox(height: 10),
            Text(rest.address),
            SizedBox(height: 2),
            Text(rest.email),
            SizedBox(height: 2),
            Text("${rest.contact}"),
            SizedBox(height: 2),
            /*   RatingBar(
          onRatingUpdate: null,
          itemSize: 20,
          initialRating: 5,
          minRating: 5,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) =>
              Icon(Icons.star, color: Colors.orange[900]),
        ),*/
            SizedBox(height: 2),
            Text('1256 users review'),
          ],
        );
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}

Widget buildTablePicture() {
  return Stack(
    alignment: Alignment.center,
    fit: StackFit.loose,
    children: <Widget>[
      Container(width: 120),
      Image.asset('assets/table.png', width: 100, fit: BoxFit.fitWidth),
      Positioned(
        left: 0,
        bottom: 0,
        child: Container(
          height: 36,
          width: 36,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            //  color: mainColor,
            shape: BoxShape.circle,
            //   boxShadow: [raisedBoxShadow],
          ),
          child: Center(
            child: Icon(Icons.done_all, color: Colors.white, size: 24),
          ),
        ),
      )
    ],
  );
}

Widget buildLeftFlex() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      buildMarkerIcon(),
      Flexible(
        fit: FlexFit.loose,
        child: VerticalDivider(
          color: Colors.blueGrey,
          thickness: 1.5,
        ),
      ),
    ],
  );
}

List<TableRow> buildMenueTableRows(List<Menue> menueList) {
  List<TableRow> tableRowList = [buildTableHead(), rowSpacer()];

  menueList.forEach((menue) {
    tableRowList.add(buildTableRow(menue.name, menue.price));
    tableRowList.add(rowSpacer());
  });

  return tableRowList;
}

TableRow rowSpacer() {
  return TableRow(children: [
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    )
  ]);
}

TableRow buildTableHead() {
  return TableRow(
    children: [
      Column(
        children: [
          Text(
            "Foods",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Price",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}

TableRow buildTableRow(String food, int price) {
  return TableRow(
    children: [
      Column(
        children: [
          Text(
            food,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Rs.$price.00",
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildMarkerIcon() {
  return Container(
    height: 56,
    width: 56,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      //  boxShadow: [raisedBoxShadow],
      shape: BoxShape.circle,
    ),
    child: Image.asset('assets/target.png', width: 40, fit: BoxFit.contain),
  );
}

Widget buildHeroContainer() {
  return Container(
    margin: EdgeInsets.all(16),
    // decoration: BoxDecoration(boxShadow: [raisedBoxShadow]),
    height: 220,
    width: double.infinity,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'images/hotel.jpg',
              fit: BoxFit.cover,
            )),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(36),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: EdgeInsets.all(8),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('From \$ 56.00'),
                  SizedBox(width: 24),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      //  color: mainColor,
                    ),
                    child: Center(child: Text('Shangri-La')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(
        left: 24,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          //colors: [mainColor, Colors.deepOrange[600]],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, colors: [],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.restaurant_menu, size: 42, color: Colors.white),
          SizedBox(width: 16),
          Text(
            'Booking Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
