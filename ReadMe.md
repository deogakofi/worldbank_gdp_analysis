CRON SCHEDULER INTERPRETER PROJECT
------------------------------------
Specification
-------------------

As part of this exercise, you would write a Python script to retrieve publicly available data and perform analysis on that data using SQL.
Publicly available data is available from the World Bank. One dataset which contains information about countries is available through World Bank API and its documentation provides all the necessary details on how to use it. Another dataset which includes Gross Domestic Product (GDP) data in CSV format is available for download from World Bank Data Catalog.
We recommend you keep notes of your design, problems you have encountered as well as steps you have taken to resolve them. We might ask you to present your solution.


Objectives
------------------------
1. Write Python script to retrieve countries’ data from a World Bank Country API as well GDP data from World Bank Data Catalog. <br>
2. Store all data in a database; ideally PostgreSQL locally and Model data in a way to be able to perform data analysis (see below). <br>
3. Write SQL queries to answer questions below. <br>

Analysis
-------------
1. List countries with income level of "Upper middle income". <br>
2. List countries with income level of "Low income" per region. <br>
3. Find the region with the highest proportion of "High income" countries. <br>
4. Calculate cumulative/running value of GDP per region ordered by income from lowest to highest and country name. <br>
5. Calculate percentage difference in value of GDP year-on-year per country. <br>
6. List 3 countries with lowest GDP per region. <br>
7. Provide an interesting fact from the dataset. <br>


File Structure
----------------------
* `.circleci` Folder contains the below:
  * `config.yml` File contains the config for circleCI CI/CD pipelines

* `API_NY.GDP.PCAP.CD_DS2_en_csv_v2_2252129.csv`: Contains gdp data

* `Solution.py` Contains python ETL script

* `Solution.sql` Contains all queries used for exercise

* `Makefile` File contains easy installation for Unix-based systems and Mac

* `Readme.MD` Contains the readme for the project

* `Results.xlsx` Contains a presentation of the results

* `Requirements.txt` File contains a list of packages required to run project.

* It is recommended you run the solution in a virtual environment. Please see https://docs.python.org/3/library/venv.html


USAGE INSTRUCTIONS
-------------------------------
***Warning***  
You may need python3 command python command depending on what your cli is mapped to python3. In this case my python3 interpreter is invoked using python3. The same applies for pip/pip3  

* Clone this repo to your computer.
* Install postgres and start server
* Update `solution.py` with appropriate server name in `to_sql()` methods
* For mac please ensure you have xcode or download it from the app store (probably not needed)
* From your CLI install homebrew using `/usr/bin/ruby -e "$(curl -fsSL https:/raw.githubusercontent.com/Homebrew/install/master/install)"`
* After installing homebrew successfully, install python3 using `brew install python3`
* Check python3 installed correctly using `python3 --version` and this should return python3 version
* Install the requirements using `pip3 install -r requirements.txt`.
    * Make sure you use Python 3
* `cd` to the location of the parent directory in CLI
* Navigate to parent directory in CLI
* Execute `python3 solution.py`
* Check DB to ensure tables are created


USING MAKEFILE
----------------------
To make life easier on UNIX-based systems and MAC os, there is a makefile for this project and the following commands could be run:
*  `Make setup` Installs requirements for project (mainly pylint)
*  `Make lint` Lints python files using pylint
*  `Make all` Runs all the 3 above commands at once

Extending this
-------------------------

If you want to extend this work, here are a few places to start:

* Add tests
* Modify application to run as a micro-service
* Improve error messages using try except principles
* Use a class object



## Credits

Lead Developer - Deoga Kofi


## License

The MIT License (MIT)

Copyright (c) 2021 Deoga Kofi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.




[![CircleCI](https://circleci.com/gh/circleci/circleci-docs.svg?style=svg)](https://circleci.com/gh/circleci/circleci-docs)
