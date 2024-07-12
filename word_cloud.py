import numpy as np # linear algebra
import pandas as pd # data processing

import seaborn as sns #statist graph package
import matplotlib.pyplot as plt #plot package

import wordcloud #will use for the word cloud plot
#from wordcloud import WordCloud, STOPWORDS # optional to filter out the stopwords

from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator

#Optional helpful plot stypes:
plt.style.use('bmh')




table3= pd.read_excel("Table 3 final_submitted.xlsx")

table3a= table3.iloc[:, 0:4]


table3a.drop(['cause of population decline'], axis=1, inplace=True)



species= table3a.value_counts("scientific name")

species.to_csv("species_conservation_status.csv")

### column iucn status and color was added

df= pd.read_csv('word_cloud_iucn_color_up.csv')


freq_dict = df.set_index('sci_name')['freq'].to_dict()



def color_func(word, **kwargs):
    index = df[df['sci_name'] == word].index[0]
    return df.loc[index, 'color']

# Generate the word cloud.
wordcloud = WordCloud(color_func=color_func,collocations=False, max_font_size=50, max_words=540, background_color="white", width=800, height=500).generate_from_frequencies(freq_dict)

# Display the generated image.
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
#plt.show()
#plt.figure(figsize=(19.20,10.80))
plt.savefig("wc_up218ja.pdf", dpi=300)
plt.savefig("wc_up218ja.png", dpi=300)
plt.savefig('wc_up218ja.svg', format='svg', dpi=1200)

