import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:venue/models/design.dart';
import 'package:venue/models/venue.dart';
import 'package:venue/pages/inquiryform.dart';
import 'dart:convert';
import 'package:venue/pages/venuedisplay.dart';
import 'package:venue/search/search.dart';
import 'package:venue/models/ipaddress.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading=false;

//  String url = "http://192.168.1.69:8000/venues";
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
      return parsed
          .map<Venue>((json) => Venue.fromJson(json))
          .toList();
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text('Venue',style: TextStyle(
            fontSize: 35.0,fontFamily: "Ropa",
          ),),
          centerTitle: true,
          backgroundColor: custom_color
        ) ,
      backgroundColor: isLoading ? Colors.white : custom_color,
      body:  isLoading ?  Center(
        child: CircularProgressIndicator(),
      ):  Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Flexible(
            child:  Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)
                ),
              ),

              child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[

                      Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),

                        child: InkWell(
                          onTap: () {
                            showSearch(
                                context: context, delegate: SearchVenue(venue));
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    iconSize: 60,
                                    alignment: Alignment.topCenter,
                                    icon: Icon(Icons.search)),
                                Text(
                                  'Search',
                                  style: new TextStyle(fontSize: 17.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),

                        margin: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new VenuePage()));
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    iconSize: 60,
                                    alignment: Alignment.topCenter,
                                    icon: Icon(
                                        Icons.account_balance
                                    )),
                                Text(
                                  'Venue List',
                                  style: new TextStyle(fontSize: 17.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),

                        margin: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new InquiryForm()));
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    iconSize: 60,
                                    alignment: Alignment.topCenter,
                                    icon: Icon(
                                        Icons.comment
                                    )),
                                Text(
                                  'Inquiry Form',
                                  style: new TextStyle(fontSize: 17.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

