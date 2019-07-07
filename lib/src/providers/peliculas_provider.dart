import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class  PeliculasProvider {
  String _apikey   = 'c5398273dbcc5e7d171e2434ee6e685e';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.http(_url, '3/movie/now_playing',{
      'api_key'  : _apikey,
      'language' : _language
    });

    final resp        = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas   = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}