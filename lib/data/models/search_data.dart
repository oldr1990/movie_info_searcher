
enum TypeOfMovie{all,movies,series, episode}

class SearchData{
  final String search;
  final String? year;
  final TypeOfMovie type;

  SearchData({
    required this.search,
    this.year,
    this.type = TypeOfMovie.all
  });

  SearchData copyWith({ String? search, String? year, TypeOfMovie? type }) =>
      SearchData(search: search ?? "", year: year, type: type ?? TypeOfMovie.all);

}