export class SignupDto {
    username: string;
    email:    string;
    password: string;
    code:     string;

        constructor(){
            this.username='';
            this.email='';
            this.password='';
            this.code='UDEMYANDROID'
        }
}