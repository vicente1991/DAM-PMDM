import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Account } from '../models/interfaces/lists.inteface';

@Injectable({
  providedIn: 'root'
})
export class AccountService {

  constructor(private http: HttpClient) { }

  getLists(): Observable<Account>{
    return this.http.get<Account>(`${environment.apiBaseUrl}/account/null/lists?api_key=${environment.apiKey}&language=${environment.defaultLang}&page=1&session_id=${localStorage.getItem('session_id')}`)
  }
}
