CREATE DATABASE united_helpers_db;

USE united_helpers_db;

CREATE TABLE volunteer(
volunteerId INT AUTO_INCREMENT PRIMARY KEY,
volunteerName VARCHAR(100) NOT NULL,
volunteerAddress VARCHAR(500),
volunteerTelephone VARCHAR(20)
);

CREATE TABLE task_type(
taskTypeId INT AUTO_INCREMENT PRIMARY KEY,
taskTypeName VARCHAR(100) NOT NULL
);

CREATE TABLE task_status(
taskStatusId INT AUTO_INCREMENT PRIMARY KEY,
taskStatusName VARCHAR(100) NOT NULL
);

CREATE TABLE packing_list(
packingListId INT AUTO_INCREMENT PRIMARY KEY,
packingListName VARCHAR(50) NOT NULL,
packingListDescription VARCHAR(500) NOT NULL
);

CREATE TABLE task(
taskCode INT AUTO_INCREMENT PRIMARY KEY,
packingListId INT,
taskTypeId INT NOT NULL,
taskStatusId INT NOT NULL,
taskDescription VARCHAR(500) NOT NULL,
FOREIGN KEY(packingListId) REFERENCES packing_list(packingListId),
FOREIGN KEY(taskTypeId) REFERENCES task_type(taskTypeId),
FOREIGN KEY(taskStatusId) REFERENCES task_status(taskStatusId)
);

CREATE TABLE assignment(
volunteerId INT,
taskCode INT,
startDateTime DATETIME NOT NULL,
endDateTime DATETIME,
PRIMARY KEY(volunteerId, taskCode),
FOREIGN KEY(volunteerId) REFERENCES volunteer(volunteerId),
FOREIGN KEY(taskCode) REFERENCES task(taskCode)
);

CREATE TABLE package_type(
packageTypeId INT AUTO_INCREMENT PRIMARY KEY,
packageTypeName VARCHAR(100) NOT NULL
);

CREATE TABLE package(
packageId INT AUTO_INCREMENT PRIMARY KEY,
taskCode INT NOT NULL,
packageTypeId INT NOT NULL,
packageCreateDate DATE NOT NULL,
packageWeight DECIMAL(7, 4) NOT NULL,
FOREIGN KEY(taskCode) REFERENCES task(taskCode),
FOREIGN KEY(packageTypeId) REFERENCES package_type(packageTypeId)
);

CREATE TABLE item(
itemId INT AUTO_INCREMENT PRIMARY KEY,
itemDescription VARCHAR(500) NOT NULL,
itemValue DECIMAL(7,2) NOT NULL,
quantityOnHand INT NOT NULL
);

CREATE TABLE package_contents(
itemId INT,
packageId INT,
itemQuantity INT NOT NULL,
PRIMARY KEY(itemId, packageId),
FOREIGN KEY(itemId) REFERENCES item(itemId),
FOREIGN KEY(packageId) REFERENCES package(packageId)
);

INSERT INTO volunteer(volunteerName, volunteerAddress, volunteerTelephone)
VALUES
('Emma Johnson', '245 Oak Street, Austin, TX 73301', '512-349-8821'),
('Noah Smith', '118 Maple Avenue, Denver, CO 80202', '303-472-6654'),
('Olivia Brown', '76 Pine Road, Seattle, WA 98101', '206-718-4902'),
('Liam Davis', '940 Elm Drive, Atlanta, GA 30303', '404-263-1998'),
('Ava Miller', '530 Lakeview Blvd, Chicago, IL 60611', '312-870-5530'),
('William Garcia', '1020 Sunset Lane, Phoenix, AZ 85004', '602-441-9375'),
('Sophia Martinez', '420 Ocean Avenue, Miami, FL 33133', '305-725-4829'),
('James Anderson', '885 Forest Hills Rd, Nashville, TN 37203', '615-392-6641'),
('Mia Wilson', '301 Riverbend Way, Portland, OR 97201', '503-219-7760'),
('Benjamin Taylor', '178 Country Club Dr, Dallas, TX 75201', '214-982-3305');

INSERT INTO task_type(taskTypeName)
VALUES
('recurring'),
('packing'),
('delivery'),
('logistics'),
('administrative');

INSERT INTO task_status(taskStatusName)
VALUES
('open'),
('ongoing'),
('completed'),
('cancelled'),
('on hold'),
('closed');

INSERT INTO packing_list(packingListName, packingListDescription)
VALUES
('Flood Relief Pack', '2,000 medical packages, 2,000 food packages, and 1,000 child-care packages are needed. Make sure the food packages do not include any meat.'),
('Hurricane Emergency Pack', 'Prepare 3,000 food packages and 2,000 hygiene packages. Include bottled water and flashlights in each food package.'),
('Earthquake Recovery Pack', '1,500 medical packages, 2,000 shelter packages, and 1,500 food packages required. Ensure medical packages contain first aid kits and pain relievers.'),
('Wildfire Response Pack', '2,500 food packages, 1,000 child-care packages, and 500 hygiene packages. Avoid perishable items due to high temperatures.'),
('Winter Storm Support Pack', '3,000 warm-clothing packages and 2,000 food packages. Each clothing package must include blankets, gloves, and thermal socks.');

INSERT INTO task(packingListId, taskTypeId, taskStatusId, taskDescription)
VALUES
(1, 2, 1, 'Prepare 5,000 relief packages for Texas flood victims.'),
(2, 2, 2, 'Assemble 3,000 emergency packs for Florida hurricane survivors.'),
(3, 2, 3, 'Complete earthquake recovery packages for California.'),
(4, 2, 1, 'Prepare wildfire response packages for Arizona communities.'),
(5, 2, 2, 'Pack and distribute winter storm supplies across New York State.'),
(NULL, 3, 2, 'Deliver emergency food packages to local shelters in Houston.'),
(NULL, 1, 2, 'Answer hotline calls from affected residents.'),
(NULL, 4, 1, 'Organize logistics and truck schedules for supply delivery.'),
(NULL, 5, 3, 'Update administrative records for completed disaster responses.'),
(NULL, 1, 4, 'Maintain volunteer database system (cancelled due to power outage).');

INSERT INTO assignment(volunteerId, taskCode, startDateTime, endDateTime)
VALUES
(1, 1, '2025-01-10 08:00:00', NULL),
(2, 1, '2025-01-10 09:00:00', NULL),
(3, 2, '2025-01-12 08:30:00', NULL),
(2, 3, '2025-01-14 09:00:00', '2025-01-14 16:30:00'),
(2, 8, '2025-01-21 09:00:00', NULL),
(6, 5, '2025-01-18 09:00:00', NULL),
(1, 2, '2025-01-12 08:30:00', NULL),
(1, 7, '2025-01-20 08:30:00', NULL),
(9, 8, '2025-01-21 09:00:00', NULL),
(10, 9, '2025-01-22 08:00:00', '2025-01-22 17:00:00'); 

INSERT INTO package_type(packageTypeName)
VALUES
('medical'),
('food'),
('child-care'),
('hygiene'),
('shelter'),
('clothing');

INSERT INTO package(taskCode, packageTypeId, packageCreateDate, packageWeight)
VALUES
(1, 1, '2025-01-10', 2.5500),
(1, 2, '2025-01-10', 3.2000),
(2, 2, '2025-01-12', 3.0500),
(2, 4, '2025-01-12', 1.8500),
(3, 1, '2025-01-14', 2.4800),
(3, 5, '2025-01-14', 5.1000),
(4, 2, '2025-01-16', 3.3000),
(4, 3, '2025-01-16', 1.9000),
(5, 6, '2025-01-18', 4.2500),
(5, 2, '2025-01-18', 3.1000);

INSERT INTO item(itemDescription, itemValue, quantityOnHand)
VALUES
('First Aid Kit', 15.00, 250),
('Bandages (Box of 50)', 5.50, 500),
('Antiseptic Solution', 4.25, 400),
('Bottled Water (12-pack)', 8.75, 600),
('Canned Beans (6-pack)', 6.20, 700),
('Baby Diapers (Pack of 30)', 12.00, 300),
('Hygiene Soap Bars', 3.00, 800),
('Sleeping Bag', 9.80, 250),
('Warm Blanket', 14.50, 350),
('Thermal Gloves (Pair)', 10.00, 400);

INSERT INTO package_contents(itemId, packageId, itemQuantity)
VALUES
(1, 1, 1),
(2, 1, 3),
(4, 2, 2),
(5, 2, 4),
(3, 5, 2),
(1, 5, 1),
(7, 4, 5),
(9, 9, 1),
(10, 9, 2),
(6, 8, 1),
(5, 3, 3),
(4, 7, 2), 
(5, 10, 2),
(8, 6, 1);