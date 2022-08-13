

String mockResponse = '{"Search":['
    '{"Title":"One Flew Over the Cuckoos Nest","Year":"1975","imdbID":"tt0073486","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BZjA0OWVhOTAtYWQxNi00YzNhLWI4ZjYtNjFjZTEyYjJlNDVlL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"},'
    '{"Title":"Rogue One","Year":"2016","imdbID":"tt3748528","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMjEwMzMxODIzOV5BMl5BanBnXkFtZTgwNzg3OTAzMDI@._V1_SX300.jpg"},'
    '{"Title":"Ready Player One","Year":"2018","imdbID":"tt1677720","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BY2JiYTNmZTctYTQ1OC00YjU4LWEwMjYtZjkwY2Y5MDI0OTU3XkEyXkFqcGdeQXVyNTI4MzE4MDU@._V1_SX300.jpg"},'
    '{"Title":"Birds of Prey: And the Fantabulous Emancipation of One Harley Quinn","Year":"2020","imdbID":"tt7713068","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMzQ3NTQxMjItODBjYi00YzUzLWE1NzQtZTBlY2Y2NjZlNzkyXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX300.jpg"},'
    '{"Title":"Air Force One","Year":"1997","imdbID":"tt0118571","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYTk5NWE2ZjAtZmRmOS00ZGYzLWI5ZmUtMDcwODI0YWY0MTRlL2ltYWdlXkEyXkFqcGdeQXVyNjQzNDI3NzY@._V1_SX300.jpg"},'
    '{"Title":"One Hundred and One Dalmatians","Year":"1961","imdbID":"tt0055254","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BZGMyMjE4OGUtNGZmMC00YzdmLThkMWYtZWIzMmEzNjA4MzVkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"},'
    '{"Title":"One Day","Year":"2011","imdbID":"tt1563738","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMTQ3NTg2MDI3NF5BMl5BanBnXkFtZTcwMjc5MTA1NA@@._V1_SX300.jpg"},'
    '{"Title":"One Punch Man: Wanpanman","Year":"2015–","imdbID":"tt4508902","Type":"series","Poster":"https://m.media-amazon.com/images/M/MV5BMTNmZDE2NDEtNTg3MS00OTE1LThlZGUtOGZkZTg0NTUyNGVmXkEyXkFqcGdeQXVyNTgyNTA4MjM@._V1_SX300.jpg"},'
    '{"Title":"One Hour Photo","Year":"2002","imdbID":"tt0265459","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYWVkMjAzY2QtZTA4Yi00OWZmLTliMzctZTkyODU4NTc3MmRjL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"},'
    '{"Title":"The Lucky One","Year":"2012","imdbID":"tt1327194","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMTg5NDk3MjAzMF5BMl5BanBnXkFtZTcwMjUyNzExNw@@._V1_SX300.jpg"}'
    '],'
    '"totalResults":"9168",'
    '"Response":"True"}';
/*

//поиск фильмов/сериалов
@GET("/")
suspend fun getAllMovies(
@Query("s") search: String,
@Query("page") page: Int?,
@Query("type") type: String?,
@Query("y") year: String?,
@Query("apikey") apiKey: String = "830086",
): Response<MovieResponse>

//запрос детальной информации о фильме/сериале
@GET("/")
suspend fun getMovieDetails(
@Query("i") search: String,
@Query("apikey") apiKey: String = "830086"
):Response<DetailsData>*/
