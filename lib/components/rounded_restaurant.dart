import 'package:flutter/material.dart';

class RoundedRest extends StatelessWidget {
  const RoundedRest({Key key, this.image, this.r_name, this.reviews})
      : super(key: key);

  final String image;
  final String r_name;
  final String reviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          r_name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          reviews,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: CircleAvatar(
                      child: Text(
                        "4.5",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
