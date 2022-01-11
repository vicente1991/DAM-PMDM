import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { PlaylistFormComponent } from 'angular-popcorn/src/app/dialogs/movielist-form/movielist-form.component';
import { DialogLoginComponent } from 'src/app/dialogs/dialog-login/dialog-login.component';
import { Movie } from 'src/app/models/interfaces/movies-popular.interface';
import { AuthService } from 'src/app/services/auth.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-movie-item',
  templateUrl: './movie-item.component.html',
  styleUrls: ['./movie-item.component.css']
})
export class MovieItemComponent implements OnInit {
  @Input() movieInput!: Movie;

  constructor(private dialog: MatDialog, private authService: AuthService) { }

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

  addFavorite() {
    if(this.authService.isLoggedIn()) {
      this.dialogFavorite();
    }else {
      this.openDialogMovieDetail();
    }
  }

  dialogFavorite() {
  
 }

 openDialogLogin(){
   this.dialog.open(DialogLoginComponent,{
     width: "250px",
     height: "250px"
   })
 }
}
