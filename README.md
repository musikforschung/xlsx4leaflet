<details>

<summary>us English version (click here)</summary>

[Leaflet] (https://github.com/Leaflet/Leaflet) is an open-source JavaScript library for interactive maps. This template is used to collect and publish research data from smaller projects in tabular form. Using catmandu, JavaScript arrays for integration into Leaflet are generated from the xlsx file. Additionally, a CSV file is created for publishing the data, for example, on Zenodo.

# Currently supported data fields
* id (string, URI)
* preferredName (string))
* entityType (string (person/place/organisation/event)
* label (string)
address
* country (string)
* street (string)
* streetNumber (string)
* addressSource (string (string (text,url,date))
coordinates
* latitude (decimal degrees - WGS84)
* longitude (decimal degrees - WGS84)
* coordinatesSource (string (string (text,url,date))
* dateOfEstablishment (string)
* dateOfEstablishmentSource (string (text,url,date))
* dateOfTermination (string)
* dateOfTerminationSource (string (text,url,date))
* dateOfEvent (string)
* dateOfEventSource (string (text/URL,date))
* sameAsName (string)
* sameAsURL (string/URL)
* biographicalOrHistoricalInformation (string)
* biographicalOrHistoricalInformationSource (string (text,url,date)) 
* depictionName (string (directory path/URL)
* depictionFormat (string (jpg or png))
* depictionWidth (integer (pixel))
* depictionHighth (integer (pixel))
* depictionText (string)
* depictionCeator (string)
* depictionPublisher (string)
* depictionSource (string, directory path/URL)
* depictionLicense (string)
* depictionLicenseURI (string, URI)


# Author

René Wallor, wallor at sim.spk-berlin.de


</details>