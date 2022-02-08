
enum TypeOfMovie{all,movies,series, episode}

class SearchData{
  final String search;
  final int? year;
  final TypeOfMovie type;

  SearchData({
    required this.search,
    this.year,
    this.type = TypeOfMovie.all
  });

  SearchData copyWith({ String? search, int? year, TypeOfMovie? type }) =>
      SearchData(search: search ?? "", year: year, type: type ?? TypeOfMovie.all);

}