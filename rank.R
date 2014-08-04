######################### #####FUNCTION RANK #######################################
##
## This function takes a clean and tidy data frame that returns readData.R function,
## for a specific state. Then, it sorts those hospitals according to the mortality
## rate for the outcome, adds a ranking colum and returns two strings:
##      - the hospital name which occupies the ranking position given by the "num"
##        argument.
##      - the name of the state
## 
## This is an example:
##
##              rank(stateData,4)
##              [1] "DETAR HOSPITAL NAVARRO" "TX"
## Arguments:
##      - statedata: dataframe. Type of dataframe returned by readData function
##              but only for a specific state.
## 
##      - num: number between 1 and the total number of hospitals in the state.
##              by default, its value is the string "best", which means that the
##              top 1 hospital is the one to be retuned. It also can take the
##              string "worst", which select and return the worst hospital.
###################################################################################

rank<-function(stateData,num) {
        
        ## Get a string of the State name where hospitals belong to.
        ## Because in the state column there is the same state symbol,
        ## first row value for this column has been chosen.
        
        stateName <- as.character(stateData[1,"State"])
        
        ## Sort the hospitals in ascending order acording to its mortality
        ## rate value, and in case ties, in alphabetic order.
        
        stateData <- stateData[order(stateData[[3]],stateData[[1]]),]
        
        ## Add a new column with a sequence from 1 to the last hospital number
        ## as a ranking.
        
        ranked_stateData <- cbind(stateData, rank=seq_len(nrow(stateData)))
        
        ## Check if num argument is a number. If it can be one of the rank numbers
        ## select the hospital name in that ranking position and the state name,
        ## and return that pair of strings in a character vector.
        ## Otherwise, num can't be a rank number, so return a vector with NA
        ## and the state name.
        
        if((class(num)=="numeric")){ 
                if(num < nrow(ranked_stateData)) {
                        return(c(ranked_stateData[ranked_stateData$rank==num,
                                                 "Hospital.name"],stateName))
                } else {return(c("<NA>",stateName))}
        }
        
        ## If num value is "best", the hospital name to be selected is the top 1
        ## in the ranking position. Otherwise, it means that the hospital name to be selected is the worst,
        ## it is the one in the last row.
        
        if(num=="best") {
                return(c(ranked_stateData[1,1],stateName))
         
        } else {
                return(c(ranked_stateData[nrow(ranked_stateData),1],stateName))
        }
}
        