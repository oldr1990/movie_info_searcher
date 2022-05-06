enum TypeOfMovie { all, movies, series, episode }

class SearchData {
  final String search;
  final String? year;
  final TypeOfMovie? type;
  final int? page;

  SearchData({
    required this.search,
    this.year,
    this.type = TypeOfMovie.all,
    this.page,
  });

}
