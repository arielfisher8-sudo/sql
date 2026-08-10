create table flights (flightID int, routename varchar(100), noOfBookings int , availableSeats int,price float)
create table bookings (flightID int, name varchar(20), )

create procedure CreateBooking 
@flightID int,
@name varchar(100)
as
begin
if flights.availableseats>0
begin
insert into bookings (flightID,name)
values (@flightID,@name)


update flights set noOfBookings= noOfBookings+1 , availableseats = availableseats -1
end
else begin
throw 51000, 'No more seats',1;
end

with popularRoutes as (
select flights.routename as rn, sum(flights.noOfBookings) as noOfBookingsbyDest,
rank() over (partition by flights.routename order by noOfbookingsbydest desc) as rnk 
group by flights.routename
)
select top 1 rnk from popularRoutes order by rnk desc

insert into flights (flightID,routename,noOfBookings) values
(1,'tlv-prg', 100),(2,'tlv-prg',200),(3,'tlv-atn',100)

select flightID, price * noOfBookings from flights