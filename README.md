## ASSIGNMENT 3. HOSPITAL QUALITY
---------------------------------

This is the last of the three projects that we've been assigned in this R programming course.
The dataset we'll be working with is real, from a US webpage.

The file *outcome-of-care-measures.csv* contains information about 30-day mortality and readmission rates for heart attacks, heart failure and pneumonia for over 4000 US hospitals.

The following functions have been created to deal with this big dataset and extract some usefull information according to some inputs.

* **readData.R**: this function reads the raw dataset and returns a more tidy one, only with the columns that we migh be interested in.
* **best.R** : this function reads this more clean dataset given by the readData function and return the name of the hospital with the best 30-day mortality rate for a certain outcome and in a given state.
* **rankhospitals.R** : this function sorts the hospitals according to its 30-mortality rate for a certain outcome and returns the hospital name in the specified ranking position.
* **rankall.R**: retrns a dataframe with the hospital name in a specified ranking position for each one of the states.
* **rank.R** : support function that is called in rankall.R. It does more or less the same than hospitalrank.R, but it returns a character vector with the hospital name and the state where it is.

For more details, a deeper explanation can be  found in the R code.
