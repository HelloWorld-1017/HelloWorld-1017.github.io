---
title: "Takeaways from <i>Python Crash Course</i>: Python Plotly"
categories:
 - Python
 - Web Development
tags:
 - Native Python
 - <i>Python Crash Course</i>
 - Python Graphics
 - Python csv
 - Python Plotly
 - Python json
 - JSON
date: 2024-08-26 16:32:26 +0800
last_modified_at: 2024-08-28 03:39:09 +0800
---

This post is a record made while learning Chapter 15 “Generating Data” and Chapter 16 “Downloading Data” in Eric Matthes’s book, *Python Crash Course*.[^1]
{: .notice--primary}

# Introduction

We can use Python Plotly[^2] to produce <i class="emphasize">interactive visualizations</i>, especially when we’re creating visualizations <i class="emphasize">that will be displayed in a browser</i>. 

<br>

# Roll the dice

In this section, we’ll simulate the case of rolling dice for multiple times and visualize its statistical results using Python Plotly.

## `Die` Class


```python
from random import randint

class Die:
    """A class representing a single die."""
    
    def __init__(self, num_sides=6):
        """Assume a six-sided die."""
        self.num_sides = num_sides
        
    def roll(self):
        """"Return a random value between 1 and number of sides."""
        return randint(1, self.num_sides)
```

The `randint()` function in the `roll()` method is to return a random integer between `1` and the number of sides `num_sides`.

## Roll a D6 dice


```python
# Create a D6.
die = Die()

# Make some rolls, and store results in a list.
results = []
for roll_num in range(100):
    result = die.roll()
    results.append(result)
 
print(results)
```

    [2, 3, 5, 3, 3, 4, 1, 3, 3, 6, 3, 6, 2, 2, 5, 2, 2, 4, 5, 2, 1, 6, 1, 5, 1, 6, 1, 1, 5, 6, 6, 3, 5, 5, 3, 6, 2, 6, 2, 1, 1, 3, 5, 5, 3, 4, 6, 4, 1, 5, 1, 3, 2, 5, 5, 3, 2, 6, 4, 6, 3, 2, 4, 1, 2, 5, 2, 2, 6, 1, 6, 4, 1, 6, 2, 3, 6, 3, 4, 1, 3, 5, 2, 1, 2, 2, 3, 4, 4, 3, 5, 6, 2, 1, 5, 1, 5, 6, 3, 5]


## Analyze the results


```python
# Create a D6.
die = Die()

# Make some rolls, and store results in a list.
results = []
for roll_num in range(1000):
    result = die.roll()
    results.append(result)

# Analyze the results.
frequencies = []
for value in range(1, die.num_sides+1):
    frequency = results.count(value)
    frequencies.append(frequency)

print(frequencies)
```

    [159, 155, 176, 158, 166, 186]


## Make a histogram


```python
from plotly.graph_objs import Bar, Layout
from plotly import offline

# Create a D6.
die = Die()

# Make some rolls, and store results in a list.
results = []
for roll_num in range(1000):
    result = die.roll()
    results.append(result)

# Analyze the results.
frequencies = []
for value in range(1, die.num_sides+1):
    frequency = results.count(value)
    frequencies.append(frequency)
    
# Visualize the results.
x_values = list(range(1, die.num_sides+1))
data = [Bar(x=x_values, y=frequencies)]

x_axis_config = {
    'title': 'Result'
    }
y_axis_config = {'title': 'Frequency of Result'}
my_layout = Layout(title='Results of rolling one D6 1000 times',
                   xaxis=x_axis_config, yaxis=y_axis_config)
offline.plot({
    'data': data,
    'layout': my_layout
    },
    filename='d6.html')
```

Then we can get a [`d6.html`](/webpages/2024-08-26/d6.html) which shows an interactive chart.

## Roll two D6 dices

Roll two D6 dices and calculate the sum of the two dice for each roll.


```python
from plotly.graph_objs import Bar, Layout
from plotly import offline

# Create two D6 dice.
die_1 = Die()
die_2 = Die()

# Make some rolls, and store results in a list.
results = []
for roll_num in range(1000):
    result = die_1.roll() + die_2.roll()
    results.append(result)

# Analyze the results.
frequencies = []
max_result = die_1.num_sides + die_2.num_sides
for value in range(2, max_result+1):
    frequency = results.count(value)
    frequencies.append(frequency)

# Visualize the results.
x_values = list(range(2, max_result+1))
data = [Bar(x=x_values, y=frequencies)]

x_axis_config = {
    'title': 'Result',
    'dtick': 1
    }
y_axis_config = {'title': 'Frequency of Result'}
my_layout = Layout(title='Results of rolling two D6 dice 1000 times',
                   xaxis=x_axis_config, yaxis=y_axis_config)
offline.plot({
    'data': data,
    'layout': my_layout
    },
    filename='d6_d6.html')
```

The resulting interactive chart can be found in [`d6_d6.html`](/webpages/2024-08-26/d6_d6.html).

When there are more bars on the histogram, Plotly will only label some of them on the x-axis by default. The `dtick` key in the `x_axis_config` dictionary controls the spacing between tick marks on the x-axis, and here the `'dtick': 1` setting tells Plotly to label every tick mark.

## Roll a D6 and a D10 dice

Roll a D6 and a D10 dice each time, and calculate the sum of the two dices for each roll.


```python
from plotly.graph_objs import Bar, Layout
from plotly import offline

# Create a D6 and a D10.
die_1 = Die()
die_2 = Die(10)

# Make some rolls, and store results in a list.
results = []
for roll_num in range(50_000):
    result = die_1.roll() + die_2.roll()
    results.append(result)
    
# Analyze the results.
frequencies = []
max_result = die_1.num_sides + die_2.num_sides
for value in range(2, max_result+1):
    frequency = results.count(value)
    frequencies.append(frequency)

# Visualize the results.
x_values = list(range(2, max_result+1))
data = [Bar(x=x_values, y=frequencies)]

x_axis_config = {
    'title': 'Result',
    'dtick': 1
    }
y_axis_config = {'title': 'Frequency of Result'}
my_layout = Layout(title='Results of rolling a D6 and a D10 50000 times',
                   xaxis=x_axis_config, yaxis=y_axis_config)
offline.plot({
    'data': data,
    'layout': my_layout
    }, 
    filename='d6_d10.html')
```

Then we’ll get [`d6_d10.html`](/webpages/2024-08-26/d6_d10.html). We can fine that instead of one most likely result, there are five at this time.

<br>

# Label global earthquake information in a map

> The CSV files used in the following code can be got from GitHub repo[^3].

In the following text, we’ll make a map showing the global distribution of earthquakes and how significant each one was.

## Examine JSON data

The file `eq_1_day_m1.json` stores the information that we’re interested in, such as earthquake magnitudes and locations. However, the file is dense and hence not that readable. We could first reformat the file to a new file `readable_eq_data.json` by `dump()` function provided by `json` module:


```python
import json

# Explore the structure of the data.
filename = 'data/eq_data_1_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

readable_file = 'data/readable_eq_data.json'
with open(readable_file, 'w') as f:
    json.dump(all_eq_data, f, indent=4)
```

The generated `readable_eq_data.json` file is like:

```json
{
    "type": "FeatureCollection",
    "metadata": {
        "generated": 1550361461000,
        "url": "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_day.geojson",
        "title": "USGS Magnitude 1.0+ Earthquakes, Past Day",
        "status": 200,
        "api": "1.7.0",
        "count": 158
    },
    "features": [
        {
            "type": "Feature",
            "properties": {
                "mag": 0.96,
                "place": "8km NE of Aguanga, CA",
                "time": 1550360775470,
                "updated": 1550360993593,
                "tz": -480,
                "url": "https://earthquake.usgs.gov/earthquakes/eventpage/ci37532978",
                "detail": "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ci37532978.geojson",
                "felt": null,
                "cdi": null,
                "mmi": null,
                "alert": null,
                "status": "automatic",
                "tsunami": 0,
                "sig": 14,
                "net": "ci",
                "code": "37532978",
                "ids": ",ci37532978,",
                "sources": ",ci,",
                "types": ",geoserve,nearby-cities,origin,phase-data,",
                "nst": 32,
                "dmin": 0.02648,
                "rms": 0.15,
                "gap": 37,
                "magType": "ml",
                "type": "earthquake",
                "title": "M 1.0 - 8km NE of Aguanga, CA"
            },
            "geometry": {
                "type": "Point",
                "coordinates": [
                    -116.7941667,
                    33.4863333,
                    3.22
                ]
            },
            "id": "ci37532978"
        },
        // ...
    ],
    "bbox": [
        -176.7088,
        -30.7399,
        -1.16,
        164.5151,
        69.5346,
        249.4
    ]
}
```

The first part of the file includes a section with the key `"metadata"`. This introduces when the data file was generated and where we can find the data online.

This <i class="term">geoJSON file</i> has a structure that’s helpful for <i class="emphasize">location-based data</i>. The information is stored in a list associated with the key `"features"`. Because this file contains earthquake data, the data is in list form where every item in the list corresponds to a single earthquake. This structure might look confusing, but it’s quite powerful, allowing geologists to store as much information as they need to in a dictionary about each earthquake, and then stuff all those dictionaries into one big list.

Note about the convention of `"coordinates"` in `"geometry"`: when we talk about locations, we often say the location’s <i class="emphasize">latitude first</i>, followed by the longitude. This convention probably arose because <i class="emphasize">humans discovered latitude long before we developed the concept of longitude</i>. However, many geospatial frameworks list the <i class="emphasize">longitude first</i> and then the latitude, because this corresponds to the `(x, y)` convention we use in mathematical representations. The geoJSON format follows this kind of `(longitude, latitude)` convention, and if we use another framework it’s important to learn what convention that framework follows.

## Make a list of all earthquakes

We can make a list that contains all the information about every earthquake that occurred by taking the data associated with the key `'features'` and store it in `all_eq_dicts`. 


```python
import json
# Explore the structure of the data.
filename = 'data/eq_data_1_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

print(all_eq_data.keys())

all_eq_dicts = all_eq_data['features']
print(all_eq_dicts[0].keys())
print(all_eq_dicts[0]['properties'].keys())
print(len(all_eq_dicts))
```

    dict_keys(['type', 'metadata', 'features', 'bbox'])
    dict_keys(['type', 'properties', 'geometry', 'id'])
    dict_keys(['mag', 'place', 'time', 'updated', 'tz', 'url', 'detail', 'felt', 'cdi', 'mmi', 'alert', 'status', 'tsunami', 'sig', 'net', 'code', 'ids', 'sources', 'types', 'nst', 'dmin', 'rms', 'gap', 'magType', 'type', 'title'])
    158

## Extract magnitude and location data of each earthquake


```python
import json

# Explore the structure of the data.
filename = 'data/eq_data_1_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

all_eq_dicts = all_eq_data['features']
print(len(all_eq_dicts))

mags, lons, lats = [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag'] # magnitude
    lon = eq_dict['geometry']['coordinates'][0] # longitude
    lat = eq_dict['geometry']['coordinates'][1] # latitude
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)

print(mags[:10])
print(lons[:5])
print(lats[:5])
```

    158
    [0.96, 1.2, 4.3, 3.6, 2.1, 4, 1.06, 2.3, 4.9, 1.8]
    [-116.7941667, -148.9865, -74.2343, -161.6801, -118.5316667]
    [33.4863333, 64.6673, -12.1025, 54.2232, 35.3098333]


## Build a world map


```python
import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data.
filename = 'data/eq_data_1_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

all_eq_dicts = all_eq_data['features']
print(len(all_eq_dicts))

mags, lons, lats = [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag']
    lon = eq_dict['geometry']['coordinates'][0]
    lat = eq_dict['geometry']['coordinates'][1]
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)


# Map the earthquakes.
data = [Scattergeo(lon=lons, lat=lats)]
my_layout = Layout(title='Global Earthquakes')

fig = {
    'data': data,
    'layout': my_layout
    }
offline.plot(fig, filename='global_earthquakes.html')
```

    158

We import the `Scattergeo` chart type, and create the `Scattergeo` object inside the list `data`. A `Scattergeo` chart type allows us to overlay a scatter plot of geographic data on a map. In the simplest use of this chart type, all need is to provide a list of longitudes and a list of latitudes. Finally, the resulting earthquake map is [`global_earthquakes.html`](/webpages/2024-08-26/global_earthquakes.html).

## A different way of specifying chart data

Although we can specify the `data` for a Plotly chart using the above syntax, i.e.

```python
data = [Scattergeo(lon=lons, lat=lats)]
```

which indeed is one of the simplest ways to define the data, it’s not the best way when we want to customize the presentation in more detail. Instead, following equivalent way is more preferable to configure the chart:

```python
data = [{
    'type': 'scattergeo',
    'lon': lons,
    'lat': lats,
    }]
```

In this approach, all the information about the data is structured as key-value pairs in a dictionary. This format allows us to specify customizations more easily than the previous one.

## Customize marker size

We can use different marker sizes, associated with the magnitude of each earthquake, to communicate the severity of a earthquake, making viewers to immediately see where the most significant earthquakes occur in the world.


```python
import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data.
filename = 'data/eq_data_1_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

all_eq_dicts = all_eq_data['features']
print(len(all_eq_dicts))

mags, lons, lats = [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag']
    lon = eq_dict['geometry']['coordinates'][0]
    lat = eq_dict['geometry']['coordinates'][1]
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)


# Map the earthquakes.
data = [{
    'type': 'scattergeo',
    'lon': lons,
    'lat': lats,
    'marker': {
        'size': [5*mag for mag in mags],
    },
}]
my_layout = Layout(title='Global Earthquakes')

fig = {
    'data': data,
    'layout': my_layout
    }
offline.plot(fig, filename='global_earthquakes1.html')
```

After running the script, we’ll get a Plotly chart [`global_earthquakes1.html`](/webpages/2024-08-26/global_earthquakes1.html).

## Customize marker colors

We can also customize each marker’s color to provide some classification to the severity of each earthquake. Plotly <i class="term">colorscales</i> help us to do this. To better show the advantages of using a colorscale, we’ll use the file `eq_data_30_day_m1.json` instead in the following text. This file includes earthquake data for a longer time horizon, i.e. 30-day period.

Here’s how to use a colorscale to represent the magnitude of each earthquake:


```python
import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data.
filename = 'data/eq_data_30_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

all_eq_dicts = all_eq_data['features']
print(len(all_eq_dicts))

mags, lons, lats = [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag']
    lon = eq_dict['geometry']['coordinates'][0]
    lat = eq_dict['geometry']['coordinates'][1]
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)


# Map the earthquakes.
data = [{
    'type': 'scattergeo',
    'lon': lons,
    'lat': lats,
    'marker': {
        'size': [5*mag for mag in mags],
        'color': mags,
        'colorscale': 'Viridis',
        'reversescale': True,
        'colorbar': {'title': 'Magnitude'},
    },
}]
my_layout = Layout(title='Global Earthquakes')

fig = {
    'data': data,
    'layout': my_layout
    }
offline.plot(fig, filename='global_earthquakes2.html')
```

    6274

All the significant changes here occur in the `'marker'` dictionary. The `'color'` setting tells Plotly what values it should use to determine where each marker falls on a colorscale. We use the `mags` list to determine the color. The `'colorscale'` setting tells Plotly which range of colors to use: `'Viridis'` is a colorscale that <i class="emphasize">ranges from dark blue to bright yellow </i>and works well for this data set. We set `'reversescale'` to `True`, to use bright yellow for the lowest values and dark blue for the most severe earthquakes. The `'colorbar'` setting allows us to control the appearance of the colorscale shown on the side of the map. Here we just title the colorscale `'Magnitude'`. The corresponding chart is in [`global_earthquakes2.html`](/webpages/2024-08-26/global_earthquakes2.html).

Besides above `'Viridis'`, there are some other available built-in colorscales that we can choose. Plotly defines the colorscales in the dictionary `PLOTLY_SCALES` of `colors` module, so we can obtain the name of colorscales by printing the keys in the dictionary:


```python
from plotly import colors

for colorscale in colors.PLOTLY_SCALES.keys():
    print(colorscale)
```

    Greys
    YlGnBu
    Greens
    YlOrRd
    Bluered
    RdBu
    Reds
    Blues
    Picnic
    Rainbow
    Portland
    Jet
    Hot
    Blackbody
    Earth
    Electric
    Viridis
    Cividis

And, we can get the charts with every colorscale by putting the preceding code into a `for` loop:

```python
import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data.
filename = 'data/eq_data_30_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

all_eq_dicts = all_eq_data['features']
print(len(all_eq_dicts))

mags, lons, lats = [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag']
    lon = eq_dict['geometry']['coordinates'][0]
    lat = eq_dict['geometry']['coordinates'][1]
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)


from plotly import colors

for colorscale in colors.PLOTLY_SCALES.keys():
    # Map the earthquakes.
    data = [{
        'type': 'scattergeo',
        'lon': lons,
        'lat': lats,
        'marker': {
            'size': [5*mag for mag in mags],
            'color': mags,
            'colorscale': colorscale,
            'reversescale': True,
            'colorbar': {'title': 'Magnitude'},
        },
    }]
    my_layout = Layout(title=f'Global Earthquakes ({colorscale})')

    fig = {
        'data': data,
        'layout': my_layout
        }
    offline.plot(fig, filename=f'global_earthquakes2_{colorscale}.html')
```

Corresponding charts are respectively:

- Greys, [`global_earthquakes2_Greys.html`](/webpages/2024-08-26/global_earthquakes2_Greys.html)
- YlGnBu, [`global_earthquakes2_YlGnBu.html`](/webpages/2024-08-26/global_earthquakes2_YlGnBu.html)
- Greens, [`global_earthquakes2_Greens.html`](/webpages/2024-08-26/global_earthquakes2_Greens.html)
- YlOrRd, [`global_earthquakes2_YlOrRd.html`](/webpages/2024-08-26/global_earthquakes2_YlOrRd.html)
- Bluered, [`global_earthquakes2_Bluered.html`](/webpages/2024-08-26/global_earthquakes2_Bluered.html)
- RdBu, [`global_earthquakes2_RdBu.html`](/webpages/2024-08-26/global_earthquakes2_RdBu.html)
- Reds, [`global_earthquakes2_Reds.html`](/webpages/2024-08-26/global_earthquakes2_Reds.html)
- Blues, [`global_earthquakes2_Blues.html`](/webpages/2024-08-26/global_earthquakes2_Blues.html)
- Picnic, [`global_earthquakes2_Picnic.html`](/webpages/2024-08-26/global_earthquakes2_Picnic.html)
- Rainbow, [`global_earthquakes2_Rainbow.html`](/webpages/2024-08-26/global_earthquakes2_Rainbow.html)
- Portland, [`global_earthquakes2_Portland.html`](/webpages/2024-08-26/global_earthquakes2_Portland.html)
- Jet, [`global_earthquakes2_Jet.html`](/webpages/2024-08-26/global_earthquakes2_Jet.html)
- Hot, [`global_earthquakes2_Hot.html`](/webpages/2024-08-26/global_earthquakes2_Hot.html)
- Blackbody, [`global_earthquakes2_Blackbody.html`](/webpages/2024-08-26/global_earthquakes2_Blackbody.html)
- Earth, [`global_earthquakes2_Earth.html`](/webpages/2024-08-26/global_earthquakes2_Earth.html)
- Electric, [`global_earthquakes2_Electric.html`](/webpages/2024-08-26/global_earthquakes2_Electric.html)
- Viridis, [`global_earthquakes2_Viridis.html`](/webpages/2024-08-26/global_earthquakes2_Viridis.html)
- Cividis, [`global_earthquakes2_Cividis.html`](/webpages/2024-08-26/global_earthquakes2_Cividis.html)

Go a step further, take colorscale `'Rainbow'` we can see how a colorscale is defined.

```python
print(colors.PLOTLY_SCALES['Rainbow'])
```

```
[[0, 'rgb(150,0,90)'], [0.125, 'rgb(0,0,200)'], [0.25, 'rgb(0,25,255)'], [0.375, 'rgb(0,152,255)'], [0.5, 'rgb(44,255,150)'], [0.625, 'rgb(151,255,0)'], [0.75, 'rgb(255,234,0)'], [0.875, 'rgb(255,111,0)'], [1, 'rgb(255,0,0)']]
```

As can be seen, a colorscale has a <i class="term">beginning color</i> and an <i class="term">end color</i>, and some scales have one or more <i class="term">intermediate colors</i> defined as well. Plotly <i class="emphasize">interpolates shades</i> between each of these defined colors.

## Add hover text

Finally, we can add some informative text that appears when we hover over the marker representing an earthquake. In addition to showing the longitude and latitude, which appear by default, we’ll show the magnitude and provide a description of the approximate location as well.


```python
import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data.
filename = 'data/eq_data_30_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

all_eq_dicts = all_eq_data['features']
print(len(all_eq_dicts))

mags, lons, lats, hover_texts = [], [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag']
    lon = eq_dict['geometry']['coordinates'][0]
    lat = eq_dict['geometry']['coordinates'][1]
    title = eq_dict['properties']['title']
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)
    hover_texts.append(title)


# Map the earthquakes.
data = [{
    'type': 'scattergeo',
    'lon': lons,
    'lat': lats,
    'text': hover_texts,
    'marker': {
        'size': [5*mag for mag in mags],
        'color': mags,
        'colorscale': 'Viridis',
        'reversescale': True,
        'colorbar': {'title': 'Magnitude'},
    },
}]
my_layout = Layout(title='Global Earthquakes')

fig = {
    'data': data,
    'layout': my_layout
    }
offline.plot(fig, filename='global_earthquakes3.html')
```

Then we have [`global_earthquakes3.html`](/webpages/2024-08-26/global_earthquakes3.html).

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 323-331, 347-358.
[^2]: [Plotly Python Graphing Library](https://plotly.com/python/).
[^3]: [pcc\_2e/chapter\_16/mapping\_global\_data_sets/data at master · ehmatthes/pcc\_2e](https://github.com/ehmatthes/pcc_2e/tree/master/chapter_16/mapping_global_data_sets/data).

