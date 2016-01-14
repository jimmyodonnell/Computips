get_busy <- function(
  filename, # path to CSV file
  entity, # column name giving e.g. "participant"
  start_date, # "YYYY-MM-DD"
  end_date, # "YYYY-MM-DD"
  conflict_start, # column name of start of conflict
  conflict_end # column name of end of conflict
)
{
  busy_blocks_df <- read.csv(file = filename, stringsAsFactors = FALSE, row.names = NULL)

  date_range <- seq(from = as.Date(start_date), to = as.Date(end_date), by = 1)
  
  entities <- busy_blocks_df[,entity]
  
  busy_dates <- list()
  
  for(participant in unique(entities)){
    
    part_block <- busy_blocks_df[
      busy_blocks_df[,entity] == participant, 
      c(conflict_start, conflict_end)
    ]
    
    busy_dates[[participant]] <- vector("character")
    
    for(busy_block in 1:nrow(part_block)){

      busy_range <- as.Date(as.character(part_block[busy_block,]))
      
      busy_block_dates <- as.character(seq(from = busy_range[1], to = busy_range[2], by = 1))
      
      busy_dates[[participant]] <- c(busy_dates[[participant]], busy_block_dates)
      
    }
    
    busy_dates[[participant]] <- as.Date(busy_dates[[participant]])
    
  }
  
  busy_dates
  
  availability <- do.call(cbind, lapply(busy_dates, function(x) !(date_range %in% x)))
  
  rownames(availability) <- as.character(date_range)
  
  return(availability)
  
}

# avail <- get_busy(
#   filename = "NIMBioS_meeting3_conflicts.csv", 
#   entity = "participant", 
#   start_date = "2016-05-01", 
#   end_date = "2017-01-31", 
#   conflict_start = "conflict_start", 
#   conflict_end = "conflict_end" # column name of end of conflict
# )

