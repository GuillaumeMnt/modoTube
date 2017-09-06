# modoTube #

## Informations ##
modoTube is an iOS YouTube client, you can search videos, channels, playlist and see it.

When you download this project, don't forget to pod install.

You only have to use a YouTube key available on the website developer of YouTube for fetch information.
--> https://console.developers.google.com/projectselector/apis/credentials <-- link to get your API key

when you get your key : go on modoTube/Common/Environment.swift and fill YoutubeAPI enum
  youtubeAPI.Keys.secret = youtubeKey

Your Key is private so, don't share it ;)

This project is in swift3 and available for iOS 9.

## Project ##
modoTube is one of my first iOS project, in this project, I learnt :
  - Organisation
      - MVC (Model View Controller)
      - Project organisation
  - Functionality
      - life cycle (app Delegate)
      - tableView (implementation of delegate / dataSource)
      - segmentedControl / button / label
      - use of Pod
      - use of webService (youtube API)
      - completion handler (check an internet connection)
      - parsing
      - translations
  - UI
      - splashScreen
      - icon
      - constraint
      - popup / alert
      - custom cell (tableView cell)
      - and more ... 
     
Why don't you install the app and check it out ? ;)

my LinkedIn : https://www.linkedin.com/in/guillaume-monot-6965b1133?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base%3BtpNJZoFGQIGEtZBrk2F4cg%3D%3D
