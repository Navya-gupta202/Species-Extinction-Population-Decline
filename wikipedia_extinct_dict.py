#!/usr/bin/env python
# coding: utf-8

# In[1]:


import wikipedia


# In[2]:


from bs4 import BeautifulSoup # to parse html and pull out text
import re
from lxml import etree


# In[3]:


def get_raw_wikipedia_html(title_of_page):
  raw_html = wikipedia.WikipediaPage(title_of_page).html()
  return raw_html


# In[4]:


def get_terms(raw_html, find_element = 'a'):
  soup = BeautifulSoup(raw_html, 'html.parser')
  climate_term = []
  black_list = ['climate', 'climate change']
  for term in soup.find_all(find_element):
      our_term = term.text.replace('\n', ' ')
      clean_term = re.sub(r'\([^()]*\)', '', our_term)
      if clean_term not in black_list:
        climate_term.append(clean_term)
  return climate_term


# In[5]:


title_of_page = "List of recently extinct molluscs"#"Climate change"#"Glossary of climate change"#"List of animal names"#"Attribution of recent climate change"
raw_html = get_raw_wikipedia_html(title_of_page)
extinct_term = get_terms(raw_html)
#write_to_dict(extinct_term, 'climate_span')


# In[6]:


import pandas as pd


# In[7]:


molluscs_df= pd.DataFrame(extinct_term)


# In[9]:


molluscs_df.to_csv('molluscs_extinct.csv')


# In[10]:


pwd


# In[ ]:


"List of bird extinctions by year",
"List of extinct dog breeds",
"List of recently extinct amphibians",
"List of recently extinct arthropods",
"List of recently extinct fishes",
"List of recently extinct insects",
"List of recently extinct invertebrates",
"List of recently extinct mammals",
"List of recently extinct molluscs",
"List of recently extinct reptiles",


# In[16]:


list_ex= ["List of bird extinctions by year",
"List of extinct dog breeds",
"List of recently extinct amphibians",
"List of recently extinct arthropods",
"List of recently extinct fishes",
"List of recently extinct insects",
"List of recently extinct invertebrates",
"List of recently extinct mammals",
"List of recently extinct molluscs",
"List of recently extinct reptiles",
"List of recently extinct plants"]


# In[17]:


list_ex[1]


# In[18]:


for i in list_ex:
    title_of_page = i
    raw_html = get_raw_wikipedia_html(title_of_page)
    extinct_term = get_terms(raw_html)
    molluscs_df= pd.DataFrame(extinct_term)
    outputfile="result_{}.csv".format(i)
    molluscs_df.to_csv(outputfile)


# In[ ]:

def write_to_dict(climate_term, title):
    dictionary_element = etree.Element("dictionary")
    dictionary_element.attrib['title'] = title
    for term in climate_term:
        entry_element = etree.SubElement(dictionary_element, "entry")
        entry_element.attrib['term'] = term
    xml_dict = etree.tostring(dictionary_element, pretty_print=True).decode('utf-8')

    with open(f'{title}.xml', mode='w', encoding='utf-8') as f:
        f.write(xml_dict)




# In[ ]:

amp= pd.read_excel('species_only_amphibians.xlsx')
amp2 = amp['plant2'].tolist()
write_to_dict(amp2, "amp2")



# In[ ]:





# In[ ]:





# In[ ]:




