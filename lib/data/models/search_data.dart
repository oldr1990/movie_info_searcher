enum TypeOfMovie { all, movies, series, episode }

class SearchData {
  final String search;
  final String? year;
  final TypeOfMovie? type;
  final int page;

  const SearchData({
    this.search = '',
    this.year,
    this.type = TypeOfMovie.all,
    this.page = 1,
  });

  SearchData copyWith(
      {String? search, String? year, TypeOfMovie? type, int? page}) {
    return SearchData(
        search: search ?? this.search,
        year: year ?? this.year,
        type: type ?? this.type,
        page: page ?? this.page);
  }
}
