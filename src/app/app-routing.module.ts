import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { AppointmentComponent } from './components/appointment/appointment.component';
import { AboutComponent } from './components/about/about.component';
import { LocationComponent } from './components/location/location.component';
import { LoginComponent } from './components/login/login.component';
import { MyAppointmentsComponent } from './components/my-appointments/my-appointments.component';

const routes: Routes = [
  {path: '', component: HomeComponent},
  {path: 'appointment', component: AppointmentComponent},
  {path: 'about', component: AboutComponent},
  {path: 'location', component: LocationComponent},
  {path: 'login', component: LoginComponent},
  {path: 'my-appointment', component: MyAppointmentsComponent},


];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
