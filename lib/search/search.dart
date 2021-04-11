import 'package:flutter/material.dart';
import 'package:venue/models/venue.dart';
import 'package:http/http.dart' as http;
import 'package:venue/pages/homepage.dart';

class SearchVenue extends SearchDelegate {
  List<Venue> ven;

  SearchVenue(this.ven);

  bool isLoading = true;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomePage()));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final suggestionList = query.isEmpty
        ? ven
        : ven
        .where((element) =>
        element.venueName.toString().toLowerCase().startsWith(query))
        .toList();


    return query.isEmpty ?  Center(
        child: Image.asset("assets/images/venue.png",
            width: MediaQuery.of(context).size.width * 1.5,
            height: MediaQuery.of(context).size.height * 1.5)
    ): suggestionList.isEmpty
        ? Center(child: Text("Venue not Found"))
        : ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text("Venue Name: ${suggestionList[index].venueName}"),
                subtitle: Text(
                    "Author Name: ${suggestionList[index].district}"),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              VenueDetailPage(suggestionList[index])));
                }
                ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

//    only added this
    return query.isEmpty ?  Center(
        child: Image.asset("assets/images/venue.png",
            width: MediaQuery.of(context).size.width * 1.5,
            height: MediaQuery.of(context).size.height * 1.5)
    ): buildResults(context);

//              return Center(
//                child: Text("Search Book"),
//              );
//            return buildResults(context);

//     final suggestionList = query.isEmpty
//         ? boo
//         : boo
//         .where((element) =>
//         element.bookName.toString().toLowerCase().startsWith(query))
//         .toList();
//
//     return suggestionList==null ? LinearProgressIndicator() : suggestionList.isEmpty ? Center(child: Text("Book not Found")) : ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//                 title: Text("Book Name: ${suggestionList[index].bookName}"),
//                 subtitle: Text("Author Name: ${suggestionList[index].authorName}"),
//                 trailing: Text("Pieces: ${suggestionList[index].bookQuantity}"),
//                 onTap: () {
//                   Navigator.push(context,
//                       new MaterialPageRoute(builder: (context) =>
//                           BookDetailPage(suggestionList[index]))
//                   );
//                 }
//             ),
//           );
//         });
  }
}

class VenueDetailPage extends StatelessWidget {
  final Venue venu;

  VenueDetailPage(this.venu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFFF59C16),
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Shelf No:${venu.venueName}",
                style: TextStyle(fontFamily: "Ropa", fontSize: 25.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
         child: Card(
           child: Text("${venu.description}"),

         ),
        )
    );
  }
}


