import { Component,Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Lista } from 'src/app/models/interfaces/lists.inteface';
import { Movie } from 'src/app/models/interfaces/movies-popular.interface';
import { AccountService } from 'src/app/services/account.service';
import { ListService } from 'src/app/services/list.service';
import { MoviesService } from 'src/app/services/movies.service';
import { Favorite } from 'src/app/models/interfaces/lists.inteface';

export interface movieDetailDialogData{
  movieId: string
}

@Component({
  selector: 'app-movielist-form',
  templateUrl: './movielist-form.component.html',
  styleUrls: ['./movielist-form.component.css']
})
export class PlaylistFormComponent implements OnInit {
  movie!: Movie;
  listaDeListas!: Lista[];
  listaId!: number;
  idioma!: string;
  desc!: string
  nombre!:string
  favorite!: Favorite


  constructor(@Inject(MAT_DIALOG_DATA) private data: movieDetailDialogData, private movieService: MoviesService,
  private accountService: AccountService, private listService: ListService) { }

  ngOnInit(): void {
    this.movieService.getMovie(this.data.movieId).subscribe(movie => {
      this.movie = movie;
    });
    this.accountService.getLists().subscribe(listas => {
      this.listaDeListas = listas.results;
    });
  }

  addMovielist(){
    this.listService.addToMovielist(this.listaId, this.movie.id).subscribe();
  }
  createMovielist(){
    this.listService.createMovielist(this.nombre,this.desc,this.idioma).subscribe(respNuevaLista => {
      this.accountService.getLists().subscribe(listas => {
        this.listaDeListas = listas.results;
        this.listaId = respNuevaLista.list_id;

      });
    });
  }
  
}
