## Python Data Scraping Tutorial

- Write a Python program to parse a search engine (ideally Bing) for a given text. The text will usually be a dish name. Extract links from these results.

- Program should then parse the links in search result and store the results for analysis.

- Extract keywords from these contents using natural language processing (NLP).

- Deliverables: Python program & CSV file containing dish name and associated keywords obtained using NLP.

**Step 1**: Install HTML parser: ` $ pip install BeautifulSoup`

While we are on this step, import the "urllib" and "urllib2" packages in addition to the parser package at the header of our Python script. We will need the other packages for our HTTPS request.

`from BeautifulSoup import BeautifulSoup
import urllib,urllib2`
