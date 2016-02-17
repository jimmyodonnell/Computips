
# every non-alphanumeric character except white space or colon
[^a-zA-Z\d\s:]

# explanations:
\d - numeric class
\s - whitespace
a-zA-Z - matches all the letters
^ - negates them all - so you get - non numeric chars, non spaces and non colons

# every non-alphanumeric character
[^a-zA-Z\d]

