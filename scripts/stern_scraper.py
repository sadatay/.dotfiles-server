#!/bin/python2

import os
import re
import sys
import sqlite3
import feedparser

feed_uri = 'http://www.marksfriggin.com/friggin.rss'
template_path = '/home/rtor/scripts/howard_index_resources/howard_template.html'
index_file = '/home/rtor/streams/Howard_Stern_Show/index.html'
serve_path = '/Radio_Rips/Howard_Stern_Show/'


#DB SCHEMA
#date (text)
#file (text)
#description (text)
#notes (text)

def parse_feed(match_date):
    feed_data = feedparser.parse(feed_uri)
    date_regex = re.compile('\w+, (\d+) (\w+) (\d+)')
    match_date = match_date
    for entry in feed_data.entries:
        entry_date = entry['published']
        date_group = date_regex.match(entry_date)
        if date_group:
            (year, month, day) = match_date
            entry_day = date_group.group(1)
            entry_month = convert_month(date_group.group(2))
            entry_year = date_group.group(3)

            #need to pad days and years potentially
            if len(entry_day) == 1:
                entry_day = '0' + entry_day
            if len(entry_month) == 1:
                entry_month = '0' + entry_month

            if day == entry_day and month == entry_month and year == entry_year:
                return entry['summary_detail']['value']

    return "<i>Description Unavailable</i>"

def get_template(template_path):
    template_fh = open(template_path, 'r')
    return template_fh.read()

def parse_date(file_string):
    file_string = os.path.split(file_string)[-1]
    date_regex = re.compile('Howard_Stern_Show_(\d+)_(\d+)_(\d+)_\d+_\d+_\d+.mp3')
    date_group = date_regex.match(file_string)
    if date_group:
        entry_year = date_group.group(1)
        entry_month = date_group.group(2)
        entry_day = date_group.group(3)
        return (entry_year, entry_month, entry_day)
    return 0

def interpolate_variables(template, file_string, file_date, description):
    (day, month, year) = file_date
    date_string = "%s-%s-%s" % (year, month, day)

    #do replacements
    markup = re.sub(r"::DATE_STRING::", date_string, template)
    markup = re.sub(r"::ID::", date_string, markup)
    markup = re.sub(r"::DESCRIPTION_ID::", date_string, markup)
    markup = re.sub(r"::HYPERLINK::", file_string, markup)
    markup = re.sub(r"::DESCRIPTION::", description, markup)

    return markup

def write_to_db(date, file_string, description, notes=''):
    #create connection
    db_connection = sqlite3.connect('/home/rtor/scripts/howard_index_resources/radio.db')
    db_cursor = db_connection.cursor()

    #create and execute query
    insert_sql = "INSERT INTO howard_stern_show VALUES (?, ?, ?, ?)"
    print insert_sql
    success = db_cursor.execute(insert_sql, (date, file_string, re.escape(description), notes))

    #wrap it up
    db_connection.commit()
    db_connection.close()
    return success

def create_table():
    #create connection
    db_connection = sqlite3.connect('/home/rtor/scripts/howard_index_resources/radio.db')
    db_cursor = db_connection.cursor()

    #create and execute query
    create_sql = "CREATE TABLE howard_stern_show (date text, file text, description text, notes text)"
    success = db_cursor.execute(create_sql)

    #wrap it up
    db_connection.commit()
    db_connection.close()
    return success

def kill_cues(base_dir):
    os.system("rm %s/*.cue" % base_dir)

def convert_month(month):
    if re.search('jan', month, re.I):
        return '01'
    if re.search('feb', month, re.I):
        return '02'
    if re.search('mar', month, re.I):
        return '03'
    if re.search('apr', month, re.I):
        return '04'
    if re.search('may', month, re.I):
        return '05'
    if re.search('jun', month, re.I):
        return '06'
    if re.search('jul', month, re.I):
        return '07'
    if re.search('aug', month, re.I):
        return '08'
    if re.search('sep', month, re.I):
        return '09'
    if re.search('oct', month, re.I):
        return '10'
    if re.search('nov', month, re.I):
        return '11'
    if re.search('dec', month, re.I):
        return '12'

def process_file(file_string, base_dir):
    #open the template file
    template = get_template(template_path)

    #get the date tuple from file string
    file_date = parse_date(file_string)

    #get matching description
    description = parse_feed(file_date)

    # #interpolate variables into template
    # entry_markup = interpolate_variables(template, file_string, file_date, description)

    #write markup to db file
    write_to_db("%s-%s-%s" % file_date, file_string, description)

    #clean up cue files
    kill_cues(base_dir)

    return

def main(args):
    for arg in args[1:-1]:
        if arg[-3:] == 'mp3':
            process_file(arg, args[-1])

if __name__ == '__main__':
    main(sys.argv)

#DEPRECATED
def write_to_file(entry_markup):
    global index_file
    write_fh = open(index_file, 'a')
    write_fh.write(entry_markup)
