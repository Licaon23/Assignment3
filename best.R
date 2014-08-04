############################ FUNCTION BEST #########################################
##
## This function returns the best hospital name in the state for a given outcome,
## according to its mortality rate for that outcome.
##
## Arguments:
##      - state: two-letter string, abbreviation for the state, like "TX" or "NY".
##      - outcome: string value: "heart attack", "heart failure" or "pneumonia".
##
###################################################################################3

best <- function (state,outcome) {
        ## Load funcition readData.R needed and get a clean data frame.
        source("readData.R")
        cleanData <- readData(outcome)
        
        ## Write state argument with uppercase letters
        state<-toupper(state) 
        
        ## Check if the state's name is valid.
        if(sum(levels(cleanData$State)==state) == 0) stop("invalid state")
        
        ## From clean data set, subset those hospitals from the given state.
        stateData<-cleanData[cleanData$State==state,]

        ## Sort the hospitals in ascending order acording to its mortality
        ## rate value, and in case ties, in alphabetic order.
        stateData <- stateData[order(stateData[[3]],stateData[[1]]),]
        
        ## Print the name of the best hospital (the one in the first row)
        print(stateData[1,1])
        
}





