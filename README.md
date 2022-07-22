# MusicApp

The app gets TOP 100 music albums in the US. 

# Architecture
In this projects MVVM architecture is prefered to handle both network and local db datas.

# UI Elements
There is no any storyboard and xib files for ui design. All interface has done by programatically.

# Network Layer & Local DB
In this project url session is prefered for network layer. We have Core layer to make network operation and decoding data with T type. 

For local db CoreData is used. If there is no network connection datas will come over database.
