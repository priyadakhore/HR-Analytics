create database HRanalysis;
use HRanalysis;
select * from hr1;
select * from hr2;

  ## Total Employee ##
 create view Total_employee as
select count(*) total_employee from hr1;
select * from Total_employee;

  ## Gender Count ##
create view gender as
select gender, count(gender) Coutn_gender from hr1
group by gender;

select * from gender;

 ##Current Employee ##
 
 create view `current employee` as 
 Select count(attrition) current_employee from hr1 where attrition = 'No';

select * from `current employee`;

##  Attrition Employee ## 
create view Attrition AS
SELECT count(attrition) Ex_Employee from hr1 where attrition = 'Yes';

select * from Attrition;

               ### KPI ### 
## AVG ATTRITION RATE PER DEPARTMENT ## 

select * from hr1;
select Department,count(attrition) `Number of Attrition`from hr1
where attrition = 'yes'
group by Department;

create view Dept_average as
select department, round(count(attrition)/(select count(employeenumber) from hr1)*100,2)  as attrtion_rate
from hr1
where attrition = "yes"
group by department;
select * from dept_average;


     ## AVG HOURLY RATE OF MALE RESEARCH SCIENTIST ##
 Average Hourly rate of Male Research Scientist


DELIMITER //
create procedure emp_role (in input_gender varchar(20), in input_jobrole varchar(30))
begin
 select Gender, round(avg(HourlyRate),2) `Avg Hourly Rate` from hr1
 where gender = input_gender and jobrole = input_jobrole
 group by gender;
end //
DELIMITER ;

call emp_role('male',"Research Scientist");


      ## ATTRITION RATE VS MONTHLY INCOME STAT ##
      
select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber) from hr1 h1)*100,2) `Attrtion rate`,
round(avg(h2.MonthlyIncome),2) average_incom from hr1 h1 join hr2 h2
on h1.EmployeeNumber = h2.`employee id`
where attrition = 'Yes'
group by h1.department;

create view Attrition_employeeincome as
select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber) from hr1 h1)*100,2) `Attrtion rate`,
round(avg(h2.MonthlyIncome),2) average_income from hr1 h1 join hr2 h2
on h1.EmployeeNumber = h2.`employee id`
where attrition = 'Yes'
group by h1.department;

select * from attrition_employeeincome;

   ## DEPARTMENT WISE AVG WORKING YEARS ## 
   
select h1.department,Round(avg(h2.totalworkingyears),0) from hr1 h1
join hr2 h2 on h1.employeenumber = h2.`Employee ID`
group by h1.department;

Create view `Work Age` as 
select h1.department,Round(avg(h2.totalworkingyears),0) from hr1 h1
join hr2 h2 on h1.employeenumber = h2.`Employee ID`
group by h1.department;

select * from `Work age`;


     ##JOB ROLE VS WORK LIFE BALANCE ##
select * from hr2;

select h1.jobrole,h2.worklifebalance, count(h2.worklifebalance) Employee_count
from hr1 h1 join hr2 h2
on h1.employeenumber = h2.`Employee ID`
group by h1.jobrole,h2.worklifebalance
order by h1.jobrole;

DELIMITER //
Create procedure Get_Count (in job_role varchar(30),in Work_balance varchar(30),out Ecount int)
begin
select count(h2.worklifebalance)  Employee_count into ecount
from hr1 h1 join hr2 h2
on h1.employeenumber = h2.`Employee ID`
where h1.jobrole = job_role and h2.worklifebalance = Work_balance
group by job_role,work_balance;
end //
DELIMITER ;

 call get_count('developer','Good',Ecount);
 select @Ecount;
..........................................
    ## ATTRITION RATE VS YEAR SINCE LAST PROMOTION ## 


select * from  hr2;

select h2.`YearsSinceLastPromotion`,count(h1.attrition)  attrition_count
from hr1 h1 join hr2 h2 on h1.employeenumber = h2.`employee id`
where h1.attrition = 'Yes'
group by `YearsSinceLastPromotion`
order by `YearsSinceLastPromotion`;
    


