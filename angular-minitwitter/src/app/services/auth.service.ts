import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SignupDto } from '../models/dto/signup.dto';
import { Signup } from '../models/interfaces/signup.interface';

const AUTH_BASE_URL = 'auth';
const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  authBaseUrl = `${environment.apiBaseUrl}/${AUTH_BASE_URL}`;

  constructor(private http: HttpClient) { }



  signup(loginDto: SignupDto ): Observable<Signup> {
    let requestUrl = `${this.authBaseUrl}/signup`;
    return this.http.post<Signup>(requestUrl, loginDto, DEFAULT_HEADERS);
  }

  forgot() {
    let requestUrl = `${this.authBaseUrl}/forgot`;    
  }
}
