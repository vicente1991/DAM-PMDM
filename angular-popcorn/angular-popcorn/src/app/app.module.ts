import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClientModule } from '@angular/common/http';
import { MaterialImportsModule } from './modules/material-imports.module';
import { MoviesPopularListComponent } from './components/movies-popular-list/movies-popular-list.component';
import { MovieItemComponent } from './components/movie-item/movie-item.component';
import { FlexLayoutModule } from '@angular/flex-layout';
import { NgCircleProgressModule } from 'ng-circle-progress';
import { SessionComponent } from './shared/session/session.component';
import { PlaylistFormComponent } from './dialogs/movielist-form/movielist-form.component';
import { FormsModule } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import { ListMovieFavoriteComponent } from './components/list-movie-favorite/list-movie-favorite.component';

@NgModule({
  declarations: [
    AppComponent,
    MoviesPopularListComponent,
    MovieItemComponent,
    SessionComponent,
    PlaylistFormComponent,
    ListMovieFavoriteComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialImportsModule,
    HttpClientModule,
    ReactiveFormsModule,
    FormsModule,
    FlexLayoutModule,
    NgCircleProgressModule.forRoot({
      "radius": 25,
      "outerStrokeGradient": true,
      "outerStrokeWidth": 5,
      "outerStrokeGradientStopColor": "red",
      "innerStrokeWidth": 0,
      "titleColor": "#FFFFFF",
      "titleFontSize": "15",
      "titleFontWeight": "bold",
      "showSubtitle": false,
      "animateTitle": true,
      "animationDuration": 1000,
      "showUnits": false,
      "showBackground": true,
      "backgroundColor": "#000000"
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
