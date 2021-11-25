import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { RequestTokenResponse, SessionResponse } from '../models/interfaces/auth.interface';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }

  getSessionId() {
    return localStorage.getItem('session_id');
  }

  isLoggedIn(): boolean {
    return localStorage.getItem('session_id') != null;
  }

  setSessionId(sessionId: string) {
    localStorage.setItem('session_id', sessionId);
  }
  setLocalSessionId(sessionId: string) {
    localStorage.setItem('session_id', sessionId);
  }
  setLocalRequestToken(token: string) {
    localStorage.setItem('request_token', token);
  }

  getLocalRequestToken() {
    return localStorage.getItem('request_token');
  }

  getResponseToken(): Observable<RequestTokenResponse> {
    return this.http.get<RequestTokenResponse>(`${environment.apiBaseUrl}/authentication/token/new?api_key=${environment.apiKey}`);
  }

  getSessionId2(): Observable<SessionResponse> {
    return this.http.post<SessionResponse>(`https://api.themoviedb.org/3/authentication/session/new?api_key=${environment.apiKey}`, { request_token: this.getLocalRequestToken()});
}
}
