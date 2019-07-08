import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class  PeliculasProvider {
  String _apikey   = 'c5398273dbcc5e7d171e2434ee6e685e';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  Uri _getService({String path}) {
    return Uri.http(_url, path, {
      'api_key'  : _apikey,
      'language' : _language
    });
  }

  Future<List<Pelicula>> _procesarRespuesta(String path) async{
    final resp        = await http.get(_getService(path: path));
    final decodedData = json.decode(resp.body);
    final peliculas   = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    return await _procesarRespuesta('3/movie/now_playing');
  }

  Future<List<Pelicula>> getPopulares() async {
    return await _procesarRespuesta('/3/movie/popular');
  }
}