#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <script> <dir>"
    exit 1
fi

# Assign arguments to variables
SCRIPT=$1
DIR=$2

source ~db2inst2/sqllib/db2profile
db2 connect to cs348


for SQL_FILE in "$DIR"/Test*.sql; do
    # Extract the base name (Test[x])
    BASE_NAME=$(basename "$SQL_FILE" .sql)
    echo $SQL_FILE
    
    # Define the corresponding .txt and .txt files
    CLI_FILE="$DIR/$BASE_NAME.txt"
    EXPECTED_FILE="$DIR/${BASE_NAME}Expected.txt"
    OUTPUT_FILE="$DIR/${BASE_NAME}output.txt"

    # Check if the expected files exist
    if [[ -f "$SQL_FILE" && -f "$CLI_FILE" && -f "$EXPECTED_FILE" ]]; then

        db2 -f "$SQL_FILE"
        
        CLI_ARGS=$(cat "$CLI_FILE")
        

        ./"$SCRIPT" $CLI_ARGS > "$OUTPUT_FILE"

        DIFF=$(diff "$EXPECTED_FILE" "$OUTPUT_FILE")
        if [ "$DIFF" = "" ]
        then
            rm $OUTPUT_FILE
        else
            echo "$DIFF"
        fi
    else
        echo "${BASE_NAME}"
        echo "Missing files for $BASE_NAME, skipping..."
    fi
done

db2 -f Delete_Tables.sql

db2 disconnect cs348
