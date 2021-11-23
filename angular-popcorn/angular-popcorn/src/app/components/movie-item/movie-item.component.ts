import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { DialogLoginComponent } from 'src/app/dialogs/dialog-login/dialog-login.component';
import { PlaylistFormComponent } from 'src/app/dialogs/movielist-form/movielist-form.component';
import { Fav, Favorite } from 'src/app/models/interfaces/lists.inteface';
import { Movie } from 'src/app/models/interfaces/movies-popular.interface';
import { AuthService } from 'src/app/services/auth.service';
import { ListService } from 'src/app/services/list.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-movie-item',
  templateUrl: './movie-item.component.html',
  styleUrls: ['./movie-item.component.css']
})
export class MovieItemComponent implements OnInit {
  @Input() movieInput!: Movie;
  @Input() favInput!: Fav;

  favorite: Favorite = new Favorite();


  constructor(private dialog: MatDialog, private authService: AuthService,private listService: ListService) { }

  ngOnInit(): void {
  }

  getMovieImageUrl(movie: Movie) {
    return `${environment.imageBaseUrl}${movie.poster_path}`;
  }
  openDialogMovieDetail() {
    this.dialog.open(DialogLoginComponent, {
      height: '500px',
      width: '500px',
      data: { movieId: this.movieInput?.id }
    })
  }

  dialogForm() {
    if(this.authService.isLoggedIn()){
      this.dialog.open(PlaylistFormComponent, {
        height:"600px",
        width:"400px",
        data:{
          movieId: this.movieInput.id
        }
      }
    )
  }else{
    this.openDialogLogin();
    
  }
  }

  addFavorite(){
    this.listService.addFavorite(this.favorite).subscribe();
  }

  addFavoriteList(){
    this.favorite.media_id= this.movieInput.id;
    return this.listService.addFavorite(this.favorite).subscribe();
  }


  

 openDialogLogin(){
   this.dialog.open(DialogLoginComponent,{
     width: "250px",
     height: "250px"
   })
 }
}
