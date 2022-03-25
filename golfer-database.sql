DROP TABLE IF EXISTS Facilitate;
DROP TABLE IF EXISTS Play;
DROP TABLE IF EXISTS Take;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Club;
DROP TABLE IF EXISTS Shot;
DROP TABLE IF EXISTS Round;
DROP TABLE IF EXISTS Coach;
DROP TABLE IF EXISTS Player;

CREATE TABLE IF NOT EXISTS Player (
	player_id int NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
	date_of_birth date,
    handicap double,
    PRIMARY KEY (player_id),
    CONSTRAINT check_handicap CHECK (handicap BETWEEN 0 AND 54)
);

INSERT INTO Player VALUES (1, 'John', 'Lennon', '2000-01-31', 18);
INSERT INTO Player VALUES (2, 'James', 'Rodrigo', '1990-05-31', 6);
INSERT INTO Player VALUES (3, 'Lee', 'Jones', '1998-12-31', 23);
INSERT INTO Player VALUES (4, 'Albert', 'Smith', '1950-08-26', 26);
INSERT INTO Player VALUES (5, 'Shane', 'Eager', '1982-03-31', 1);

ALTER TABLE Player
DROP COLUMN date_of_birth;

CREATE TABLE IF NOT EXISTS Coach (
	coach_id int NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    price_per_lesson double NOT NULL,
    number_of_students int,
    player_id_fk int NULL,
    PRIMARY KEY (coach_id),
    FOREIGN KEY (player_id_fk) REFERENCES Player(player_id),
	CONSTRAINT check_price_per_lesson CHECK (price_per_lesson BETWEEN 20 AND 100),
	CONSTRAINT check_number_of_students CHECK (number_of_students BETWEEN 0 AND 40)
);

INSERT INTO Coach VALUES (1, 'Tom', 'Jones', 50, 10, 1);
INSERT INTO Coach VALUES (2, 'Arnold', 'Palmer', 40, 8, 2);
INSERT INTO Coach VALUES (3, 'Robert', 'Hammer', 35, 2, 3);
INSERT INTO Coach VALUES (4, 'Ethan', 'Fitzpatrick', 44.99, 3, 2);
INSERT INTO Coach VALUES (5, 'Mark', 'Tumble', 34.99, 20, 5);
INSERT INTO Coach VALUES (6, 'Tom', 'Jones', 59.99, 40, 4);

CREATE TABLE IF NOT EXISTS Round (
	round_id int NOT NULL,				
	greens_in_regulation int,
    date_played date,
    gross_score double NOT NULL,
    points int NOT NULL,
    player_id_fk int NOT NULL,
    PRIMARY KEY (round_id),
	FOREIGN KEY (player_id_fk) REFERENCES Player(player_id),
    CONSTRAINT check_greens_in_regulation CHECK (greens_in_regulation BETWEEN 0 AND 18),
	CONSTRAINT check_gross_score CHECK (gross_score BETWEEN 52 AND 102),
    CONSTRAINT check_points CHECK (points BETWEEN 0 AND 52)
);

INSERT INTO Round VALUES (1, 10, '2020-04-30', 83, 37, 1);
INSERT INTO Round VALUES (2, 2, '2020-05-03', 100, 24, 3);
INSERT INTO Round VALUES (3, 18, '2020-05-18', 65, 42, 5);
INSERT INTO Round VALUES (4, 11, '2020-05-31', 83, 37, 4);
INSERT INTO Round VALUES (5, 1, '1995-03-21', 95, 25, 3);
INSERT INTO Round VALUES (6, 0, '1875-12-22', 102, 26, 2);
INSERT INTO Round VALUES (7, 4, '1982-08-31', 86, 33, 2);

CREATE TABLE IF NOT EXISTS Shot (
	round_id int NOT NULL,
    hole int NOT NULL,
	shot_number int NOT NULL,
	shot_type varchar(255),
    club varchar(255),
    PRIMARY KEY (round_id, hole, shot_number),
	CONSTRAINT check_hole CHECK (hole BETWEEN 1 AND 18),
	CONSTRAINT check_shot_number CHECK (shot_number BETWEEN 1 AND 10),
    CONSTRAINT check_shot_type CHECK (shot_type IN ('tee-shot', 'approach', 'pitch', 'chip', 'putt')),
	CONSTRAINT check_club CHECK (club IN ('driver', 'wood', 'iron', 'wedge', 'putter'))
);

INSERT INTO Shot VALUES (1, 1, 1, 'tee-shot', 'driver');
INSERT INTO Shot VALUES (1, 1, 2, 'approach', 'wood');
INSERT INTO Shot VALUES (1, 1, 3, 'approach', 'iron');
INSERT INTO Shot VALUES (1, 1, 4, 'pitch', 'wedge');
INSERT INTO Shot VALUES (1, 1, 5, 'putt', 'putter');
INSERT INTO Shot VALUES (1, 2, 1, 'tee-shot', 'iron');
INSERT INTO Shot VALUES (1, 2, 2, 'chip', 'wedge');
INSERT INTO Shot VALUES (1, 2, 3, 'putt', 'putter');
INSERT INTO Shot VALUES (2, 2, 3, 'putt', 'putter');
INSERT INTO Shot VALUES (3, 15, 1, 'tee-shot', 'iron');
INSERT INTO Shot VALUES (4, 8, 1, 'tee-shot', 'driver');
INSERT INTO Shot VALUES (5, 18, 1, 'tee-shot', 'iron');

CREATE TABLE IF NOT EXISTS Club (
	club_name varchar(255) NOT NULL,
    membership_fee double NOT NULL,
	number_of_members int NULL,
	county varchar(255) NOT NULL,						
    player_id_fk int NOT NULL,
    PRIMARY KEY (club_name),
	FOREIGN KEY (player_id_fk) REFERENCES Player(player_id),
	CONSTRAINT check_membership_fee CHECK (membership_fee BETWEEN 100 AND 2000),
	CONSTRAINT check_number_of_members CHECK (number_of_members > 1),	
    CONSTRAINT check_county CHECK (county 
				IN ('Louth', 'Meath', 'Dublin', 'Wicklow', 'Wexford', 'Kilkenny', 'Carlow', 'Offaly',
				'Kildare', 'Laois', 'Westmeath', 'Longford'))
);

INSERT INTO Club VALUES ('Tulfarris', 330, 400, 'Wicklow', 1);
INSERT INTO Club VALUES ('Royal Newlands', 600, 700, 'Dublin', 3);
INSERT INTO Club VALUES ('Faithlegg', 330, 450, 'Kildare', 4);
INSERT INTO Club VALUES ('Rosslare Strand', 650, 800, 'Wexford', 2);
INSERT INTO Club VALUES ('The K Club', 1200, 1000, 'Carlow', 5);

CREATE TABLE IF NOT EXISTS Course (
	location_code varchar(255) NOT NULL,
    greenfees double NOT NULL,
    par int NOT NULL,
	slope double NOT NULL,
    club_name_fk varchar(255) NOT NULL,
    PRIMARY KEY (location_code),
	FOREIGN KEY (club_name_fk) REFERENCES Club(club_name),
	CONSTRAINT check_greenfees CHECK (greenfees BETWEEN 20 AND 200),
	CONSTRAINT check_par CHECK (par BETWEEN 70 AND 75),
	CONSTRAINT check_slope CHECK (slope BETWEEN 3 AND 15)
);

INSERT INTO Course VALUES ('W93C8R2', 29.99, 72, 7.2, 'Tulfarris');
INSERT INTO Course VALUES ('D13AX30', 49.99, 73, 11.3, 'Faithlegg');
INSERT INTO Course VALUES ('D10AP10', 45.99, 72, 5.6, 'Royal Newlands');
INSERT INTO Course VALUES ('D11ER31', 25.99, 72, 4.7, 'Rosslare Strand');
INSERT INTO Course VALUES ('L21FX21', 39.99, 73, 6.4, 'The K Club');

CREATE TABLE IF NOT EXISTS Play (
	player_id int NOT NULL,
	round_id int NOT NULL,
    PRIMARY KEY (player_id, round_id),
    FOREIGN KEY (player_id) REFERENCES Player (player_id),
	FOREIGN KEY (round_id) REFERENCES Round (round_id)
);

INSERT INTO Play VALUES (1, 1);
INSERT INTO Play VALUES (1, 2);
INSERT INTO Play VALUES (1, 3);
INSERT INTO Play VALUES (2, 1);
INSERT INTO Play VALUES (3, 1);
INSERT INTO Play VALUES (3, 2);

CREATE TABLE IF NOT EXISTS Facilitate (
	round_id int NOT NULL,
    location_code varchar(255) NOT NULL,
    PRIMARY KEY (round_id, location_code),
	FOREIGN KEY (round_id) REFERENCES Shot (round_id),
	FOREIGN KEY (location_code) REFERENCES Course (location_code)
);

INSERT INTO Facilitate VALUES (1, 'W93C8R2');
INSERT INTO Facilitate VALUES (2, 'D13AX30');
INSERT INTO Facilitate VALUES (3, 'D10AP10');
INSERT INTO Facilitate VALUES (4, 'D11ER31');
INSERT INTO Facilitate VALUES (5, 'L21FX21');

CREATE TABLE IF NOT EXISTS Take (
	player_id int NOT NULL,
	round_id int NOT NULL,
	hole int NOT NULL,
    shot_number int NOT NULL,
    PRIMARY KEY (player_id, round_id, hole, shot_number),
    FOREIGN KEY (player_id) REFERENCES Player (player_id),
	FOREIGN KEY (round_id) REFERENCES Shot (round_id),
	FOREIGN KEY (hole) REFERENCES Shot (hole),
    FOREIGN KEY (shot_number) REFERENCES Shot (shot_number)
);

INSERT INTO Take VALUES (1, 1, 1, 1);
INSERT INTO Take VALUES (1, 1, 1, 2);
INSERT INTO Take VALUES (1, 1, 1, 3);
INSERT INTO Take VALUES (1, 1, 1, 4);
INSERT INTO Take VALUES (1, 1, 1, 5);
INSERT INTO Take VALUES (1, 1, 2, 1);
INSERT INTO Take VALUES (1, 1, 2, 2);
INSERT INTO Take VALUES (1, 1, 2, 3);
 
CREATE OR REPLACE VIEW Competitors AS SELECT first_name, last_name, handicap FROM Player;
CREATE OR REPLACE VIEW Coaches AS SELECT first_name, last_name, price_per_lesson FROM Coach;
CREATE OR REPLACE VIEW Best_Scores AS SELECT points, greens_in_regulation FROM Round;

CREATE ROLE IF NOT EXISTS chairperson;
GRANT ALL ON golfer_database.* TO chairperson; 
CREATE USER IF NOT EXISTS stephen IDENTIFIED BY 'stephen1';
GRANT chairperson TO stephen;

CREATE ROLE IF NOT EXISTS scorekeeper;
GRANT INSERT ON Round to scorekeeper;
CREATE USER IF NOT EXISTS ian IDENTIFIED BY 'ian1';
GRANT scorekeeper TO ian;

CREATE ROLE IF NOT EXISTS scorekeeper_assistant;
GRANT SELECT ON Round TO scorekeeper_assistant;
CREATE USER IF NOT EXISTS shane IDENTIFIED BY 'shane1';
GRANT scorekeeper_assistant TO shane;

CREATE ROLE IF NOT EXISTS club_secretary;
GRANT INSERT ON Player TO club_secretary;
CREATE USER IF NOT EXISTS imelda IDENTIFIED BY 'imelda1';
GRANT club_secretary TO imelda;

CREATE ROLE IF NOT EXISTS player;
GRANT SELECT ON Competitors TO player WITH GRANT OPTION;
GRANT SELECT ON Coaches TO player WITH GRANT OPTION;
GRANT SELECT ON Best_Scores TO player WITH GRANT OPTION;
CREATE USER IF NOT EXISTS mark IDENTIFIED BY 'mark1';
CREATE USER IF NOT EXISTS john IDENTIFIED BY 'john1';
CREATE USER IF NOT EXISTS liam IDENTIFIED BY 'liam1';
GRANT player TO mark;
GRANT player TO john;
GRANT player TO liam;

DROP FUNCTION IF EXISTS Calculate_net_score;

DELIMITER $$
CREATE FUNCTION Calculate_net_score(gross_score int, rounds_player_id int)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE handicap_ int;
    SELECT handicap FROM Player WHERE player_id = rounds_player_id INTO handicap_;
    RETURN gross_score - handicap_;
END
$$

DROP TRIGGER IF EXISTS `enter_score`;
DELIMITER $$
CREATE TRIGGER `enter_score`
AFTER INSERT ON Round
FOR EACH ROW
BEGIN
	DECLARE handicap_ int;
    SELECT handicap FROM Player WHERE player_id = NEW.player_id_fk INTO handicap_;
	IF NEW.points > 36
		THEN UPDATE Player SET handicap = (handicap_ - 1) WHERE (player_id = NEW.player_id_fk);
	ELSE
		UPDATE Player SET handicap = (handicap_ + 1) WHERE (player_id = NEW.player_id_fk);
    END IF;
END; $$

-- Some Useful Retrieval Commands:

-- SELECT * FROM Round WHERE Calculate_net_score(Round.gross_score, Round.player_id_fk) < 75;

-- SELECT Shot.round_id, hole, shot_number, shot_type FROM Shot 
-- INNER JOIN 
-- Round ON 
-- Round.round_id = Shot.round_id;