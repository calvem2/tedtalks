# Ted-Talks

## Domain of Interest
Our group is interested in this domain because Ted Talks have become a cultural icon
in our time. Ted Talks cover a large range of topics and some are more widely viewed
than others. We are curious to explore datasets of Ted Talks to determine if it will reveal
information about society or the times we live in. It is also possible that we
will not find anything that we can extrapolate to be a reflection of our society
but rather will simply learn more about what people find interesting or entertaining
and what they do not.  


**Examples of Data Driven Projects:**
* Project 1: **Analysing Ted Talks Ratings** by TheLostMind
    + *Link*: https://www.kaggle.com/vinodmadyalkar/analysing-ted-talks-ratings
    + **Description:** This project focuses on the ratings of different Ted Talks. It asks several data-driven questions about the talks, specifically: language's role in ratings, number of comments' relationship with number of views, number of views' relationship with view count and more. The project analyzes the data to find these answers using Python and uses several visualizations to answer these questions.


* Project 2: **Ted-Talks Topic Models** by Adelson Araujo Junior
    + *Link*: https://www.kaggle.com/adelsondias/ted-talks-topic-models
    + **Description:** This project seeks to create a topic model based on a data set of meta information about Ted Talks as well as a data set of transcripts. Using these sets of data and Python, the project evaluates the patterns of the transcripts and meta information relating to the topics in the talks.


* Project 3:
    + *Link*: https://www.kaggle.com/ashishpatel26/ted-talks-lesson-worth-sharing  
    + **Description:** This project offers an overview of Ted Talks and basic statistics about the program using Python. It offers data visualizations by events, speakers, comments and other information.

**Questions we want to explore:**
* What are the most significant factors in the number of views a Ted Talk receives?
* What buzz words appear most often across multiple talks?
* Does the duration of the talk have an effect on total views?
* Does the number of language translations influence the view count?
* What are the most significant factors in the ratings the talks received?
* Does the number of language translations influence the ratings the talks received?
* Is there a connection between the number of comments and the view count or rating?
* Is there a connection between the ratings and the number of positive vs negative buzz words in a talk?
* Who are the three most popular speakers?
* Which topics generate the most views?



## Data Source Description

1. **ted_main.csv**
    + *Link:* https://www.kaggle.com/rounakbanik/ted-talks?fbclid=IwAR1WbDu8yUA_clyPVm6dIT3807YPJhzB8rHBTREM_-4cAZssefe5Z2eTHhQ#ted_main.csv

    + **Description:** This Kaggle dataset comes from Ted.com and looks at all the TEDTalks (which started in 1984) up until September 21st, 2017. It contains data such as: the number of comments, a brief description, duration of the talk, where the event took place, the number of languages the talk is in, the film date, the main speaker’s name, the number of speakers, the publishing date, the ratings, the speaker occupation, the number views, and the name of the talk. We could use the different data pieces to see their effect on the number of views or the popularity of a video.

    + Number of Observations (rows): **2550**
    + Number of Features (columns): **17**

    + Questions that can be answered:
      + Who are the three most popular speakers?
      + Which topics generate the most views?
      + What are the most significant factors in the number of views a Ted Talk receives?
      + Does the duration of the talk have an effect on total views?
      + What are the most significant factors in the ratings the talks received?
      + Does the number of language translations influence the ratings the talks received?
      + Is there a connection between the number of comments and the view count or rating?
      + Does the number of language translations influence the view count?


2. **transcripts.csv**
    + *Link:* https://www.kaggle.com/rounakbanik/ted-talks?fbclid=IwAR10nJv3I9CvJuDbfcFYDDvIQAxOTv83zEGMoIxjB5d8h7o7J5iPPmAG5Yw#transcripts.csv

    + **Description:** This dataset examines the same TED talks from the year above, but only provides the name of the TEDTalk and a transcript from said talk. This data is quite cumbersome, but may be able to be used if we want to check word frequency. The data was collected from Ted.com.

    + Number of Observations (rows): **2467**
    + Number of Features (columns): **2**

    + Questions that can be answered:
      + What buzz words appear most often across multiple talks?
      + Is there a connection between the ratings and the number of positive vs negative buzz words in a talk?


3. **Ted_Talks_by_ID_plus-transcripts-and-LIWC-and-MFT-plus-views.csv**
    + *Link:* https://data.world/owentemple/ted-talks-complete-list?fbclid=IwAR0WWitDp6ZslAlDzum7qTS51928E-OdRK_0Hi8DgZLMWG4495XdBFqGj6Q

    + **Description:** This dataset is the most comprehensive one in our collection of datasets about TEDTalks. The data comes from Ted.com, and gives information about TEDTalk up until June 13th, 2017, such as: a video ID, video URL, speaker name, headline, description, film date, event name, talk duration, and publishing date. It is unique in that it has topic tags as well as a full English transcript. However, it does not take into account different languages, but instead uses the English transcript and variables from the website [Linguistic [Inquiry and Word Count](http://liwc.wpengine.com/) (LIWC) to determine the count of a specific type of word (eg. Positive). We could use this data similarly, but also decide on what types of messaging creates popular Ted Talks. Since this dataset is so comprehensive, many of our questions could be answered with it. Since it already filtered out specific words and word groups, we can use it as a benchmark for our word analysis with the transcripts.csv dataset.

    + Number of Observations (rows): **2475**
    + Number of Features (columns): **123**

    + Questions that can be answered:
      + Which topics generate the most views?
      + What are the most significant factors in the number of views a Ted Talk receives?
      + Does the duration of the talk have an effect on total views?
      + What buzz words appear most often across multiple talks?
      + Is there a connection between the ratings and the number of positive vs negative buzz words in a talk?
