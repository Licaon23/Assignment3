############################# FUNCTION READDATA ###################################
##
## This function takes as an argument one of the possible outcomes ("heart attack",
## "heart failure" or "pneumonia"), reads the raw hospital dataset and returns a
## more tidy and clean dataset, whit the hospital name, the state where it belongs
## and the outcome mortality rate for each hospital.
##
##                hospital.name  State  outcome.rate
##              1
##              2
##              3
##
###################################################################################

readData <- function (outcome) {
        
        ## Write outcome with lowercase letters, and state with uppercase.
        outcome <- tolower(outcome)
        
        
        ## Read Hospital quality dataset
        dataset <- read.csv("outcome-of-care-measures.csv",
                            colClasses="character")
        
        ## Set a vector with column number where possible outcome data are
        possible_outcomes <- c(11,17,23)
        names(possible_outcomes) <- c("heart attack","heart failure",
                                    "pneumonia")
        
        ## Check if arguments are valid
        if(sum(names(possible_outcomes) == outcome) == 0)stop("invalid outcome")
        
        ## Extract outcome data required and convert it to numeric class.
        interest_rate <- suppressWarnings(
                as.numeric(dataset[[possible_outcomes[outcome]]]))
        
        ## Convert states column to factor class
        State <- suppressWarnings(as.factor(dataset[[7]]))
        
        ## Create a dataframe with all the information: Hospital name, state
        ## and the mortality of the given outcome for each hospital.
        cleanData <- cbind(dataset[2],State,interest_rate)
        
        names(cleanData) <- c("Hospital.name","State",
                              paste(c(gsub(" ",".",outcome),"rate"),collapse="."))
        
        ## Take out the hospitals with missing data
        cleanData <- cleanData[complete.cases(cleanData),]
        
        cleanData
        
        
}

        
