#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup

url = 'https://www.formula1.com/en/racing/2022/Bahrain/Timetable.html'

while True: 
    response = requests.get(url)
    soup = BeautifulSoup(response.text,'html.parser')
    live_timing = soup.find('span', {'class': 'listing-row_value'})
    if live_timing is not None:
        print(live_timing.text)
    else:
        print("Live timing not found")


