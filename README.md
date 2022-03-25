# Leinster Golf Database Project

## Description
This repository represents the files used as part of a mySQL database project to represent an application of choice. The information system I have decided to model is based on the golfing community in the Leinster region. Within the golfing community, I have designed the following entities:

* Player
* Coach
* Club
* Course
* Round
* Shot

### Player
A player has a first name, last name, date of birth, handicap and player ID. The player ID is used to identify the specific player. A player’s handicap is an indication of how good a player is at golf.

### Coach
A coach has a first name, last name, a number of students (s)he teaches, his/her price per lesson and his/her unique coach ID which can be used to identify the specific coach.

### Round
For the sake of simplicity, my design assumes a round of golf consists of 18 holes, no more, no less. The attributes of a round are the number of greens in regulation, the gross score, the date played, the number of points scored and the unique round ID, which is used to identify the specific round. 

### Shot
A shot has the club used (for example a 5-iron), the shot type, the shot number, the hole the shot was taken on, and the round ID the shot corresponds to.

### Club
The club entity, which represents the society the player is a part of, is not to be confused with the shot’s club attribute, which specifies a specific golf club (for example a 5-iron). The attributes of the club entity are the unique club name, the number of members the club has, the membership fee and the county where the club is based. The logic to using the atomic county attribute as oppose to the composite location attribute is to adhere to table normalisation.

### Course
The course entity has a unique location code (an EIRCODE), the greenfees (cost to play a round), the slope (difficulty rating) and the course par (the number of shots it should take you to complete a round). The logic to using the atomic location code attribute as oppose to the composite location attribute is to adhere to table normalisation.

## Models
The models created in this project are:

* Entity Relationship (ER) Model 
* Relational Schema Model
* Functional Dependency Model

## mySQL Code
The mySQL code produced creates and implements this database using appropriate SQL techniques. The following features are included in the creation of this database through mySQL code:

* Entity Constraints (Primary Keys)
* Relational Constraints (Foreign Keys)
* Logical Constraints (e.g., Numerical values within a range)
* Triggers
* Views
* Roles and Permissions (Security)
* Custom Functions

## Repository Contents
The repository contains 2 main files:

* mySQL code
* Report of Database

Further information and details of this project can be seen in the report.
