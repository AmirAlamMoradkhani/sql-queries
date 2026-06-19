select student.name
 from instructor,student,advisor
  Where student.ID=s_ID
    and instructor.id=i_ID
    and instructor.name='Bawa';
----------------------------------------------
select dept_name
   from department
   where budget> (select AVG (budget)
                     from department);

update department
set budget =0.85 * budget
 WHERE  budget> (select AVG(budget)
	                   from department)
       and building  <> Saucon;
	     
-----------------------------------------------
select  distinct instructor.name, instructor.ID
 from instructor, teaches ,course 
   where teaches.course_id=.course.course_id
     and teaches.id=instructor.id
	 and course.credits=3;
 ----------------------------------------------------
 with numberofstudent(number_ofstudent,instructor) as 
 (select  count (takes.id), teaches.id
    from   teaches , takes
      where   teaches. course_id= takes.course_id
	    and   teaches.sec_id= takes.sec_id
	    AND  TAKES.year=teaches.year
		and  takes.semester=teaches.semester
          group by  teaches.id )

select  instructor.name, number_ofstudent
 from   numberofstudent , instructor 
 where  numberofstudent.instructor=instructor .id
    and numberofstudent.number_ofstudent=(select max(number_ofstudent)
	                                         from numberofstudent );
 ------------------------------------------------------
select distinct( c.course_id )
    from course as c,department as d
	where d.dept_name ='Taylor'
	   and c.dept_name=d.dept_name
	  and  c.credits=4;
----------------------------------------------------
select count(distinct s.id) 
    from takes  as t,student  as s
	where   t. YEAR=2006
	  and t.semester='spring';
--------------------------------------------
select  min (grade) as min_grade ,max  (grade) as max_grade
    from takes
	where  id=10267 ;
--------------------------------------------
with instructorcount( count , dept_name) as
  ( select count( id), dept_name
      from instructor
	  group by dept_name)

 select dept_name                     
 from  instructorcount
     where count <(select  AVG (count)
                     FROM   instructorcount);
---------------------------------------------
with avgsalary ( avg  , dept_name)  as
    (select  AVG(salary) ,I.dept_name
	 from  instructor as I ,department  as D
	   where  I.dept_name= D.dept_name
	    group by I.dept_name)


 select dept_name 
  from avgsalary
    where avg  < ( select   AVG (salary)
	                          from instructor,department
		                      where department.dept_name=instructor.dept_name
		                         and   department.dept_name='Athletics');
-----------------------------------------------------


select  student.name
from    student
left join    takes  
on student.id= takes.id
left join  course 
on  takes.course_id=course.course_id and course.dept_name='physics'
 group by student.id ,student.name
 having  count (takes.course_id)<=1;

---------------------------------------
 with  maxsalary as
      (select  max (salary)as max_salary, dept_name
	      from instructor as i
           GROUP BY dept_name )

 SELECT  instructor.name, max_salary
    from  instructor join maxsalary
	   on instructor.dept_name=maxsalary.dept_name
	     and max_salary = instructor.salary;
	    


------------------------------------
 INSERT INTO course (course_id , title, dept_name, credits)
     values (13,'physics2','physic',4);
 
insert into section (course_id,sec_id,semester,year)
values(13,'1','Fall',2009) 
insert into section (course_id,sec_id,semester,year)
  values(13,'2','Fall',2009);



