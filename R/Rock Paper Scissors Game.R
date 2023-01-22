# pao_ying_chub

pao_ying_chub <- function() {  
  # print game rules
  cat("Game Starts!!\n")
  cat("rock vs scissors: rock win!\n")
  cat("paper vs rock: paper win!\n")
  cat("scissors vs paper: scissors win!\n")
  cat("-------------------------------------------------")
  
  # define default
  user_score <- 0
  robot_score <- 0
  user_hand <- as.numeric(readline("Choose your move [1:rock, 2:paper, 3:scissors, 4:exit: "))
  
  # while loop
  while(user_hand < 4) {
    
    hands <- c("rock", "paper", "scissors")
    user <- hands[user_hand]
    robot <- sample(hands, 1)
    
    # check user_hand > 0
    if(user_hand > 0) {
      cat(paste("\n\nYou:", user,"\nRobot:", robot))
      
      # RULES
      # win
      if (user == "rock" & robot == "scissors" |
               user == "paper" & robot == "rock" |
               user == "scissors" & robot == "paper") {
        cat("\n\nYOU WIN!")
        user_score <- user_score + 1
        cat(paste("\n\nYour score: ", user_score))
        cat(paste("\nRobot Score: ", robot_score))
        cat("\n-------------------------------------------------")
      } 
      
      # lose
      else if (user == "rock" & robot == "paper" |
              user == "paper" & robot == "scissors" |
              user == "scissors" & robot == "rock") {
        cat("\n\nYOU LOSE!")
        robot_score <- robot_score + 1
        cat(paste("\n\nYour score: ", user_score))
        cat(paste("\nRobot Score: ", robot_score))
        cat("\n-------------------------------------------------")
      } 
      
      # draw
      else {
        cat("\n\nDRAW!")
        cat(paste("\n\nYour score: ", user_score))
        cat(paste("\nRobot Score: ", robot_score))
        cat("\n-------------------------------------------------")
      }  
    } else {
      cat("\nPlease select number between 1 and 4")
    }
    
    # input new user_hand
    user_hand <- as.numeric(readline("Choose your [1:rock, 2:paper, 3:scissors, 4:exit: "))
  } 
  
    # print result
    if (user_score > robot_score) {
        cat("\n\nYOU WIN!!")
    } else if (user_score < robot_score) {
        cat("\n\nYOU LOSE!!")
    } else {
        if(user_score == 0) {
            cat("\n\nEND.")
        } else {
            cat(paste("\n\nDRAW", user_score, "-", robot_score))
        }
    }
}
