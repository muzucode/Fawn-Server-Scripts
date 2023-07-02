# Retrieve the list of databases and their sizes
databases=$(mysql -u $user -p"$password" -e "SELECT table_schema AS 'DatabaseName', SUM(data_length + index_length) / 1024 / 1024 AS 'Size_MB' FROM information_schema.tables WHERE table_schema NOT IN ('information_schema', 'performance_schema', 'mysql') GROUP BY table_schema;" | awk 'NR>1 {printf (NR>2?",":"") "{\"DatabaseName\":\"%s\", \"Size_MB\":%.2f}", $1, $2}')

# Print the JSON array to stdout
echo "[$databases]"