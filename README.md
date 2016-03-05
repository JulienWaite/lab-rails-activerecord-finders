# Lab: Find Carmen Sandiego Again... with ActiveRecord!!

## Part I - Find Carmen Sandiego

Repeat the [previous exercise](https://github.com/wdi-hk-10/lab-carmen-sandiego) but this time let's use the ActiveRecord query interface to find Carmen Sandiego.

You **DO NOT** need to create the database **NOR** load the data again.

Feel free to re-use the SQL solution of the previous exercise and translate the SQL queries into ActiveRecord queries.


## Part II - Extra challenges

Please use ActiveRecord queries to solve the following puzzles:

1. List the distinct regions in the `Country` table.

2. How many countries are located in European regions?

3. Find the total population of all countries group by regions.

4. Use one query to answer the following 2 questions
  i. Find the countries which have the most spoken languages used (Bonus: show the country names)
  ii. Find the maximum number of languages you can use in one country

5. Find all the Asia countries that went independent from 1940 to 1950. Order the result by the year of independence.

6. Find all the countries that do not use English at all (Bonus: show the country names)


## Instructions

1. Fork and Clone
2. In your local lab folder, do `cd code/carmen`.
3. You should **NOT** change anything in the `code/carmen` folder.
4. Run `rails c` and you will be inside the Rails console. Here you can use the `ActiveRecord` finder methods to query for data.
5. Try to run the query `City.take(1)` to ensure everything is in order. You should see a _similar_ output like this one:
```
Running via Spring preloader in process 26598
Loading development environment (Rails 4.2.1)
irb(main):001:0> City.take(1)
  City Load (0.4ms)  SELECT  "city".* FROM "city" LIMIT 1
=> [#<City id: 1, name: "Kabul", countrycode: "AFG", district: "Kabol", population: 1780000>]
irb(main):002:0>
```

## Deliverable

1. Collect all your `ActiveRecord` queries in a file called `query.rb` under the repo root folder (where you find this README).
2. Submit a pull request
