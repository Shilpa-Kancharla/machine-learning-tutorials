## Python Data Scraping Tutorial

- Write a Python program to parse a search engine (ideally Bing) for a given text. The text will usually be a dish name. Extract links from these results.

- Program should then parse the links in search result and store the results for analysis.

- Extract keywords from these contents using natural language processing (NLP).

- Deliverables: Python program & CSV file containing dish name and associated keywords obtained using NLP.

## Natural Language Processing

- *Noise removal*: any piece of text which is not relevant to the context of the data and the end-output can be specificed as the noise. For example, language stopwords (commonly used words of a language – is, am, the, of, in etc), URLs or links, social media entities (mentions, hashtags), punctuations and industry specific words. This step deals with the removal of noisy entities present in the text. 

- General method for removal is to prepare a dictionary of noisy entitities, and iterate the text object by tokens (or by words), eliminating those tokens which are present in the noise dictionary. 

- **removal.py** shows a way to do this.

- *Lexicon Normalization*: the same word can be represented in multiple, different ways. For example – “play”, “player”, “played”, “plays” and “playing” are the different variations of the word – “play”, though they mean different but contextually all are similar. The step converts all the disparities of a word into their normalized form (also known as lemma). Normalization is a pivotal step for feature engineering with text as it converts the high dimensional features (N different features) to the low dimensional space (1 feature), which is an ideal ask for any ML model. The most common practices are 

  - *Stemming*: rudimentary rule-based process of stripping the suffixes ("ing", "ly", "es", "s" etc) from a word.
  
  - *Lemmatization*: organized and step by step procedure of obtaining the root form of the word, it makes use of vocabulary (dictionary importance of words) and morphological analysis (word structure and grammar relations).
