use [heath.proj]

-- check what is the linking column of the two tables
select * from Absenteeism_at_work
select * from compensation
select * from Reasons

-- the goal is to create a join table
-- we want the main table so left join
select * 
from Absenteeism_at_work a left join compensation c
on a.ID = c.ID
left join Reasons r
on a.Reason_for_absence = r.Number;


-- find the healthiest for the bonus
-- those who don't smoke and drink
select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0 
and Body_mass_index < 25 
and Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from Absenteeism_at_work);


-- compensation rate increase for non-smokers
-- hr amount is 983221 dollars
-- 5x8x52x686 = 1426880
-- 983221/1426880 = .68 increase per hour
-- 5x8x52 x .68 = 1414.4 per year for nonsmoker
select count(*) as nonsmokers from Absenteeism_at_work
where Social_smoker = 0;


-- optimize this query
-- in this part, we want to retrieve what column we need in PowerBI
select 
a.ID, r.Reason, Month_of_absence, Body_mass_index, Age, Disciplinary_failure,
case when Body_mass_index < 18.5 then 'Underweight'
	 when Body_mass_index between 18.5 and 25 then 'Healthy'
	 when Body_mass_index between 25 and 30  then 'Overweight'
	 when Body_mass_index > 30 then 'Obese'
	 else 'Unknown'
	 end as BMI_Category,
case when Month_of_absence in (12,1,2) then 'Underweight'
	 when Month_of_absence in (3,4,5) then 'Spring'
	 when Month_of_absence in (6,7,8) then 'Summer'
	 when Month_of_absence in (9,10,11) then 'Fall'
	 else 'Unknown' 
	 end as Season_Names,
Seasons, Day_of_the_week, Transportation_expense, 
Education, Son, Social_drinker, Social_smoker, Pet, Work_load_Average_day, 
Absenteeism_time_in_hours
from Absenteeism_at_work a left join compensation c
on a.ID = c.ID
left join Reasons r
on a.Reason_for_absence = r.Number;


--