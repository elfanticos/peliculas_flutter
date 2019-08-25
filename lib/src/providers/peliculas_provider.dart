import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class  PeliculasProvider {
  String _apikey            = 'c5398273dbcc5e7d171e2434ee6e685e';
  String _url               = 'api.themoviedb.org';
  String _language          = 'es-ES';
  int _popularesPage        = 0;
  List<Pelicula> _populares = new List();
  bool _cargando            = false;

  final _popularesStream    = StreamController<List<Pelicula>>.broadcast();

  // Geter para agregar y mostrar los stream
  Function(List<Pelicula>)get populasSink =>_popularesStream.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStream.stream;

  void disposeStreams() {
    _popularesStream?.close();
  }

  Uri _getService(path, dynamic param) {
    return Uri.http(_url, path, param);
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri requestApi) async {

    // Obtener datos del servico
    final resp        = await http.get(requestApi);

    // Decodificar en json
    final decodedData = json.decode(resp.body);

    // Obtener la lista para utilizar
    final peliculas   = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {

    // Objeto de parametro
    dynamic param = {
      'api_key'  : _apikey,
      'language' : _language
    };

    return await _procesarRespuesta(_getService('3/movie/now_playing',param));
  }

  Future<List<Pelicula>> getPopulares() async {

    // Validar si ya se envio a solicitar los populares
    if (_cargando) return [];
    _cargando= true;
    
    // Aumentar contador
    _popularesPage++;

    // Objeto de parametro
    dynamic param = {
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    };

    final rpta = await _procesarRespuesta(_getService('/3/movie/popular', param));
    _populares.addAll(rpta);
    populasSink(_populares);
    _cargando = false;
    return rpta;
    
  }


  Future<List<Pelicula>> buscarPelicula(String query) async {

    // Objeto de parametro
    dynamic param = {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    };

    return await _procesarRespuesta(_getService('3/search/movie',param));
  }
}