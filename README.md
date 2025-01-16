## gpsdWebViewer 
The purpose of this project is to develop a replacement for the outdated and abandoned [gpsd.php](https://gitlab.com/gpsd/gpsd/-/blob/master/clients/gpsd.php.in?ref_type=heads) included with the [gpsd](https://gpsd.io/) project. It is intended for use on static systems using a GNSS receiver as a reference clock.

My goals are pretty straightfoward:
- Low impact to the host, suitable for something like a Raspberry Pi 2
- Clean looking, "modern"
- As few third party compnents as possible (none)
- Easy to understand and customize

My goals do not include:
- Anything approaching real time. I am making this for static applications.
- Performing analysis of the data. All I want to do is display data directly from gpsd output. Analytical outputs from `gpsprof` or `ntpviz` may be included in the future.
- Explicit mobile support
- Embedding third party components (e.g. OSM, google maps)

### Operation
There are two components:
- A bash script that runs periodically, using [gpspipe](https://gpsd.io/gpspipe.html) to dump information to JSON files, and process them if needed (e.g. obfuscation)
- An HTML file (and css styles file) to display the contents of those JSON files
