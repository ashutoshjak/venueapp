import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:venue/models/ipaddress.dart';
import 'package:venue/models/venue.dart';
import 'package:venue/pages/homepage.dart';
import 'dart:convert';
import 'package:venue/search/search.dart';

class VenuePage extends StatefulWidget {
  @override
  _VenuePageState createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  bool isLoading = false;

//  String url = "http://10.0.2.2:8000/venues/?format=json";

  String url = "http://${Server.ipAddress}/venues";

  Future<List<Venue>> fetchVenue() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Venue> venue = parseRequestVenues(response.body);
        return venue;
      } else {
        failed();
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void failed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Could not load "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Venue> parseRequestVenues(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed.map<Venue>((json) => Venue.fromJson(json)).toList();
    }
  }

  List<Venue> venue = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchVenue().then((venuesFromServer) {
      setState(() {
        isLoading = false;
        venue = venuesFromServer;
      });
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchVenue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          title: Text(
            'Venue List',
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: "Ropa",
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _getData,
                child: venue.isEmpty
                    ? Center(child: Text("No venue found"))
                    : ListView.builder(
                        itemCount: venue == null ? 0 : venue.length,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: <Widget>[
//                  Card(
//                    elevation: 5,
//                    color: Colors.white,
//                    child: ListTile(
//                        title: Text("${venue[index].venueName}"),
//                        subtitle: Text("${venue[index].address}"),
//                        onTap: () {
//                          Navigator.push(
//                              context,
//                              new MaterialPageRoute(
//                                  builder: (context) =>
//                                      VenueDetailPage(venue[index])));
//                        }
//                    ),
//                  ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              VenueDetailPage(venue[index])));
                                },
                                child: Card(
                                  child: Container(
                                    height: 130,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                venue[index].venueName,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Image.network(
                                                venue[index].image,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.15,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                Text(
                                                  'District:' +
                                                      venue[index].district,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Address:' +
                                                      venue[index].address,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
//                                                Text(
//                                                  'Opening:' +
//                                                      venue[index].openTime,
//                                                  style: TextStyle(
//                                                      fontWeight:
//                                                          FontWeight.bold,
//                                                      color: Colors.blue),
//                                                ),
//                                                Text(
//                                                  'Closing:' +
//                                                      venue[index].closingTime,
//                                                  style: TextStyle(
//                                                      fontWeight:
//                                                          FontWeight.bold,
//                                                      color: Colors.green),
//                                                ),
//                                                Text(
//                                                  'Price:' +
//                                                      'Rs' +
//                                                      venue[index]
//                                                          .price
//                                                          .toString(),
//                                                  style: TextStyle(
//                                                      fontWeight:
//                                                          FontWeight.bold,
//                                                      color: Colors.red),
//                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
              ));
  }
}
