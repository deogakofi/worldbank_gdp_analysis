#!/usr/bin/env python3

import argparse
import json
import requests
import pandas
from pandas.io.json import json_normalize
from sqlalchemy import create_engine


def get_countries():
    """Get countries from worldbank API
    Args:
        None
    Returns:
        df_country => worldbank api json response in dataframe format
    """

    urls = "http://api.worldbank.org/v2/country?format=json&per_page=500"
    try:
        response = requests.get(urls)
        data = response.json()[1]
    except:
        print('could not load data')

    df_country = pandas.json_normalize(data)
    df_country.rename(columns = {'id': 'country_code'}, inplace = True)
    return df_country


def read_csv(csv_location: str):
    """Read worldbank GDP csv
    Args:
        csv_location => File containing worldbank GDP data
    Returns:
        df_gdp => GDP data in dataframe format for analysis
    """

    df_gdp = pandas.read_csv(csv_location, header=2)\
    .rename(columns = {'Country Code': 'country_code',
    'Country Name': 'country_name',
    'Indicator Name': 'indicator_name',
    'Indicator Code': 'indicator_code'})
    df_gdp.drop(['Unnamed: 65', '2020'], axis = 1, inplace = True)
    return df_gdp


def load_gdp(csv_location: str, table_name: str):
    """Load GDP data to postgres database
    Args:
        csv_location => File containing worldbank GDP data
        table_name => Name of table in database
    Returns:
        df_gdp => GDP data in dataframe format for analysis
    """

    df_gdp = read_csv(csv_location)
    engine = create_engine('postgresql://localhost/postgres')
    df_gdp.to_sql(table_name, engine, if_exists = 'replace')
    return df_gdp

def load_countries(table_name: str):
    """Load countries data to postgres database
    Args:
        table_name => Name of table in database
    Returns:
        countries => countries data in dataframe format for analysis
    """
    engine = create_engine('postgresql://localhost/postgres')
    countries = get_countries()
    countries.columns = countries.columns.str.replace(".", "_")
    countries.to_sql(table_name, engine, if_exists = 'replace')
    return countries

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='load to postgres')
    parser.add_argument('--csv_location', required=False,\
    default="API_NY.GDP.PCAP.CD_DS2_en_csv_v2_2252129.csv")
    parser.add_argument('--gdp_table_name', required= False, default="gdp")
    parser.add_argument('--countries_table_name', required=False,\
    default="countries")
    args = vars(parser.parse_args())

    load_gdp(args['csv_location'], args['gdp_table_name'])
    load_countries(args['countries_table_name'])
