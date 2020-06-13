-- create avocado data table 
-- save to two decimal points

DROP TABLE avocados; 

CREATE TABLE avocados(
index int NOT NULL, 
date DATE NOT NULL,
avgprice DEC (10, 2) NOT NULL,
totalvolume DEC (10, 2) NOT NULL,
PLU4046 DEC (10, 2) NOT NULL,
PLU4225 DEC (10, 2) NOT NULL,
PLU4770 DEC (10, 2) NOT NULL,
Total_Bags DEC (10, 2) NOT NULL,
Small_Bags DEC (10, 2) NOT NULL,
Large_Bags DEC (10, 2) NOT NULL,
XLarge_Bags DEC (10, 2) NOT NULL,
type VARCHAR(50) NOT NULL,
year INT NOT NULL,
region VARCHAR(50) NOT NULL,
PRIMARY KEY(index)
);

select * from avocados;
	
-- Drop regions that are larger than cities
delete from avocados
	where region in('TotalUS', 
			'California', 
			'West', 
			'SouthCentral',
			'Northeast' ,
			'Southeast',
			'GreatLakes',
			'Midsouth',
			'Plains',
			'WestTexNewMexico');

-- We're going to look at avocado prices on the most recent snapshot, recorded on March 25th 2018.
-- The <> means "does not equal to" (in other languages it would be !=)
delete from avocados
	where date <> '2018-03-25';

-- City with the lowest price for avocados on this day?
select region, avgprice from avocados
	where avgprice = (select  min(avgprice) from avocados);
	-- A: Houston at .56 cents average
	
-- or, if you want a list: 
select region, avgprice from avocados
	order by avgprice; 
	-- A: Houston, Phoenix/Tuscon (59 cents), Dallas (73 cents), then Nashville (95 cents)
	
-- City with the most avocados? 
select region, totalvolume from avocados
	where totalvolume = (select max(totalvolume) from avocados);
	-- A: Los Angeles

-- or, if you want a list: 
select region, totalvolume from avocados
	order by totalvolume desc; 
    -- A: Los Angeles, Houston, Dallas, New York, then Phoenix/Tuscon

-- City with the cheapest average *organic* avocados
select region, avgprice from avocados
	where avgprice = (select min(avgprice) from avocados where type = 'organic'); 
	-- A: Buffalo/Rochester ($1.03 per organic avocado)
select region, avgprice from avocados
	order by avgprice; 
	-- A: Buffalo/Rochester, Syracuse, Indianapolis, Columbus ($1.31/organic)

-- City with the most organic avocados
select region, totalvolume from avocados
	where totalvolume = (select max(totalvolume) from avocados where type = 'organic'); 
	-- A: New York 
	
select region, totalvolume from avocados
	order by totalvolume desc; 
	-- A: New York, Seattle, LA, Baltimore, Boston
