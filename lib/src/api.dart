import 'package:dio/dio.dart';
import 'search_options.dart';
import 'category.dart';

const zLocations = ['city', 'subzone', 'zone', 'landmark', 'metro', 'group'];
const zSort = ['cost', 'rating'];
const zOrder = ['asc', 'desc'];
const double zMaxCount = 20; // L'API NE RETOURNE QU'UN MAXIMUM DE 20 RESULTATS

class ZomatoApi {
  final List<String> locations = zLocations;
  final List<String> sort = zSort;
  final List<String> order = zOrder;
  final double count = zMaxCount;

  final Dio _dio;
  final List<Category> categories = [];

  ZomatoApi(String key)
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://developers.zomato.com/api/v2.1/',
            headers: {
              'user-key': key,
              'Accept': 'application/json',
            },
          ),
        );

/* ---------------------------------------
   FONCTION RECUPERE LES CATEGORIES
-----------------------------------------*/

  Future<List<Category>> loadCategories() async {
    final response = await _dio.get('categories');
    final data = response.data['categories'];
    categories.addAll(
      data.map<Category>(
        (json) => Category(
          json['categories']['id'],
          json['categories']['name'],
        ),
      ),
    );
  }

/* ---------------------------------------
   FONCTION DE RECHERCHE DANS L'API
-----------------------------------------*/

  Future<List> searchRestaurant(String query, SearchOptions options) async {
    final response = await _dio.get(
      'search',
      queryParameters: {
        'q': query,
        ...(options != null ? options.toJson() : {}),
      },
    );
    return response.data['restaurants'];
  }
}
