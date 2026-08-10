create table appointments (DoctorName varchar(100) , PatientName varchar(100) , dateAndTime datetime, treatment varchar(100))

with treatmentcount as (select treatment as treatment1, count(treatment) as treatmentcounter from appointments group by treatment)

select top 1 treatment1, treatmentcounter from treatmentcount order by treatmentcounter desc

select dateandtime from appointments 
where PatientName= 'boris'