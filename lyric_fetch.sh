#!/bin/bash

manual_or_current="$(gum choose current manual)"

case $manual_or_current in
	"choose")
		track="$(gum input --placeholder 'track')"
		artist="$(gum input --placeholder 'artist')"
		album="$(gum input --placeholder 'album')"
		# duration="$(gum input --placeholder 'duration')"

		echo "Fetching $track by $artist"

		track="$(echo "$track" | sed -e 's/ /+/g')"
		artist="$(echo "$artist" | sed -e 's/ /+/g')"
		album="$(echo "$album" | sed -e 's/ /+/g')"


		curl "https://lrclib.net/api/get?artist_name=$artist&track_name=$track&album_name=$album" -o "$track-$artist.json" ;;

	"current")
		track="$(mpc --port 6601 current -f %title% | sed -e 's/ /+/g')"
		artist="$(mpc --port 6601 current -f %artist% | sed -e 's/ /+/g')"
		album="$(mpc --port 6601 current -f %album% | sed -e 's/ /+/g')"
		echo "$track" 
		echo "$artist"
		echo "$album" 
		curl "https://lrclib.net/api/get?artist_name=$artist&track_name=$track&album_name=$album" -o "$track-$artist.json" ;;
esac
