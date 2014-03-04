"use strict"

$ ->

  $("form").on "submit", (event) ->
    event.preventDefault()
    searchTerm = $("input").val()

    movieData = $.ajax
      url: "http://www.omdbapi.com/"
      method: "get"
      data: { s: searchTerm }
      dataType: "json"

    movieData.done (data) ->
      $("input").val("")
      $(".master").html("")

      for movie in data["Search"]
        console.log movie.Title
        li = $ "<li> <a data-imdb=#{movie.imdbID} href='#'>#{movie.Title}</a> </li>"
        $(".master").append(li)

      $("a").on "click", (event) ->
        event.preventDefault()
        imdbID = $(event.target).data("imdb")

        movieDetail = $.ajax
          url: "http://www.omdbapi.com/"
          method: "get"
          data: { i: imdbID, tomatoes: true, plot: "full" }
          dataType: "json"

        movieDetail.done (data) ->
          console.log data

          movieTitle = $ "<h1>#{data.Title}</h1> <h2>#{data.Year}</h2>"
          $("#title").html(movieTitle)

          moviePoster = $ "<img src='#{data.Poster}'>"
          $("#poster").html(moviePoster)

          movieRating = $ "<span class='meter'>Metascore:</span> <span class='score'>#{data.Metascore}</span> <span class='meter'>Tomato Meter:</span> <span class='score'>#{data.tomatoMeter}</span>"
          $("#rating").html(movieRating)

          movieSynopsis = $ "<p>#{data.Plot}</p>"
          $("#synopsis").html(movieSynopsis)


