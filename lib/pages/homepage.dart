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
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Text('VenueCate',style: TextStyle(
              fontSize: 35.0,fontFamily: "Ropa",
            ),),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                showSearch(
                    context: context, delegate: SearchVenue(venue));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Card(
                  child: Row(
                    children: <Widget>[
//              SizedBox(height: 100,),
                      Row(
                        children: <Widget>[
                          InkWell(
                            child: IconButton(
                              icon: Icon(Icons.search),
                            ),
                          ),
                            Text('Search',
                                textAlign: TextAlign.center),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),)
          ),
          backgroundColor: custom_color
        ) ,
      backgroundColor: isLoading ? Colors.white : Colors.white,
      body:  isLoading ?  Center(
        child: CircularProgressIndicator(),
      ):  RefreshIndicator(
      onRefresh: _getData,
      child: venue.isEmpty
          ? Center(child: Text("No venue found"))
          : GridView.builder(
        itemCount: venue == null ? 0 : venue.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemBuilder: (BuildContext context, index) {
          return Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            VenueDetailPage(venue[index])));
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: [
                    SizedBox(
                      width: 335,
                      height: 110,
                      child: Image.network(
                        venue[index].image,

                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 16,),
                    Column(children:[
                      Text('Venue Name : ' + venue[index].venueName),
                      SizedBox(height: 10,),
                      Text('Address : ' + venue[index].address),
                      SizedBox(height: 10,),
                    ])

                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
            ),
          ]);
        },
      ),
    )

    );
  }
}

