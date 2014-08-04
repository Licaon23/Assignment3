######################### FUNCTION RANKHOSPITAL ##################################
##
## This function takes the clean and tidy data frame that returns readData.R function
## and subset those from a given state. Then, it sorts those hospitals according to
## the mortality rate for the outcome, adds a ranking colum and returns the hospital
## name which occupies the ranking position given by the "num" argument. 
## This is an example:
##
##              > rankhospital("TX","heart failure",4)
##              [1] "DETAR HOSPITAL NAVARRO"
## Arguments:
##      - state: string. Abbreviation of the state.
##      - outcome: string. "heart attack","heart failure", "pneumonia".
##      - num: number between 1 and the total number of hospitals in the state.
##              by default, its value is the string "best", which means that the
##              top 1 hospital is the one to be retuned. It also can take the
##              string "worst", which select and return the worst hospital.
###################################################################################

rankhospital <- function(state, outcome, num="best"){
        
        ## Check if the num argument is valid
        if(num!="best" && num!="worst" && class(num)!="numeric") {
                stop("invalid num")
        }
        
        ## Load readData.R function to get a clean data set
        source("readData.R")
        cleanData <- readData(outcome)
        
        ## Write state argument with uppercase letters, and check if it is valid.
        state <- toupper(state)
        if(sum(levels(cleanData$State)==state) == 0) stop("invalid state")
        
        ## From the clean dataframe, subset those hospitals in the given state
        stateData<-cleanData[cleanData$State==state,]
        
        ## Sort the hospitals in ascending order acording to its mortality
        ## rate value, and in case ties, in alphabetic order.
        stateData <- stateData[order(stateData[[3]],stateData[[1]]),]
        
        ## Add a new column with a sequence from 1 to the last hospital number
        ## as a ranking.
        ranked_stateData <- cbind(stateData, rank=seq_len(nrow(stateData)))
        
        ## Check if num argument is a number.If it is rank number, return the 
        ## Hospital name in that ranking position; otherwise, return a NA value
        if((class(num)=="numeric")){ 
                if(num < nrow(ranked_stateData)) {
                        return(ranked_stateData[ranked_stateData$rank==num,"Hospital.name"])
                        
                } else {return(NA)}
        }
        
        ## If num argument is "best", return the best hospital name, it is the
        ## top one in the ranking column. Otherwise, num argument will be "worse"
        ## and in that case, return the worse hospital name, which is the one
        ## in the last row of dataframe.
        if(num=="best") {
                return(ranked_stateData[1,1])
                      
        } else {
                return(ranked_stateData[nrow(ranked_stateData),1])
        }
}
        