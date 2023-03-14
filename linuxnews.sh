#!/bin/bash

# Define an array of RSS feed URLs for each website
rss_feeds=(
    "https://www.linux.com/news/feed/"
    "https://www.linuxtoday.com/feed/"
    "https://www.phoronix.com/rss.php"
    "https://www.linuxjournal.com/node/feed"
    "https://www.omgubuntu.co.uk/feed"
    "https://fossbytes.com/feed/"
    "https://www.linux-magazine.com/rss/feed/lmi_full"
    "https://www.linuxinsider.com/perl/syndication/rssfull.pl"
    "https://www.howtoforge.com/rss-feed"
    "https://www.zdnet.com/topic/linux/rss.xml"
)

# Get the current date
today=$(date +%Y-%m-%d)


# Use curl to download the RSS feeds and grep to extract the story titles and links
for rss_feed in "${rss_feeds[@]}"; do
    curl -s "$rss_feed" | grep -E '(<title>|<link>)' | sed -e 's/<title>/\n&/g' | grep -v '<link>' | sed -e 's/<[^>]*>//g' | sed -e 's/^.*: //' | sed -e 's/ - Linux.com//' >> news-$today.txt
done

# Display the news on the terminal and prompt the user to select a headline
cat -n news-$today.txt
echo "Enter the number of the headline you want to read more about: "
read selection

# Check if the selection is valid
if ! [[ "$selection" =~ ^[0-9]+$ ]]; then
    echo "Invalid selection. Exiting."
    exit
fi

# Get the URL of the selected headline
url=$(sed "${selection}q;d" news-$today.txt | awk '{print $NF}')

# Open the URL in a web browser
xdg-open "$url"

# Mark the news as displayed for today
touch news-$today.txt
