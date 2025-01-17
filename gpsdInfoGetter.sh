#!/bin/bash

# Configuration
WEB_DIR="/var/www/html"                 # Adjust this path as needed
obfuscate_location="yes"                # Set to !yes for full precision. jq required for obfuscation. 

# Capture TPV (Time-Position-Velocity) data
/usr/local/bin/gpspipe -w -n 15 | grep -m 1 '"class":"TPV"' > "${WEB_DIR}/gps-tpv.json.tmp"

# If obfuscation is enabled, process the JSON
if [ "$obfuscate_location" = "yes" ]; then
    # Use jq to process the JSON
    # Round lat/lon to 2 decimal places and ECEF coordinates to nearest 10000
	jq '(.lat, .lon) |= (. * 100 | floor | . / 100) | (.ecefx, .ecefy, .ecefz) |= (. / 10000 | floor | . * 10000)
    ' "${WEB_DIR}/gps-tpv.json.tmp" > "${WEB_DIR}/gps-tpv.json"
else
    # If no obfuscation, just move the file
    mv "${WEB_DIR}/gps-tpv.json.tmp" "${WEB_DIR}/gps-tpv.json"
fi

# Capture SKY (Satellite) data
/usr/local/bin/gpspipe -w -n 15 | grep -m 1 '"class":"SKY"' > "${WEB_DIR}/gps-sky.json"

# Clean up temporary file if it exists
rm -f "${WEB_DIR}/gps-tpv.json.tmp"

# Set appropriate permissions
chmod 644 "${WEB_DIR}/gps-tpv.json" "${WEB_DIR}/gps-sky.json"

exit
