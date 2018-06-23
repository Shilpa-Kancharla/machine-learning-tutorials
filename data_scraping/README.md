## Python Data Scraping Tutorial

- Write a Python program to parse a search engine (ideally Bing) for a given text. The text will usually be a dish name. Extract links from these results.

- Program should then parse the links in search result and store the results for analysis.

- Extract keywords from these contents using natural language processing (NLP).

- Deliverables: Python program & CSV file containing dish name and associated keywords obtained using NLP.

## Natural Language Processing

- Noise removal: any piece of text which is not relevant to the context of the data and the end-output can be specificed as the noise. For example, language stopwords (commonly used words of a language – is, am, the, of, in etc), URLs or links, social media entities (mentions, hashtags), punctuations and industry specific words. This step deals with the removal of noisy entities present in the text. 

- General method for removal is to prepare a dictionary of noisy entitities, and iterate the text object by tokens (or by words), eliminating those tokens which are present in the noise dictionary. 

- **removal.py** shows a way to do this.
