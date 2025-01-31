#!/bin/bash
# Generated with ChatGPT

URL="http://webdb.mhostettler.net4255.luxbulb.org/" 
CONCURRENT_REQUESTS=50           
DURATION=60                    

echo "Spamming $URL with $CONCURRENT_REQUESTS concurrent requests for $DURATION seconds..."

start_time=$(date +%s)
end_time=$((start_time + DURATION))

while [ $(date +%s) -lt $end_time ]; do
    for ((i = 1; i <= CONCURRENT_REQUESTS; i++)); do
        curl -s -o /dev/null -w "%{http_code}\n" $URL &
    done
    wait  # Wait for all requests to complete before starting next batch
done

echo "Spam test completed!"
