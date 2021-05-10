--MUDANO WORLDBANK EXERCISE

-- Q1. List countries with income level of "Upper middle income"
SELECT name AS upper_middle_income_countries FROM countries
WHERE "incomeLevel_value" = 'Upper middle income';

-- Q2. List countries with income level of "Low income" per region
SELECT "region_value" AS Region, name AS low_income_countries FROM countries
WHERE "incomeLevel_value" = 'Low income'
ORDER BY "region", "low_income_countries";

-- Q3. Find the region with the highest proportion of "High income" countries.
with t1 AS
   (SELECT "region_value" AS region, "incomeLevel_value", COUNT("incomeLevel_value") AS count_income  FROM countries
	WHERE "region_value" != 'Aggregates'
	GROUP BY "region_value", "incomeLevel_value"),
t2 AS
	(SELECT region, "incomeLevel_value",  100*"count_income"/ SUM("count_income") OVER(PARTITION BY region) AS Percentage
	FROM t1),
t3 AS
	(SELECT *
	 FROM t2
	 WHERE "incomeLevel_value" = 'High income'
	 ORDER BY Percentage DESC
	 LIMIT 1
	)

SELECT region AS "highest_proportion_high_income_countries"
FROM t3
;


-- Q4. Calculate cumulative/running value of GDP per region ordered by income from
-- lowest to highest and country name.
with t4 as

	(SELECT *
	FROM gdp
	LEFT JOIN countries
	ON gdp.country_code = countries.country_code),
t5 AS
	(SELECT country_name, region_value, "incomeLevel_value", COALESCE("1960", 0) +
	 COALESCE("1961", 0) + COALESCE("1962", 0) + COALESCE("1963", 0) +
	 COALESCE("1964", 0) + COALESCE("1965", 0) + COALESCE("1966", 0) +
	 COALESCE("1967", 0) + COALESCE("1968", 0) + COALESCE("1969", 0) +
	 COALESCE("1970", 0) + COALESCE("1971", 0) + COALESCE("1972", 0) +
	 COALESCE("1973", 0) + COALESCE("1974", 0) + COALESCE("1975", 0) +
	 COALESCE("1976", 0) + COALESCE("1977", 0) + COALESCE("1978", 0) +
	 COALESCE("1979", 0) + COALESCE("1980", 0) + COALESCE("1981", 0) +
	 COALESCE("1982", 0) + COALESCE("1983", 0) + COALESCE("1984", 0) +
	 COALESCE("1985", 0) + COALESCE("1986", 0) + COALESCE("1987", 0) +
	 COALESCE("1988", 0) + COALESCE("1989", 0) + COALESCE("1990", 0) +
	 COALESCE("1991", 0) + COALESCE("1992", 0) + COALESCE("1993", 0) +
	 COALESCE("1994", 0) + COALESCE("1995", 0) + COALESCE("1996", 0) +
	 COALESCE("1997", 0) + COALESCE("1998", 0) + COALESCE("1999", 0) +
	 COALESCE("2000", 0) + COALESCE("2001", 0) + COALESCE("2002", 0) +
	 COALESCE("2003", 0) + COALESCE("2004", 0) + COALESCE("2005", 0) +
	 COALESCE("2006", 0) + COALESCE("2007", 0) + COALESCE("2008", 0) +
	 COALESCE("2009", 0) + COALESCE("2010", 0) + COALESCE("2011", 0) +
	 COALESCE("2012", 0) + COALESCE("2013", 0) + COALESCE("2014", 0) +
	 COALESCE("2015", 0) + COALESCE("2016", 0) + COALESCE("2017", 0) +
	 COALESCE("2018", 0) + COALESCE("2019", 0) AS total
	 FROM t4),
t6 AS
	(SELECT * FROM t5
	 WHERE "incomeLevel_value" != 'Aggregates'
	)
SELECT "region_value" AS region, ROUND(CAST(SUM(total) AS numeric), 2) AS "cummGDP($bn)" FROM t6
GROUP BY "region"
ORDER BY "cummGDP($bn)" ASC, region ASC
;

-- Q5. Calculate percentage difference in value of GDP year-on-year per country
with t12 AS

	(SELECT *
	FROM gdp
	LEFT JOIN countries
	ON gdp.country_code = countries.country_code),
t13 AS
	(SELECT * FROM t12
	 WHERE "incomeLevel_value" != 'Aggregates'
	),
t14 AS
	(SELECT country_name AS country, round(CAST(100 * (("1961" - "1960")/ "1960") AS numeric), 2) AS "1960_1961_pct_change",
	 round(CAST(100 * (("1962" - "1961")/ "1961") AS numeric), 2) AS "1961_1962_pct_change",
	 round(CAST(100 * (("1963" - "1962")/ "1962") AS numeric), 2) AS "1962_1963_pct_change",
	 round(CAST(100 * (("1964" - "1963")/ "1963") AS numeric), 2) AS "1963_1964_pct_change",
	 round(CAST(100 * (("1965" - "1964")/ "1964") AS numeric), 2) AS "1964_1965_pct_change",
	 round(CAST(100 * (("1966" - "1965")/ "1965") AS numeric), 2) AS "1965_1966_pct_change",
	 round(CAST(100 * (("1967" - "1966")/ "1966") AS numeric), 2) AS "1966_1967_pct_change",
	 round(CAST(100 * (("1968" - "1967")/ "1967") AS numeric), 2) AS "1967_1968_pct_change",
	 round(CAST(100 * (("1969" - "1968")/ "1968") AS numeric), 2) AS "1968_1969_pct_change",
	 round(CAST(100 * (("1970" - "1969")/ "1969") AS numeric), 2) AS "1969_1970_pct_change",
	 round(CAST(100 * (("1971" - "1970")/ "1970") AS numeric), 2) AS "1970_1971_pct_change",
	 round(CAST(100 * (("1972" - "1971")/ "1971") AS numeric), 2) AS "1971_1972_pct_change",
	 round(CAST(100 * (("1973" - "1972")/ "1972") AS numeric), 2) AS "1972_1973_pct_change",
	 round(CAST(100 * (("1974" - "1973")/ "1973") AS numeric), 2) AS "1973_1974_pct_change",
	 round(CAST(100 * (("1975" - "1974")/ "1974") AS numeric), 2) AS "1974_1975_pct_change",
	 round(CAST(100 * (("1976" - "1975")/ "1975") AS numeric), 2) AS "1975_1976_pct_change",
	 round(CAST(100 * (("1977" - "1976")/ "1976") AS numeric), 2) AS "1976_1977_pct_change",
	 round(CAST(100 * (("1978" - "1977")/ "1977") AS numeric), 2) AS "1977_1978_pct_change",
	 round(CAST(100 * (("1979" - "1978")/ "1978") AS numeric), 2) AS "1978_1979_pct_change",
	 round(CAST(100 * (("1980" - "1979")/ "1979") AS numeric), 2) AS "1979_1980_pct_change",
	 round(CAST(100 * (("1981" - "1980")/ "1980") AS numeric), 2) AS "1980_1981_pct_change",
	 round(CAST(100 * (("1982" - "1981")/ "1981") AS numeric), 2) AS "1981_1982_pct_change",
	 round(CAST(100 * (("1983" - "1982")/ "1982") AS numeric), 2) AS "1982_1983_pct_change",
	 round(CAST(100 * (("1984" - "1983")/ "1983") AS numeric), 2) AS "1983_1984_pct_change",
	 round(CAST(100 * (("1985" - "1984")/ "1984") AS numeric), 2) AS "1984_1985_pct_change",
	 round(CAST(100 * (("1986" - "1985")/ "1985") AS numeric), 2) AS "1985_1986_pct_change",
	 round(CAST(100 * (("1987" - "1986")/ "1986") AS numeric), 2) AS "1986_1987_pct_change",
	 round(CAST(100 * (("1988" - "1987")/ "1987") AS numeric), 2) AS "1987_1988_pct_change",
	 round(CAST(100 * (("1989" - "1988")/ "1988") AS numeric), 2) AS "1988_1989_pct_change",
	 round(CAST(100 * (("1990" - "1989")/ "1989") AS numeric), 2) AS "1989_1990_pct_change",
	 round(CAST(100 * (("1991" - "1990")/ "1990") AS numeric), 2) AS "1990_1991_pct_change",
	 round(CAST(100 * (("1992" - "1991")/ "1991") AS numeric), 2) AS "1991_1992_pct_change",
	 round(CAST(100 * (("1993" - "1992")/ "1992") AS numeric), 2) AS "1992_1993_pct_change",
	 round(CAST(100 * (("1994" - "1993")/ "1993") AS numeric), 2) AS "1993_1994_pct_change",
	 round(CAST(100 * (("1995" - "1994")/ "1994") AS numeric), 2) AS "1994_1995_pct_change",
	 round(CAST(100 * (("1996" - "1995")/ "1995") AS numeric), 2) AS "1995_1996_pct_change",
	 round(CAST(100 * (("1997" - "1996")/ "1996") AS numeric), 2) AS "1996_1997_pct_change",
	 round(CAST(100 * (("1998" - "1997")/ "1997") AS numeric), 2) AS "1997_1998_pct_change",
	 round(CAST(100 * (("1999" - "1998")/ "1998") AS numeric), 2) AS "1998_1999_pct_change",
	 round(CAST(100 * (("2000" - "1999")/ "1999") AS numeric), 2) AS "1999_2000_pct_change",
	 round(CAST(100 * (("2001" - "2000")/ "2000") AS numeric), 2) AS "2000_2001_pct_change",
	 round(CAST(100 * (("2002" - "2001")/ "2001") AS numeric), 2) AS "2001_2002_pct_change",
	 round(CAST(100 * (("2003" - "2002")/ "2002") AS numeric), 2) AS "2002_2003_pct_change",
	 round(CAST(100 * (("2004" - "2003")/ "2003") AS numeric), 2) AS "2003_2004_pct_change",
	 round(CAST(100 * (("2005" - "2004")/ "2004") AS numeric), 2) AS "2004_2005_pct_change",
	 round(CAST(100 * (("2006" - "2005")/ "2005") AS numeric), 2) AS "2005_2006_pct_change",
	 round(CAST(100 * (("2007" - "2006")/ "2006") AS numeric), 2) AS "2006_2007_pct_change",
	 round(CAST(100 * (("2008" - "2007")/ "2007") AS numeric), 2) AS "2007_2008_pct_change",
	 round(CAST(100 * (("2009" - "2008")/ "2008") AS numeric), 2) AS "2008_2009_pct_change",
	 round(CAST(100 * (("2010" - "2009")/ "2009") AS numeric), 2) AS "2009_2010_pct_change",
	 round(CAST(100 * (("2011" - "2010")/ "2010") AS numeric), 2) AS "2010_2011_pct_change",
	 round(CAST(100 * (("2012" - "2011")/ "2011") AS numeric), 2) AS "2011_2012_pct_change",
	 round(CAST(100 * (("2013" - "2012")/ "2012") AS numeric), 2) AS "2012_2013_pct_change",
	 round(CAST(100 * (("2014" - "2013")/ "2013") AS numeric), 2) AS "2013_2014_pct_change",
	 round(CAST(100 * (("2015" - "2014")/ "2014") AS numeric), 2) AS "2014_2015_pct_change",
	 round(CAST(100 * (("2016" - "2015")/ "2015") AS numeric), 2) AS "2015_2016_pct_change",
	 round(CAST(100 * (("2017" - "2016")/ "2016") AS numeric), 2) AS "2016_2017_pct_change",
	 round(CAST(100 * (("2018" - "2017")/ "2017") AS numeric), 2) AS "2017_2018_pct_change",
	 round(CAST(100 * (("2019" - "2018")/ "2018") AS numeric), 2) AS "2018_2019_pct_change"
	FROM t13)
SELECT * FROM t14
;


-- Q6. List 3 countries with lowest GDP per region
with t8 AS

	(SELECT *
	FROM gdp
	LEFT JOIN countries
	ON gdp.country_code = countries.country_code),
t9 AS
	(SELECT country_name, region_value, "incomeLevel_value", COALESCE("1960", 0) +
	 COALESCE("1961", 0) + COALESCE("1962", 0) + COALESCE("1963", 0) + COALESCE("1964", 0) +
	 COALESCE("1965", 0) + COALESCE("1966", 0) + COALESCE("1967", 0) + COALESCE("1968", 0) +
	 COALESCE("1969", 0) + COALESCE("1970", 0) + COALESCE("1971", 0) + COALESCE("1972", 0) +
	 COALESCE("1973", 0) + COALESCE("1974", 0) + COALESCE("1975", 0) + COALESCE("1976", 0) +
	 COALESCE("1977", 0) + COALESCE("1978", 0) + COALESCE("1979", 0) + COALESCE("1980", 0) +
	 COALESCE("1981", 0) + COALESCE("1982", 0) + COALESCE("1983", 0) + COALESCE("1984", 0) +
	 COALESCE("1985", 0) + COALESCE("1986", 0) + COALESCE("1987", 0) + COALESCE("1988", 0) +
	 COALESCE("1989", 0) + COALESCE("1990", 0) + COALESCE("1991", 0) + COALESCE("1992", 0) +
	 COALESCE("1993", 0) + COALESCE("1994", 0) + COALESCE("1995", 0) + COALESCE("1996", 0) +
	 COALESCE("1997", 0) + COALESCE("1998", 0) + COALESCE("1999", 0) + COALESCE("2000", 0) +
	 COALESCE("2001", 0) + COALESCE("2002", 0) + COALESCE("2003", 0) + COALESCE("2004", 0) +
	 COALESCE("2005", 0) + COALESCE("2006", 0) + COALESCE("2007", 0) + COALESCE("2008", 0) +
	 COALESCE("2009", 0) + COALESCE("2010", 0) + COALESCE("2011", 0) + COALESCE("2012", 0) +
	 COALESCE("2013", 0) + COALESCE("2014", 0) + COALESCE("2015", 0) + COALESCE("2016", 0) +
	 COALESCE("2017", 0) + COALESCE("2018", 0) + COALESCE("2019", 0) as "cummGDP($bn)"
	 FROM t8),
t10 AS
	(SELECT * FROM t9
	 WHERE "incomeLevel_value" != 'Aggregates' AND "cummGDP($bn)" != 0
	),
t11 AS
	(SELECT region_value, country_name, "cummGDP($bn)",
           ROW_NUMBER() OVER (PARTITION BY region_value
                              ORDER BY "cummGDP($bn)" ASC
                             )
             AS rn
    FROM t10
	)
SELECT region_value as region, country_name as country, ROUND(CAST("cummGDP($bn)" as numeric), 2) as "cummGDP($bn)"
FROM t11
WHERE rn <= 3
ORDER BY region, rn
;
