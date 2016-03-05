# Lab: Find Carmen Sandiego Again... with ActiveRecord!!

## Part I - Find Carmen Sandiego

# Repeat the [previous exercise](https://github.com/wdi-hk-10/lab-carmen-sandiego) but this time let's use the ActiveRecord query interface to find Carmen Sandiego.
# You **DO NOT** need to create the database **NOR** load the data again.
# Feel free to re-use the SQL solution of the previous exercise and translate the SQL queries into ActiveRecord queries.



# -- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
# -- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
# -- so find the least populated country in Southern Europe, and we'll start looking for her there.
Country.select(:name, :population).where(region: "Southern Europe").order(:population).min
# SQL query is SELECT name, population FROM Country WHERE region = 'Southern Europe' ORDER BY population ASC LIMIT 1;
# Answer = Holy See (Vatican City State)
country = Country.where(region: "Southern Europe").order(:population).first # <-- alternative answer



# -- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
# -- this country's officially recognized language. Check our databases and find out what language is
# -- spoken in this country, so we can call in a translator to work with you.
CountryLanguage.where(countrycode: "VAT")
# SQL query is SELECT * FROM CountryLanguage WHERE countrycode = 'VAT';
# Answer = Italian
countrycode = country.code # <-- alternative answer
country_language = CountryLanguage.find_by(countrycode: countrycode).language # <-- alternative answer
language = country_language.language # <-- alternative answer



# -- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
# -- to a different country, a country where people speak only the language she was learning. Find out which
# --  nearby country speaks nothing but that language.
CountryLanguage.where(language: "Italian", percentage: 100)
# SQL query is SELECT * FROM CountryLanguage WHERE language = 'Italian' AND percentage = 100;
Country.select(:name).where(code: "SMR")
# SQL query is SELECT name FROM country WHERE code = 'SMR';
# Answer = San Marino
country_language = CountryLanguage.where(language: language, percentage: 100) # <-- alternative answer
country = Country.find_by(code: country_language.countrycode) # <-- alternative answer



# -- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
# -- There are only two cities she could be flying to in the country. One is named the same as the country – that
# -- would be too obvious. We're following our gut on this one; find out what other city in that country she might be flying to.
City.where(countrycode: "SMR")
# SQL query is SELECT * FROM city WHERE countrycode = 'SMR';
# Answer = Serravalle
city = City.where(countrycode: country.code).where.not(name: country.name).first # <-- alternative answer



# -- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
# -- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
# -- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!
City.where("name LIKE ?", "Serra%")
# SQL query is SELECT * FROM city WHERE name LIKE 'Serra%';
Country.where(code: "BRA")
# SQL query is SELECT * FROM country WHERE code = 'BRA'
# Answer = Serra, BRA
city = City.where("name LIKE ?", "Serra%").first # <-- alternative answer
country = Country.find_by(code: city.countrycode) # <-- alternative answer



# -- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
# -- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll follow right behind you!
Country.select(:capital).where(name: "Brazil")
# SQL query is SELECT capital FROM Country WHERE name = 'Brazil';
City.where(id: 211)
# SQL query is SELECT name FROM city WHERE id = 211;
# Answer = Bras�lia
city = City.find(country.capital) # <-- alternative answer



# -- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
# -- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the landing dock.
# There is no answer for this!



# -- Clue #8: Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
# -- if we can crack it, we can finally put her where she belongs – behind bars.
# -- Our playdate of late has been unusually fun –
# -- As an agent, I'll say, you've been a joy to outrun.
# -- And while the food here is great, and the people – so nice!
# -- I need a little more sunshine with my slice of life.
# -- So I'm off to add one to the population I find
# -- In a city of ninety-one thousand and now, eighty five.
City.where(population: 91084)
# SQL query is SELECT name, population FROM city WHERE population = 91084;
# -- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.
# -- She's in Santa Monica, USA!
goal = City.find_by(population: 91084)




## Part II - Extra challenges

# Please use ActiveRecord queries to solve the following puzzles:


# 1. List the distinct regions in the Country table.
Country.select(:region).distinct
# SQL query is SELECT DISTINCT region FROM country;
Country.distinct.pluck(:region count) # <-- alternative answer



# 2. How many countries are located in European regions?
Country.select(:name).where(continent: "Europe")
# SQL query is SELECT COUNT(name) FROM country WHERE continent = 'Europe';
Country.where(continent: "Europe").count # <-- alternative answer



# 3. Find the total population of all countries group by regions.
Country.group(:region).sum(:population)
# SQL query is SELECT region, SUM(population) FROM country GROUP BY region;



# 4. Use one query to answer the following 2 questions
    # i.  Find the countries (countrycodes) which have the most spoken languages used
    # ii. Find the maximum number of languages you can use in one country
CountryLanguage.group(:countrycode).order("count_language desc").count(:language)
# SQL query is SELECT countrycode, COUNT(language) FROM countrylanguage GROUP BY countrycode ORDER BY count DESC;



# 5. Find all the Asia countries that went independent from 1940 to 1950. Order the result by the year of independence..
Country.select(:name, :continent, :indepyear).where(continent:'Asia', indepyear:1940..1950).order(:indepyear)
# SQL query is SELECT indepyear,name FROM country WHERE continent = 'Asia' AND indepyear >= 1940 AND indepyear <= 1950 ORDER BY indepyear ASC;



# 6. Find all the countries (countrycodes) that do not use English at all
CountryLanguage.where("(language = 'English' AND percentage = 0) OR language != 'English')")
# SQL query is SELECT countrycode, language, percentage FROM countrylanguage WHERE language = 'English' AND percentage = 0;