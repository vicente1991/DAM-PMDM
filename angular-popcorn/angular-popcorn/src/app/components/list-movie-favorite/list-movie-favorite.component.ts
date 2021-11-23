import { Component, Input, OnInit } from '@angular/core';
import {  Fav } from 'src/app/models/interfaces/lists.inteface';
import { ListService } from 'src/app/services/list.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-list-movie-favorite',
  templateUrl: './list-movie-favorite.component.html',
  styleUrls: ['./list-movie-favorite.component.css']
})
export class ListMovieFavoriteComponent implements OnInit {

  
  listaMovies!: Fav[];

  constructor(private listService: ListService) { }

  ngOnInit(): void {

    this.listService.getListFavoriteMovies().subscribe(popularMoviesResponse => {
      this.listaMovies = popularMoviesResponse.results;
    });
  }
  getMovieImageUrl(favorite: Fav) {
    return `${environment.imageBaseUrl}${favorite.poster_path}`;
  }

}
