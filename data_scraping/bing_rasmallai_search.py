#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sat Jun 23 09:45:05 2018

@author: shilpakancharla
"""

from bs4 import BeautifulSoup
import urllib, urllib2

def search(query):
    address = "http://www.bing.com/search?q=%s" % (urllib.quote_plus(query))
    
    getRequest = urllib2.Request(address, None, {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 Chrome/65.0.3325.162 Safari/537.36'})
    
    urlfile = urllib2.urlopen(getRequest)
    htmlResult = urlfile.read(200000)
    urlfile.close()
    
    soup = BeautifulSoup(htmlResult)
    
    [s.extract() for s in soup('span')]
    #unwantedTags = ['a', 'strong', 'cite']
    #for tag in unwatedTags:
        #for match in soup.findAll(tag):
           # match.replaceWithChildren()
    
    results = soup.findAll('li', {"class" : "b_algo" })
    for result in results: 
        print "# TITLE: " + str(result.find('h2')).replace(" ", " ") + "\n#"
        print "# DESCRIPTION: " + str(result.find('p')).replace(" ", " ")
        print "# ___________________________________________________________\n#"
    
    return results

if __name__ == '__main__':
    links = search('rasmallai')