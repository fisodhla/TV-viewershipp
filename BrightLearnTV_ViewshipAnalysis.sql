

use Brightlearn

select 
	p.USERID,
	age,
	case 
		when isnull(gender,'') in ('None','') then 'UNKNOWN'
		ELSE Gender END AS Gender,
	CASE 
		WHEN ISNULL(Province,'') in ('','None') then 'Unknown'
		else Province end as Province,
	case 
		when isnull(Race,'') in ('','None', 'Other') then 'Unknown'
		else Race end as Race,
	--v.*,
	channel2,
	convert(datetime,recordDate2) as RecordDate,
	convert(date,recordDate2) as WatchDate,
	MONTH(recordDate2) as Month_ID,
	left(DATENAME(MONTH,recordDate2),3) AS Month_Name,
	left(datename (dw,recordDate2),3) as Day,	
	datename(week,recordDate2) as Week_ID,
	case 
		when left(datename (dw,recordDate2),3) in ('Sat','Sun') Then 'Weekend'
		else 'Weekday' end as Day_Classification,
	convert (varchar(8),convert(time,recordDate2)) as WatchTime,
	case
		when convert (varchar(8),convert(time,recordDate2)) between '06:00:00' and '11:59:59' then 'Morning'
		when convert (varchar(8),convert(time,recordDate2)) between '12:00:00' and '17:59:59' then 'Afternoon'
		when convert (varchar(8),convert(time,recordDate2)) between '18:00:00' and '20:59:59' then 'Evening'
		when convert (varchar(8),convert(time,recordDate2)) between '21:00:00' and '23:59:59' then 'Night'
		when convert (varchar(8),convert(time,recordDate2)) between '00:00:00' and '05:59:59' then 'Mid-Night'
	else convert (varchar(8),convert(time,recordDate2)) end as Categorical_Times,
	[Duration 2] as Duration
into BrightViewershipAnalysis
from Profiles p inner join [dbo].[Viewership] v
on p.USERID = v.USERID
