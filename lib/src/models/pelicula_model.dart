class Peliculas {

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }

}


class Pelicula {
  String uniqueId;
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String,dynamic> json) {
    this.voteCount        = json['vote_count'];
    this.id               = json['id'];
    this.video            = json['video'];
    this.voteAverage      = json['vote_average'] / 1 ;
    this.title            = json['title'];
    this.popularity       = json['popularity'] /1;
    this.posterPath       = json['poster_path'];
    this.originalLanguage = json['original_language'];
    this.originalTitle    = json['original_title'];
    this.genreIds         = json['genre_ids'].cast<int>();
    this.backdropPath     = json['backdrop_path'];
    this.adult            = json['adult'];
    this.overview         = json['overview'];
    this.releaseDate      = json['release_date'];
  }

  String getPosterImg() {
    if (posterPath == null) {
      return 'https://insidelatinamerica.net/wp-content/uploads/2018/01/noImg_2.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  String getBackgroundImg() {
    if (posterPath == null) {
      return 'https://insidelatinamerica.net/wp-content/uploads/2018/01/noImg_2.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
