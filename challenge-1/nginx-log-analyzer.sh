awk '($9 ~ /500/)' 01-access.log | awk '{print $7}' | sort | uniq -c | sort -r