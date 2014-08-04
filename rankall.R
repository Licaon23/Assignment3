############################### FUNCTION RANKALL ####################################
##
## This function takes one of the possible outcomes and a ranking position and returns
## a dataframe with the names of the hospitals in that position for all the states.
##
## This is an example:
##
##              > head(rankall("heart attack",20),10)
##                                              hospital state
##              1                                 <NA>    AK
##              2       D W MCMILLAN MEMORIAL HOSPITAL    AL
##              3    ARKANSAS METHODIST MEDICAL CENTER    AR
##              4  JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
##              5                SHERMAN OAKS HOSPITAL    CA
##              6             SKY RIDGE MEDICAL CENTER    CO
##              7              MIDSTATE MEDICAL CENTER    CT
##              8                                 <NA>    DC
##              9                                 <NA>    DE
##              10      SOUTH FLORIDA BAPTIST HOSPITAL    FL
## Arguments:
##      - outcome: string value: "heart attack", "heart failure" or "pneumonia".
## 
##      - num: number between 1 and the total number of hospitals in the state.
##              by default, its value is the string "best", which means that the
##              top 1 hospital is the one to be retuned. It also can take the
##              string "worst", which select and return the worst hospital.
###################################################################################

rankall <- function(outcome, num="best"){
        
        ## Check if num argument is valid.
        if(num!="best" && num!="worst" && class(num)!="numeric") {
                stop("invalid num")
        }
        
        ## Load readData.R and rank.R functions, which are necessary for
        ## the calculations
        
        source("readData.R")
        source("rank.R")
        
        ## Get a clean dataset using readData function.
        cleanData <- readData(outcome)
        
        ## Get list of vectors, one for each state. Each character vector
        ## contains to string: the hospital name in the given ranking position
        ## and the state's name.
        
        ## To achive that, clean dataframe is splited in different dataframes,
        ## on for each state. Over each state dataframe, function rank.R is 
        ## applied to get the name of the hospital in the given ranking posiion
        ## in that state.
        
        list <- lapply(split(cleanData,cleanData$State), rank,num=num)
        
        ## The list of vectors is reshaped in a matrix, whose rows contain data
        ## from each state, and the two columns store both the name of the hospital
        ## and the state's name.
        
        ranking <- matrix(unlist(list),nrow=length(list),byrow=TRUE)
        
        ## Matrix is converted into a dataframe, and proper column names are given
        ## to both of them.
        ranking <- data.frame(ranking)
        names(ranking) <- c("hospital","state")
        
        ## Return that ranking dataframe.
        ranking
}
        