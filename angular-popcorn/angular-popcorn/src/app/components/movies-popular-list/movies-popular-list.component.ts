import { Component, OnInit } from '@angular/core';
import { Genre, GenreElement } from 'src/app/models/interfaces/genre.interface';
import { Movie, MoviesPopularResponse } from 'src/app/models/interfaces/movies-popular.interface';
import { AuthService } from 'src/app/services/auth.service';
import { MoviesService } from 'src/app/services/movies.service';
import { FormControl } from '@angular/forms';


@Component({
  selector: 'app-movies-popular-list',
  templateUrl: './movies-popular-list.component.html',
  styleUrls: ['./movies-popular-list.component.css']
})
export class MoviesPopularListComponent implements OnInit {
  popularMovies: Movie[] = [];
  popularMovieComplete!: Movie[];
  listgenre!: GenreElement[];
  generoId!: number[];

  constructor(private moviesService: MoviesService) { }

  ngOnInit(): void {
    this.moviesService.getPopularMovies().subscribe(popularMoviesResponse => {
      this.popularMovies = popularMoviesResponse.results;
      this.popularMovieComplete = popularMoviesResponse.results;
    });
    this.moviesService.getGenreList().subscribe(genre => {
      this.listgenre = genre.genres;
    })
  }
  filterMovies(selectGeneroId: number[]) {
    this.popularMovies= this.popularMovieComplete
    if(this.generoId.length > 0){
      let result: Movie[] = this.popularMovies.filter(filtro => filtro.genre_ids.some(f => selectGeneroId.includes(f)));
      this.popularMovies= result
    }else{
      this.moviesService.getPopularMovies();
    }
    
  }

}
