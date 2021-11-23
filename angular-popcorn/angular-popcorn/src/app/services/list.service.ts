import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { CreateListResponse, ListResponse } from '../models/interfaces/auth.interface';
import { Fav, Favorite, FavoriteResponse } from '../models/interfaces/lists.inteface';

const movieUrl = `${environment.apiBaseUrl}/movie`;

@Injectable({
  providedIn: 'root'
})
export class ListService {

  constructor(private http: HttpClient) { }

  getListFavoriteMovies(): Observable<FavoriteResponse> {
    return this.http.get<FavoriteResponse>(`${environment.apiBaseUrl}/account/{account_id}/favorite/movies?api_key=${environment.apiKey}&language=${environment.defaultLang}&sort_by=created_at.asc&page=1&session_id=${localStorage.getItem('session_id')}`);
  }

  addToMovielist(idList: number, idMovie: number): Observable<ListResponse>{
    return this.http.post<ListResponse>(`${environment.apiBaseUrl}/list/${idList}/add_item?api_key=${environment.apiKey}&session_id=${localStorage.getItem('session_id')}`,
     { media_id : idMovie})
  }
  createMovielist(name: string, description: string , language: string): Observable<CreateListResponse>{
    return this.http.post<CreateListResponse>(`${environment.apiBaseUrl}/list?api_key=${environment.apiKey}&session_id=${localStorage.getItem('session_id')}`,
     { name: name,
     description: description,
     language: language})

  }
  addFavorite(favorite: Favorite): Observable<Favorite>{
    return this.http.post<Favorite>(`${environment.apiBaseUrl}/account/null/favorite?api_key=${environment.apiKey}&language=${environment.defaultLang}&page=1&session_id=${localStorage.getItem('session_id')}`, favorite)
  }


}
