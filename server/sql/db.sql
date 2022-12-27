Create DATABASE Loaner IF NOT EXISTS;

CREATE Table Medias(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    details VARCHAR(255) NOT NULL,
    ext VARCHAR(255) NOT NULL,
    location_path VARCHAR(255) NOT NULL,
   

)

CREATE TABLE Entities(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    first_name VARCHAR ( 255 ) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
)

CREATE TABLE MediasEntities(
    media_id INTEGER NOT NULL, 
    entity_id INTEGER NOT NULL,
    FOREIGN KEY(media_id) REFERENCES Medias(id),
    FOREIGN KEY(entity_id) REFERENCES Entities(id)
)

CREATE TABLE Authorizations (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    role_details VARCHAR(50) NOT NULL --ENUM(CAN_CREATE_BORROWER, CAN_CREATE_EMPLOYEES,
    -- CAN_CREATE_PAYMENT , CAN_CREATE_LOAN, CAN_UPDATE_LOAN, CAN_UPDATE_PAYMENT)

)

CREATE TABLE Roles (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    title VARCHAR NOT NULL,
    details VARCHAR NOT NULL,
    custom BOOLEAN NOT NULL, 

)

CREATE TABLE AuthorisationsVsRoles (
    authorization_id INT NOT NULL, 
    role_id INT NOT NULL, 
    FOREIGN KEY(role_id) REFERENCES Roles(id),
    FOREIGN KEY(authorization_id) REFERENCES Authorizations(id),
)


CREATE TABLE Employees (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    entity_id INT NOT NULL,
    date_started TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_ended TIMESTAMP,
    role_id INT NOT NULL DEFAULT,
    FOREIGN KEY (role_id) REFERENCES Roles(id)
    FOREIGN KEY (entity_id) REFERENCES Entities(id)
)


CREATE TABLE Borrower (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    entity_id INT NOT NULL,
    first_loan_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (entity_id) REFERENCES Entities(id)
)

CREATE TABLE Plans (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    body VARCHAR(255) NOT NULL,
    percent_rate INT NOT NULL,
    week_time_rate INT NOT NULL,
)

CREATE TABLE Loans (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL,
    plan_id INTEGER NOT NULL,
    currency VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE
    FOREIGN KEY (plan_id) REFERENCES Plans(id) 
)

CREATE TABLE Colaterals (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    details VARCHAR(255) NOT NULL,
    estimated_value INT NOT NULL, 
    market_value INT NOT NULL, 
    status var
)

CREATE MediasVSColaterals (
    media_id INT NOT NULL, 
    colateral_id INT NOT NULL, 
    FOREIGN KEY (colateral_id) 
)




CREATE TABLE Payments (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL
    currency VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE
)
CREATE TABLE PaymentsVsLoans (
    loan_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    payment_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    FOREIGN KEY (payment_id) REFERENCES Payments(id)
    FOREIGN KEY (loan_id) REFERENCES Entities(id)
)