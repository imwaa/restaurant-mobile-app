import 'package:flutter/material.dart';
import './search_filters_screen.dart';
import './search_form.dart';
import './restaurant_item.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dio}) : super(key: key);

  final String title;
  final Dio dio;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/* ---------------------------------------
   FONCTION DE RECHERCHE DANS L'API
-----------------------------------------*/
class _MyHomePageState extends State<MyHomePage> {
  String query;
  SearchOptions _filters;

  Future<List> searchRestaurant(String query) async {
    final response = await widget.dio.get(
      'search',
      queryParameters: {
        'q': query,
        ...(_filters != null ? _filters.toJson() : {}),
      },
    );
    return response.data['restaurants'];
  }

  /* ---------------------------------------
      DESIGN D'INTERFACE HEADER
-----------------------------------------*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.redAccent,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SearchFilters(
                          dio: widget.dio,
                          onSetFilters: (filters) {
                            _filters = filters;
                          },
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                child: Icon(
                  Icons.tune,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchForm(
              onSearch: (q) {
                setState(() {
                  query = q;
                });
              },
            ),
            SizedBox(height: 10),
            query == null
                ? Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black12,
                          size: 110,
                        ),
                        Text(
                          'Pas de resultats à afficher',
                          style: TextStyle(
                            color: Colors.black12,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                : FutureBuilder(
                    future: searchRestaurant(query),
                    builder: (context, snapshot) {
                      // Progress indicator , pour indiquer qu'on effectue une recherche
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.red),
                        );
                      }
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView(
                            children: snapshot.data
                                .map<Widget>(
                                    (json) => RestaurantItem(Restaurant(json)))
                                .toList(),
                          ),
                        );
                      }
                      return Text(
                          'Error retrieving results: ${snapshot.error}');
                    },
                  )
          ],
        ),
      ),
    );
  }
}
