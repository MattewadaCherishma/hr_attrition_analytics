CREATE DATABASE hr_analytics;
use hr_analytics;

select * from hr_analytics.employees limit 10;
select count(*) from hr_analytics.employees;

# Attrition rate
select 
	count(*) as total_employees,
    sum(case when Attrition ='Yes' Then 1 else 0 end) as employees_left,
    round(100.0 * sum(case when Attrition ='Yes' Then 1 else 0 end)/count(*),1) as attrition_rate_pct 
from hr_analytics.employees;

# Attrition by department
select 
	Department,
    count(*) as headcount,
    round(100.0*sum(case when Attrition ='Yes' then 1 else 0 end)/count(*),1) as attrition_rate_pct
from hr_analytics.employees
group by Department
order by attrition_rate_pct Desc;

#Attrition by overTime
select
	OverTime,
    count(*) as headcount,
    round(100.0*sum(case when attrition = 'Yes' then 1 else 0 end)/count(*),1) as attrition_rate_pct
from hr_analytics.employees
group by OverTime;

#Attrition by tenure bucket
select 
	case 
		when YearsAtCompany <=1 then '0-1 yrs'
		when YearsAtCompany <=3 then '2-3 yrs'
		when YearsAtCompany <=6 then '4-6 yrs'
		else '7+ yrs'
	end as tenure_bucket,
    count(*) as headcount,
    round(100.0* sum(case when Attrition ='Yes' then 1 else 0 end)/count(*),1) as attrition_rate_pct
from hr_analytics.employees
group by tenure_bucket
order by min(YearsAtCompany);
