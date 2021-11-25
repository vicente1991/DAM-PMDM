import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { SignupDto } from 'src/app/models/dto/signup.dto';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-signup-form',
  templateUrl: './signup-form.component.html',
  styleUrls: ['./signup-form.component.css']
})
export class SignupFormComponent implements OnInit {
registerDto = new SignupDto();
mandoForm = new FormGroup({
  name: new FormControl(),
  series: new FormControl('')
});
onFormSubmit(): void {
  console.log('Name:' + this.mandoForm.get);
  console.log('Series:' + this.mandoForm.get);
}
  constructor(private authService: AuthService) { }

  ngOnInit(): void {
  }
  

  register(){
    this.authService.signup(this.registerDto).subscribe(result =>{
      alert("Te registraste pibe")
    });
  }
}
