/* The script was written to understand the economical potentialities of a region in India

1.Present economic situtation in the area , 

2.The amount of investments required, as per new developmentplan zoning, to create economical homogenity and 

3.Amount of revenue that the municipalities would recieve as tax due to increase in Land value

4. Amount of economical activity potential as a fucntion of disposiablel income avaliable with the people

Skills used : Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views

 */


-- duplicating data 

create table dupe_economy as (select * from economy_data);

-- truncate data

truncate dupe_economy;

-- Insert data 
insert into dupe_economy ((areaid, jobs_total, jobs_pri,Jobs_sec , Jobs_teri)) values ('11001', '18462', '6523','5486', '6453');


-- Viewing both the data sets whose primary key is area_id 

Select * from economy_data;

select * from landuse_data;

--Performing INNER JOIN to both the tables to create a comprehensive join.

create table landuse_with_economydata as 
        select * from economy_data inner join Landuse_data using (area_id);

select * from landuse_with_economydata ;

--Creating columns and Calculating population desnity, Job ratio , Average revuenue per job  , Revenue density of different sectors in municipality 
 
-- Coalesce and Nullif used to remove division by zero error.

alter table landuse_with_economydata 
        add pop_density numeric(19,2),               -- population desnity
        add unemplyment numeric(19,2),               -- Total unemployment 
        add umem_perc numeric(19,2),                 -- Umployment percentage
        add cu_jobratio numeric(19,2),               -- total employment ratio
        add column pr_jobratio numeric(19,2),        -- primary sector job reatio in total economy
        add column se_jobratio numeric(19,2),        -- secondary sector job reatio in total economy
        add column te_jobratio numeric(19,2),        -- teritary sector job reatio in total economy
        add column pr_revenue numeric(19,2),         -- Average revenue for primary sector 
        add column se_revenue numeric(19,2),         -- Average revenue for secondary sector 
        add column te_revenue numeric(19,2),         -- Average revenue for teritary sector 
        add column pr_rdensity numeric(19,2),        -- Primary sector revenue desnity (similar to sales density) 
        add column se_rdensity numeric(19,2),        -- Secondary sector revenue desnity (similar to sales density) 
        add column te_rdensity numeric(19,2);        -- Teritary sector revenue desnity (similar to sales density) 
        
       
update landuse_with_economydata SET pop_density = coalesce ( nullif ((pop/area),0),0);

update landuse_with_economydata SET unemplyment = totpop - (jobs_total) ;

update landuse_with_economydata SET unem_perc = (unemplyment / totpop) * 100;

update landuse_with_economydata SET cu_jobratio = 100 - unem_perc ;

update landuse_with_economydata SET pr_jobratio = coalesce (nullif (((primary_em/ pop),0),0);

update landuse_with_economydata SET se_jobratio = coalesce (nullif (((secondary_em  / pop),0),0);

update landuse_with_economydata SET te_jobratio = coalesce (nullif ((teritary_emp / pop),0),0);


-- Using Temp Table to perform Calculation on Partition By in previous query

CREATE TEMPORARY TABLE employ_stats (
        pop_density numeric(19,2),        -- population desnity
        unemplyment numeric(19,2),        -- Total unemployment 
        umem_perc numeric(19,2),          -- Umployment percentage
        cu_jobratio numeric(19,2),        -- total employment ratio

);


-- Using CTE to perform Economic sector calculations 

With economy_data1 as (
        pr_jobratio  , column se_jobratio, 
        column te_jobratio,column pr_revenue,
        column se_revenue,column te_revenue,
        column pr_rdensity,column se_rdensity, 
        column te_rdensity 
);
select * from economy_data1;


-- Creating View to store data for later visualizations

CREATE view TEMPORARY TABLE employ_stats (
        area name varchar(50),            -- population desnity
        unemplyment numeric(19,2),        -- Total unemployment 
        umem_perc numeric(19,2),          -- Umployment percentage
        cu_jobratio numeric(19,2),        -- total employment ratio

);


