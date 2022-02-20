Create Database `TravelOnTheGo`;
use `TravelOnTheGo`;

CREATE TABLE `travelonthego`.`passenger` (
  `Passenger_name` VARCHAR(50) NOT NULL,
  `Category` VARCHAR(10) NULL,
  `Gender` VARCHAR(10) NULL,
  `Boarding_City` VARCHAR(50) NULL,
  `Destination_City` VARCHAR(50) NULL,
  `Distance` INT NOT NULL,
  `Bus_Type` VARCHAR(20) NULL);
     
  -- data inserted by uploading .csv files.Right click on table, then table data import wizard. File Name Passengerv1.
  
CREATE TABLE `travelonthego`.`price` (
  `Bus_Type` VARCHAR(20) NULL,
  `Distance` INT NOT NULL,
  `price` INT NOT NULL);
  
  -- data inserted by uploading .csv files.Right click on table, then table data import wizard.File Name Price.
  
 --  3) How many females and how many male passengers travelled for a minimum distance of 600 KMs?
select passenger.gender, count(passenger.gender) as count
from passenger
where passenger.distance>=600
group by passenger.gender;

-- 4) Find the minimum ticket price for Sleeper Bus.
select price.bus_type, min(price.price) as 'min.price' from price
where Bus_type='Sleeper'
group by price.bus_type;

-- 5) Select passenger names whose names start with character 'S'
select passenger_name as 'names with S' from passenger 
where  ( passenger_name like 'S%');

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output
 
 select passenger.passenger_name,passenger.boarding_city, passenger.destination_city,passenger.bus_type,price.price
 from passenger
inner join price
on passenger.distance = price.distance
where passenger.bus_type = price.bus_type
 group by passenger.passenger_name;
 
-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
-- for a distance of 1000 KM s
select passenger.passenger_name, price.price from passenger
inner join price
on passenger.distance = price.distance
where passenger.distance = "1000"
and passenger.bus_type = "sitting";

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
-- panaji?
select passenger.bus_type,price.price
from passenger 
inner join price
on passenger.bus_type = price.bus_type
where price.distance ="600"
group by passenger.bus_type;

-- 9) List the distances from the "Passenger" table which are unique (non-repeated
-- distances) in descending order.

select distinct passenger.distance from passenger
order by passenger.distance desc;


-- 10) Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables

 select passenger.passenger_name,
 passenger.distance * 100 / (select sum(passenger.distance) from passenger) as "% of distance"
 from passenger;

/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

select price.distance,price.price,
case
when price > 1000 then "Expensive"
when price > 500 then "Average"
else "Cheap"
end as verdict
from price
group by price
order by price.distance desc;

/**/

 
