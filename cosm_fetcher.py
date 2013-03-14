#!/usr/bin/env python

#-----------------------------------------------
# Python fetcher for COSM v0.1
# A python script to fetch one cosm datastream
#
# copyright (c) Davide Gironi, 2012
# http://davidegironi.blogspot.it/
#
# Released under GPLv3
#
# References:
#   https://gist.github.com/3902709
#-----------------------------------------------

import sys
import urllib2
from datetime import *
from time import *
import dateutil.parser

#setup your cosm account data here
#set cosm key
COSM_APIKEY="74uuDpV8viR7JFpFIEeEh3DR7FGSAKxQNFpDTThzSVFYVT0g"
#set cosm feed id
COSM_FEEDID=93539
#set cosm datastream
COSM_DATASTREAM=102

#download datastream backward from DATETO to DATEFROM, with datapoint interval of INTERVAL (seconds), and backward step of DATEINTERVAL (hour)
#cosm history interval reqDIUuest
INTERVAL=0
#get backward from DATETO to DATEFROM
DATEFROM=datetime(2013,3,1,12,45,0) 
DATETO=datetime(2013,3,11,20,50,0)
#interval between requested data (in hour)
DATEINTERVAL=6

#output file name, and conversion (date) to csv format
#set output file
OUTFILE="out_power.csv" 
#convert cosm data
CONVERTDATA=1

def main():
    #init request intervals
    req_interval = timedelta(hours=DATEINTERVAL)
    end = DATETO
    begin = end-req_interval
    retry_count=0
    out_file = open(OUTFILE,"w")
    while begin > DATEFROM :
        try:
            print "request data from %s to %s..." % (begin.strftime('%Y-%m-%d %H:%M:%S'), end.strftime('%Y-%m-%d %H:%M:%S'))
            #prepare request
            req = urllib2.Request('http://api.cosm.com/v2/feeds/%d/datastreams/%s.csv?start=%s&end=%s&interval=%d&limit=1000' % ( COSM_FEEDID, COSM_DATASTREAM, begin.strftime('%Y-%m-%dT%H:%M:%SZ'), end.strftime('%Y-%m-%dT%H:%M:%SZ'), INTERVAL), headers={ 'X-ApiKey' : COSM_APIKEY })
            resp = urllib2.urlopen(req)
            print resp.code
            if resp.code == 200:
                print "  success, writing to output file..."
                #get response
                respdata = resp.read()
                if CONVERTDATA:
                    writeall = ""
                    #reverse the data to have correct order, split it to get lines
                    respdatasplit = reversed(respdata.split('\n'))
                    for respdataline in respdatasplit:
                        #split every line to get datetime and value
                        respdatalinesplit = respdataline.split(",")
                        try:
                            respdataline_datetime = dateutil.parser.parse(respdatalinesplit[0])
                            respdataline_value = respdatalinesplit[1]
                            #prepare the line to write
                            writeline = "\"" + str(respdataline_datetime.strftime("%Y-%m-%d %H:%M:%S")) + "\";\"" + str(respdataline_value) + "\""
                            writeall += writeline + '\n'
                        except:
                            print "no data in this segment"
                else:
                    writeall = respdata
                #write out the line
                out_file.write(writeall)
                #set the new interval to request
                end = begin
                begin = end-req_interval
                retry_count = 0

        except urllib2.HTTPError:
            #error handler
                print urllib2.HTTPError.code
                retry_count = retry_count + 1
                print "  error %d, retry in a few..." % retry_count         
        
        #flush file every reading
        out_file.flush()
        
        #wait for the next request
        print "wait 2 seconds before the next request..."
        sleep(2)
    
    #close output file
    out_file.close()

if __name__ == '__main__':
    main()           
