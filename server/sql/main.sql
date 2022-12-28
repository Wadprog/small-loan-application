DROP  DATABASE IF EXISTS Loaner;
Create DATABASE Loaner;
USE  Loaner;
CREATE Table Medias(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    details VARCHAR(255) NOT NULL,
    ext VARCHAR(255) NOT NULL,
    location_path VARCHAR(255) NOT NULL
    );

CREATE TABLE Tags (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
title VARCHAR(50) NOT NULL,
custom BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE MediasVsTags (
media_id INT NOT NULL,
tag_id INT NOT NULL, 
FOREIGN KEY (tag_id) REFERENCES Tags(id), 
FOREIGN KEY (media_id) REFERENCES Media(id)
);

CREATE TABLE Entities(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR ( 255 ) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender ENUM('m','f')
    
);

CREATE TABLE MediasEntities(
    media_id INTEGER NOT NULL, 
    entity_id INTEGER NOT NULL,
    FOREIGN KEY(media_id) REFERENCES Medias(id),
    FOREIGN KEY(entity_id) REFERENCES Entities(id)
);

CREATE TABLE Authorizations (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    role_details ENUM('CAN_CREATE_BORROWER', 'CAN_CREATE_EMPLOYEES','CAN_CREATE_PAYMENT')
);

CREATE TABLE Roles (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    details VARCHAR(255) NOT NULL,
    custom BOOLEAN NOT NULL DEFAULT TRUE
    );

CREATE TABLE AuthorisationsVsRoles (
    authorization_id INT NOT NULL, 
    role_id INT NOT NULL, 
    FOREIGN KEY(role_id) REFERENCES Roles(id),
    FOREIGN KEY(authorization_id) REFERENCES Authorizations(id)
);

CREATE TABLE Employees (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    entity_id INT NOT NULL,
    date_started TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_ended TIMESTAMP,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(id),
    FOREIGN KEY (entity_id) REFERENCES Entities(id)
);


CREATE TABLE Borrower (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    entity_id INT NOT NULL,
    first_loan_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (entity_id) REFERENCES Entities(id)
);

CREATE TABLE Plans (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    body VARCHAR(255) NOT NULL,
    percent_rate INT NOT NULL,
    week_time_rate INT NOT NULL
);

CREATE TABLE Loans (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL,
    plan_id INTEGER NOT NULL,
    currency VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES Plans(id) 
);

CREATE TABLE Colaterals (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    details VARCHAR(255) NOT NULL,
    estimated_value INT NOT NULL, 
    market_value INT NOT NULL, 
    properties JSON NULL,
    status ENUM('NEW', 'OLD', 'GOOD CONDITION')
);

CREATE TABLE MediasVSColaterals (
    media_id INT NOT NULL, 
    colateral_id INT NOT NULL, 
    FOREIGN KEY (colateral_id) REFERENCES Colaterals(id),
    FOREIGN KEY (media_id) REFERENCES Medias(id)
);

CREATE TABLE Payments (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL,
    currency VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
);
CREATE TABLE PaymentsVsLoans (
    loan_id INTEGER NOT NULL,
    payment_id INTEGER NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES Payments(id),
    FOREIGN KEY (loan_id) REFERENCES Entities(id)
);



insert into Entities (id, first_name, last_name, gender) 
values 

(1, 'Moritz', 'Brewster', 'm'),
(2, 'Vincents', 'Whittuck', 'm'),
(3, 'Sharline', 'Kemmer', 'f'),
(4, 'Hinze', 'Dik', 'm'),
(5, 'Dana', 'Dafforne', 'm'),
(6, 'Netty', 'Saywell', 'f'),
(7, 'Che', 'Harbar', 'm'),
(8, 'Indira', 'Freed', 'f'),
(9, 'Ivette', 'Rops', 'f'),
(10, 'Carter', 'MacCracken', 'm'),
(11, 'Britni', 'Dillaway', 'f'),
(12, 'Kial', 'Older', 'f'),
(13, 'Gardiner', 'Prium', 'm'),
(14, 'Angelo', 'Kopelman', 'm'),
(15, 'Mohammed', 'Blaxill', 'm'),
(16, 'Charity', 'Venneur', 'f'),
(17, 'Herold', 'Crutchley', 'm'),
(18, 'Lynne', 'Taysbil', 'f'),
(19, 'Margaretta', 'Cuppitt', 'f'),
(20, 'Ynez', 'Jenicek', 'm'),
(21, 'Udell', 'Clew', 'm'),
(22, 'Hyman', 'Brounfield', 'm'),
(23, 'Benedict', 'Bartoszek', 'm'),
(24, 'Aubrette', 'Niccolls', 'f'),
(25, 'Trenton', 'Semiraz', 'm'),
(26, 'Eliza', 'Wallhead', 'f'),
(27, 'Octavia', 'GiacobbiniJacob', 'f'),
(28, 'Micheil', 'Cartner', 'm'),
(29, 'Shannan', 'Custy', 'm'),
(30, 'Locke', 'Prestie', 'm'),
(31, 'Dominica', 'Lorkin', 'f'),
(32, 'Hirsch', 'Briscow', 'm'),
(33, 'Munroe', 'Drewe', 'm'),
(34, 'Merrel', 'Barnsdale', 'm'),
(35, 'Sherrie', 'Snoday', 'f'),
(36, 'Kassia', 'Jursch', 'f'),
(37, 'Grant', 'Speke', 'm'),
(38, 'Eugene', 'Rableau', 'm'),
(39, 'Harley', 'Challenor', 'm'),
(40, 'Tonie', 'Cersey', 'f'),
(41, 'Adelina', 'Begwell', 'f'),
(42, 'Trixie', 'Lafoy', 'f'),
(43, 'Dewie', 'Di Baudi', 'm'),
(44, 'Bianka', 'Hopkynson', 'f'),
(45, 'Angelika', 'McGilben', 'f'),
(46, 'Vincents', 'Pigden', 'm'),
(47, 'Arlan', 'Varcoe', 'm'),
(48, 'Arvie', 'Leverson', 'm'),
(49, 'Berky', 'Morefield', 'm'),
(50, 'Jerad', 'Grunguer', 'm'),
(51, 'Cordey', 'Josephson', 'f'),
(52, 'Solly', 'Brosh', 'm'),
(53, 'Theo', 'Laborde', 'f'),
(54, 'Sharity', 'Obeney', 'f'),
(55, 'Kendal', 'Porte', 'm'),
(56, 'Ceil', 'Rothchild', 'f'),
(57, 'Valenka', 'Chaloner', 'f'),
(58, 'Jori', 'Chern', 'f'),
(59, 'Kristo', 'Sarten', 'm'),
(60, 'Bartel', 'Dagnall', 'm'),
(61, 'Patin', 'Plott', 'm'),
(62, 'Wynne', 'Rany', 'f'),
(63, 'Hughie', 'Richie', 'm'),
(64, 'Lanette', 'Eastes', 'f'),
(65, 'Guenna', 'Ratter', 'f'),
(66, 'Gram', 'Woolgar', 'f'),
(67, 'Ole', 'De Bruyn', 'm'),
(68, 'Angel', 'Winpenny', 'f'),
(69, 'Terry', 'Reding', 'm'),
(70, 'Hort', 'Ladyman', 'm'),
(71, 'Nichole', 'Dillamore', 'f'),
(72, 'Trix', 'Gradley', 'f'),
(73, 'Moore', 'Piecha', 'm'),
(74, 'Dom', 'Rundle', 'm'),
(75, 'Ingamar', 'O''Cannovane', 'm'),
(76, 'Regan', 'Scolland', 'f'),
(77, 'Rusty', 'Asgodby', 'm'),
(78, 'Nathanial', 'Arstall', 'm'),
(79, 'Rob', 'Besque', 'm'),
(80, 'Kellie', 'Boundey', 'f'),
(81, 'Oswald', 'Pexton', 'm'),
(82, 'Ulick', 'Kynforth', 'f'),
(83, 'Wiley', 'Roney', 'm'),
(84, 'Rosalind', 'Wakeham', 'f'),
(85, 'Marylinda', 'Bernat', 'm'),
(86, 'Gunilla', 'Caveney', 'f'),
(87, 'Sig', 'Bolitho', 'm'),
(88, 'Carly', 'Kmiec', 'm'),
(89, 'Legra', 'Scurfield', 'f'),
(90, 'Delinda', 'Bauldrey', 'f'),
(91, 'Nat', 'Ovid', 'm'),
(92, 'Gustavus', 'Piscopello', 'm'),
(93, 'Blakeley', 'Burch', 'f'),
(94, 'Maryellen', 'Jacquet', 'f'),
(95, 'Phyllis', 'Suffe', 'f'),
(96, 'Verne', 'Trevorrow', 'm'),
(97, 'Ahmed', 'Corneille', 'm'),
(98, 'Netta', 'Loyley', 'f'),
(99, 'Rooney', 'Templeman', 'm'),
(100, 'Alvie', 'Goodram', 'm');

