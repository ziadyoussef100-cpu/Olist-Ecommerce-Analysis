use ITI
--DQL(Select-Where)
--select all data in table 
select *from Student
--select specific rows
select *from Student
where St_Address='cairo'
--select specific columns
select st_fname,st_lname
from Student
--sort by another column
select * from student 
order by st_age
--sort by tow columns 
select * from Student
order by Dept_Id desc,St_Age asc
--select student dept_id = null
select * from student 
where Dept_Id is not null 
--display Dept_id --remove duplicate -- order asc
select  distinct Dept_Id
from Student
where Dept_Id is not null
--select student age 23->25
select *from Student 
where St_Age >=23 and St_Age <=25 
--onother way
select *from Student 
where St_Age between 23 and 25 
select *from Student 
where St_Address in ('cairo','tanta','mansoura')
select st_fname+' '+st_lname as [full name]
from student
select st_fname 
from Student 
where St_Fname like 'a%'
