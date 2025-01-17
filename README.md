## gpsdWebViewer 
### Why
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

### Theory of operation
There are two components:
- A bash script that runs periodically, using [gpspipe](https://gpsd.io/gpspipe.html) to dump information to JSON files, and process them if needed (e.g. obfuscation)
- An HTML file (and css styles file) to display the contents of those JSON files

### Installation and use
- Prerequisites: gpsd and a web server running on linux (other OSs may work, gpsd is the limiting factor here)
- Put `index.html` and `styles.css` into a directory readable by your web server
- Put `gpsdInfoGetter.sh` wherever you want
- Edit `gpsdInfoGetter.sh` with the location of the directory you put `index.html` into
- Note: If you want to obfuscate your location, leave `obfuscate_location="yes"`[^1].
- Run `gpsdInfoGetter.sh` to verify it creates and populates `gps-tpv.json` and `gps-sky.json` as expected.
- Set up a cron job to run the getter script automatically. (I like this [crontab generator](https://crontab-generator.org).)
- Browse to your web endpoint and enjoy!

[^1]: Location obfuscation is done in the info-getter script so that precise location information is never stored. When clients load `index.html`, they also load `gps-tpv.json` and `gps-sky.json`, so we edit this json the moment we pull it from gpsd.
