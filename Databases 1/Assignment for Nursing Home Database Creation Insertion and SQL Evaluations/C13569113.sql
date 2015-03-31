-- Nursing Home SQL to create and populate tables

/* Drop Table statements are included for each table to ensure that 
when you create the tables no tables with the same name exist. This is 
particularly important if you need to make changes to the table definitions
and re-run this script */
DROP TABLE SpecialTreatment CASCADE CONSTRAINTS PURGE;

DROP TABLE TreatmentType CASCADE CONSTRAINTS PURGE;

DROP TABLE FoodAllowed_Restricted CASCADE CONSTRAINTS PURGE;

DROP TABLE Food CASCADE CONSTRAINTS PURGE;

DROP TABLE Invoice CASCADE CONSTRAINTS PURGE;

DROP TABLE Booking CASCADE CONSTRAINTS PURGE;

DROP TABLE Room CASCADE CONSTRAINTS PURGE;

DROP TABLE Chart CASCADE CONSTRAINTS PURGE;

DROP TABLE Patient CASCADE CONSTRAINTS PURGE;


/* Create table statements
All foreign keys are named for the two tables involved in the relationship followed by fk
table1_table2_fk, except in cases where this will lead to fk names going over the 30 character limit,
in which case short hand versions of the tables will be used in the foreign key name.
Tables are created in the following order:
1st layer : Those with no foreign keys are created first
2nd layer: Tables that depend only on these tables i.e. have foreign key relationships to 1st layer
3rd layer: Tables that depend on 2nd layer or combination of 1st and 2nd layer
*/
-- Create table Patient - holds details of all patients of the nursing home
CREATE TABLE Patient
(
	PatientId            NUMBER(6) NOT NULL ,
	PatientName          VARCHAR2(11) NULL ,
	DateOfBirth               DATE NULL ,
	ReasonOfStay         VARCHAR2(31) NULL ,
	HomeAddress          VARCHAR2(31) NULL ,
	NextOfKin            VARCHAR2(11) NULL ,
CONSTRAINT  Patient_PK PRIMARY KEY (PatientId)
);

-- Create table Chart - holds details of patients arrival times and a daily summary of their overall health
CREATE TABLE Chart
(
	PatientId            NUMBER(6) NOT NULL ,
	DateOfCheck          DATE NOT NULL ,
	TimeOfCheck          VARCHAR2(7) NOT NULL ,
	DailyCheck           VARCHAR2(300) NULL ,
CONSTRAINT  Chart_PK PRIMARY KEY (PatientId,DateOfCheck,TimeOfCheck),
CONSTRAINT Patient_Chart_FK FOREIGN KEY (PatientId) REFERENCES Patient (PatientId)
);

-- Create table Room - holds details of all rooms of the nursing home
CREATE TABLE Room
(
	RoomNumber           NUMBER(3) NOT NULL ,
	RoomSize             VARCHAR2(11) NULL ,
	CCTVMonitored        CHAR(1) DEFAULT 'N' NOT NULL CHECK (CCTVMonitored = 'Y' OR CCTVMonitored = 'N'),
	Floor                NUMBER(1) NULL ,
	BedType              VARCHAR2(11) NULL ,
	Monitored            CHAR(1) DEFAULT 'N' NOT NULL CHECK (Monitored = 'Y' OR Monitored = 'N'),
CONSTRAINT  RoomNumber_PK PRIMARY KEY (RoomNumber)
);

-- Create table Booking - holds details of all current reservations in the nursing home
CREATE TABLE Booking
(
	PatientId            NUMBER(6) NOT NULL ,
	ReservationNumber    NUMBER(6) NOT NULL ,
	RoomNumber           NUMBER(3) NULL ,
	PatientArrived       CHAR(1) DEFAULT 'N' NOT NULL CHECK (PatientArrived = 'Y' OR PatientArrived = 'N'),
	BookedDate           DATE NULL ,
	CheckInDate          DATE NULL ,
	CheckOutDate         DATE NULL ,
CONSTRAINT  Reservation_PK PRIMARY KEY (PatientId,ReservationNumber),
CONSTRAINT Patient_Booking_FK FOREIGN KEY (PatientId) REFERENCES Patient (PatientId),
CONSTRAINT Room_Booking_FK FOREIGN KEY (RoomNumber) REFERENCES Room (RoomNumber)
);

-- Create table Invoice - holds details of all patients bills and whether or not they've paid 
CREATE TABLE Invoice
(
	InvoiceNumber        NUMBER(6) NOT NULL ,
	PatientId            NUMBER(6) NULL ,
	ReservationNumber    NUMBER(6) NULL ,
	Bill                 NUMBER(5,2) NULL ,
	DepartureDate        DATE NULL ,
	Payment              CHAR(1) DEFAULT 'N' NOT NULL CHECK (Payment = 'Y' OR Payment = 'N'),
CONSTRAINT  Invoice_PK PRIMARY KEY (InvoiceNumber),
CONSTRAINT Booking_Invoice_FK FOREIGN KEY (PatientId, ReservationNumber) REFERENCES Booking (PatientId, ReservationNumber)
);

-- Create table Food - holds details of food served to patients in the nursing home
CREATE TABLE Food
(
	FoodId               NUMBER(6) NOT NULL ,
	Description          VARCHAR2(31) NULL ,
CONSTRAINT  Food_PK PRIMARY KEY (FoodId)
);

-- Create table FoodAllowed_Restricted - holds details of which foods patients of the nursing home can consume and their recommended daily calorie intake
CREATE TABLE FoodAllowed_Restricted
(
	PatientId            NUMBER(6) NOT NULL ,
	ReservationNumber    NUMBER(6) NOT NULL ,
	FoodId               NUMBER(6) NOT NULL ,
	RecomendedCalorieIntake NUMBER(6,2) NULL ,
	Allowed              CHAR(1) DEFAULT 'N' NOT NULL CHECK (Allowed = 'Y' OR Allowed = 'N'),
	Restricted           CHAR(1) DEFAULT 'N' NOT NULL CHECK (Restricted = 'Y' OR Restricted = 'N'),
CONSTRAINT  FoodAllowed_PK PRIMARY KEY (PatientId,ReservationNumber,FoodId),
CONSTRAINT Booking_FoodAllow_Rest_FK FOREIGN KEY (PatientId, ReservationNumber) REFERENCES Booking (PatientId, ReservationNumber),
CONSTRAINT Food_FoodAllowed_Restricted_FK FOREIGN KEY (FoodId) REFERENCES Food (FoodId)
);

-- Create table TreatmentType - holds details of all treatment types available to patients
CREATE TABLE TreatmentType
(
	TreatmentCode        NUMBER(6) NOT NULL ,
	Treatment            VARCHAR2(31) NULL ,
CONSTRAINT  TreatmentType_PK PRIMARY KEY (TreatmentCode)
);

-- Create table SpecialTreatment - holds details of any treatments a patient must avail of
CREATE TABLE SpecialTreatment
(
	PatientId            NUMBER(6) NOT NULL ,
	ReservationNumber    NUMBER(6) NOT NULL ,
	TreatmentCode        NUMBER(6) NOT NULL ,
	FrequencyOfTreatment VARCHAR2(11) NULL ,
	EquipmentRequired    CHAR(1) DEFAULT 'N' NOT NULL CHECK (EquipmentRequired = 'Y' OR EquipmentRequired = 'N'),
	SpecialCases         VARCHAR2(31) NULL ,
CONSTRAINT  SpecialTreatment_PK PRIMARY KEY (PatientId,ReservationNumber,TreatmentCode),
CONSTRAINT Booking_SpecialTreatment_FK FOREIGN KEY (PatientId, ReservationNumber) REFERENCES Booking (PatientId, ReservationNumber),
CONSTRAINT TreatType_SpecialTreat_FK FOREIGN KEY (TreatmentCode) REFERENCES TreatmentType (TreatmentCode)
);


-- Insert statements to populate the tables
-- Patient inserted first
insert into Patient values(1, 'John', '01 JUN 1943', 'Chronic Back Pain', 'Kinsale, Cork', 'Mary');
insert into Patient values(2, 'Mary', '01 JAN 1937', 'Chest Infection', 'Blackrock, Dublin', 'Mark');
insert into Patient values(3, 'Jack', '06 DEC 1940', 'Dementia', 'Salthill, Galway', 'Tony');
insert into Patient values(4, 'Joan', '12 SEP 1948', 'Pneumonia', 'Greystones, Wicklow', 'Andrew');
insert into Patient values(5, 'Brian', '22 AUG 1933', 'Heart Attack', 'Shankill, Dublin', 'Terry');
insert into Patient values(6, 'Alex', '16 OCT 1943', 'Stroke', 'Rathfarnham, Dublin', 'Joan');
insert into Patient values(7, 'Rita', '11 JUN 1993', 'Brain Tumour', 'Clontarf, Dublin', 'Terry');
insert into Patient values(8, 'Patricia', '16 NOV 1946', 'Dementia', 'Bray, Wicklow', 'Vivienne');
insert into Patient values(9, 'Eddie', '08 MAR 1940', 'Lung Cancer', 'Clondalkin, Dublin', 'Lisa');
insert into Patient values(10, 'Theresa', '18 DEC 1939', 'Dementia', 'Dalkey, Dublin', 'Anthony');

-- Chart inserted next
insert into Chart values(1, '01 DEC 2014', '12:30', 'No issues with this patient this morning');
insert into Chart values(2, '01 DEC 2014', '12:35', 'Patient had trouble breathing this morning and so had to be put onto an oxygen machine');
insert into Chart values(3, '01 DEC 2014', '12:40', 'Patient attempted to leave the premises this morning but was quickly escorted to a secured room by staff');
insert into Chart values(4, '01 DEC 2014', '12:45', 'No issues with this patient this morning');
insert into Chart values(5, '01 DEC 2014', '12:50', 'No issues with this patient this morning');
insert into Chart values(6, '01 DEC 2014', '12:55', 'Patient was very unresponsive this morning, they are still in recovery');
insert into Chart values(7, '01 DEC 2014', '13:00', 'Patient complained of pain this morning, was treated with painkillers');
insert into Chart values(8, '01 DEC 2014', '13:05', 'No issues with this patient this morning');
insert into Chart values(9, '01 DEC 2014', '13:10', 'No issues with this patient this morning');
insert into Chart values(10, '01 DEC 2014', '13:15', 'No issues with this patient this morning');

-- Room inserted next
insert into Room values(101, 'Small', 'Y', 1, 'Orthapedic', 'Y');
insert into Room values(102, 'Small', 'Y', 1, 'Standard', 'Y');
insert into Room values(103, 'Large', 'N', 1, 'Adjustable', 'N');
insert into Room values(104, 'Small', 'Y', 1, 'Orthapedic', 'Y');
insert into Room values(105, 'Small', 'Y', 1, 'Standard', 'Y');
insert into Room values(201, 'Large', 'N', 2, 'Adjustable', 'N');
insert into Room values(202, 'Small', 'N', 2, 'Orthapedic', 'N');
insert into Room values(203, 'Large', 'N', 2, 'Standard', 'N');
insert into Room values(301, 'Small', 'N', 3, 'Orthapedic', 'N');
insert into Room values(302, 'Large', 'N', 3, 'Standard', 'N'); 

-- Booking Inserted next
insert into Booking values(1, 1001, 101, 'Y', '01 NOV 2014', '01 DEC 2014', '20 DEC 2014');
insert into Booking values(2, 1002, 103, 'Y', '05 NOV 2014', '01 DEC 2014', '15 DEC 2014');
insert into Booking values(3, 1003, 102, 'Y', '10 NOV 2014', '01 DEC 2014', '23 DEC 2014');
insert into Booking values(4, 1004, 201, 'Y', '08 NOV 2014', '01 DEC 2014', '14 DEC 2014');
insert into Booking values(5, 1005, 202, 'Y', '09 NOV 2014', '01 DEC 2014', '30 DEC 2014');
insert into Booking values(6, 1006, 203, 'Y', '11 NOV 2014', '01 DEC 2014', '05 JAN 2015');
insert into Booking values(7, 1007, 301, 'Y', '01 NOV 2014', '01 DEC 2014', '28 DEC 2014');
insert into Booking values(8, 1008, 104, 'Y', '17 NOV 2014', '01 DEC 2014', '22 JAN 2015');
insert into Booking values(9, 1009, 302, 'Y', '22 NOV 2014', '01 DEC 2014', '18 DEC 2014');
insert into Booking values(10, 1010, 105, 'Y', '13 NOV 2014', '01 DEC 2014', '11 JAN 2015');

-- Invoice Inserted next
insert into Invoice values(1001, 1, 1001, 850.50, '20 DEC 2014', 'N');
insert into Invoice values(1002, 2, 1002, 800.50, '15 DEC 2014', 'N');
insert into Invoice values(1003, 3, 1003, 880.50, '23 DEC 2014', 'N');
insert into Invoice values(1004, 4, 1004, 850.50, '14 DEC 2014', 'N');
insert into Invoice values(1005, 5, 1005, 850.50, '30 DEC 2014', 'N');
insert into Invoice values(1006, 6, 1006, 900.50, '05 JAN 2015', 'N');
insert into Invoice values(1007, 7, 1007, 650.50, '28 DEC 2014', 'N');
insert into Invoice values(1008, 8, 1008, 940.50, '22 JAN 2015', 'N');
insert into Invoice values(1009, 9, 1009, 850.50, '18 DEC 2014', 'N');
insert into Invoice values(1010, 10,1010, 900.50, '11 JAN 2015', 'N');

-- Food Inserted next
insert into Food values(1, 'Milk');
insert into Food values(2, 'Cheese');
insert into Food values(3, 'Cereal');
insert into Food values(4, 'Yoghourt');
insert into Food values(5, 'Red Meat');
insert into Food values(6, 'Light Meat');
insert into Food values(7, 'Nuts');
insert into Food values(8, 'Fruit');
insert into Food values(9, 'Sugar');
insert into Food values(10, 'Vegetables');

-- FoodAllowed_Restricted Inserted next, each patient must have details of the ten foods relevant to them, so each patients has ten inserts.
insert into FoodAllowed_Restricted values(1, 1001, 1, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(1, 1001, 2, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(1, 1001, 3, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(1, 1001, 4, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(1, 1001, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(1, 1001, 6, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(1, 1001, 7, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(1, 1001, 8, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(1, 1001, 9, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(1, 1001, 10, 150.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(2, 1002, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 7, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(2, 1002, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(2, 1002, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(3, 1003, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(3, 1003, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(4, 1004, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(4, 1004, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(4, 1004, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(4, 1004, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(4, 1004, 5, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(4, 1004, 6, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(4, 1004, 7, 300.00, 'Y', 'Y');
insert into FoodAllowed_Restricted values(4, 1004, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(4, 1004, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(4, 1004, 10, 500.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(5, 1005, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(5, 1005, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(6, 1006, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(6, 1006, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(7, 1007, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(7, 1007, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(8, 1008, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(8, 1008, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(9, 1009, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 5, 500.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 6, 400.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 8, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 9, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(9, 1009, 10, 300.00, 'Y', 'N');

insert into FoodAllowed_Restricted values(10, 1010, 1, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(10, 1010, 2, 200.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(10, 1010, 3, 300.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(10, 1010, 4, 100.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(10, 1010, 5, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(10, 1010, 6, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(10, 1010, 7, 50.00, 'Y', 'N');
insert into FoodAllowed_Restricted values(10, 1010, 8, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(10, 1010, 9, 0.00, 'N', 'Y');
insert into FoodAllowed_Restricted values(10, 1010, 10, 1200.00, 'Y', 'N');

-- TreatmentType Inserted next
insert into TreatmentType values(1, 'Physiotherapy');
insert into TreatmentType values(2, 'Dressing Change');
insert into TreatmentType values(3, 'Hospital Visit');
insert into TreatmentType values(4, 'Doctor Visit');
insert into TreatmentType values(5, 'Drug Treatment');
insert into TreatmentType values(6, 'Therapy');
insert into TreatmentType values(7, 'Injection');
insert into TreatmentType values(8, 'Insulin Boost');
insert into TreatmentType values(9, 'Oxygen Machine');
insert into TreatmentType values(10, 'Optician Visit');

-- Finally, SpecialTreatment Inserted, each patient must have details of the ten treatments relevant to them, so each patients has ten inserts.
insert into SpecialTreatment values(1, 1001, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(1, 1001, 2, 'Daily', 'N', 'None');
insert into SpecialTreatment values(1, 1001, 3, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(1, 1001, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(1, 1001, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(1, 1001, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(1, 1001, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(1, 1001, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(1, 1001, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(1, 1001, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(2, 1002, 1, 'Daily', 'N', 'None');
insert into SpecialTreatment values(2, 1002, 2, 'Never', 'N', 'None');
insert into SpecialTreatment values(2, 1002, 3, 'Never', 'Y', 'None');
insert into SpecialTreatment values(2, 1002, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(2, 1002, 5, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(2, 1002, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(2, 1002, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(2, 1002, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(2, 1002, 9, 'Never', 'Y', 'None');
insert into SpecialTreatment values(2, 1002, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(3, 1003, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(3, 1003, 2, 'Never', 'N', 'None');
insert into SpecialTreatment values(3, 1003, 3, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(3, 1003, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(3, 1003, 5, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(3, 1003, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(3, 1003, 7, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(3, 1003, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(3, 1003, 9, 'Never', 'Y', 'None');
insert into SpecialTreatment values(3, 1003, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(4, 1004, 1, 'Daily', 'N', 'None');
insert into SpecialTreatment values(4, 1004, 2, 'Never', 'N', 'None');
insert into SpecialTreatment values(4, 1004, 3, 'Never', 'Y', 'None');
insert into SpecialTreatment values(4, 1004, 4, 'Weekly', 'N', 'None');
insert into SpecialTreatment values(4, 1004, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(4, 1004, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(4, 1004, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(4, 1004, 8, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(4, 1004, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(4, 1004, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(5, 1005, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(5, 1005, 2, 'Never', 'N', 'None');
insert into SpecialTreatment values(5, 1005, 3, 'Never', 'Y', 'None');
insert into SpecialTreatment values(5, 1005, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(5, 1005, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(5, 1005, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(5, 1005, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(5, 1005, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(5, 1005, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(5, 1005, 10, 'Daily', 'N', 'None');

insert into SpecialTreatment values(6, 1006, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(6, 1006, 2, 'Daily', 'N', 'None');
insert into SpecialTreatment values(6, 1006, 3, 'Never', 'Y', 'None');
insert into SpecialTreatment values(6, 1006, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(6, 1006, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(6, 1006, 6, 'Weekly', 'N', 'None');
insert into SpecialTreatment values(6, 1006, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(6, 1006, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(6, 1006, 9, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(6, 1006, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(7, 1007, 1, 'Daily', 'N', 'None');
insert into SpecialTreatment values(7, 1007, 2, 'Never', 'N', 'None');
insert into SpecialTreatment values(7, 1007, 3, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(7, 1007, 4, 'Weekly', 'N', 'None');
insert into SpecialTreatment values(7, 1007, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(7, 1007, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(7, 1007, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(7, 1007, 8, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(7, 1007, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(7, 1007, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(8, 1008, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(8, 1008, 2, 'Never', 'N', 'None');
insert into SpecialTreatment values(8, 1008, 3, 'Never', 'Y', 'None');
insert into SpecialTreatment values(8, 1008, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(8, 1008, 5, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(8, 1008, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(8, 1008, 7, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(8, 1008, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(8, 1008, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(8, 1008, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(9, 1009, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(9, 1009, 2, 'Daily', 'N', 'None');
insert into SpecialTreatment values(9, 1009, 3, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(9, 1009, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(9, 1009, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(9, 1009, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(9, 1009, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(9, 1009, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(9, 1009, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(9, 1009, 10, 'Never', 'N', 'None');

insert into SpecialTreatment values(10, 1010, 1, 'Never', 'N', 'None');
insert into SpecialTreatment values(10, 1010, 2, 'Daily', 'N', 'None');
insert into SpecialTreatment values(10, 1010, 3, 'Weekly', 'Y', 'None');
insert into SpecialTreatment values(10, 1010, 4, 'Never', 'N', 'None');
insert into SpecialTreatment values(10, 1010, 5, 'Never', 'Y', 'None');
insert into SpecialTreatment values(10, 1010, 6, 'Never', 'N', 'None');
insert into SpecialTreatment values(10, 1010, 7, 'Never', 'Y', 'None');
insert into SpecialTreatment values(10, 1010, 8, 'Never', 'Y', 'None');
insert into SpecialTreatment values(10, 1010, 9, 'Daily', 'Y', 'None');
insert into SpecialTreatment values(10, 1010, 10, 'Never', 'N', 'None');

-- Commit included to persist the data
commit;

-- Single Row FUNCTION to join the name of each patient followed by their next of kin provided they are below row 5 in the Patient table
SELECT CONCAT (PatientName, NextOfKin)
FROM Patient
WHERE rownum < 5;

-- Aggregate Function to counnt all Patients in the Patient table
SELECT COUNT(*) "Total Patients In Database: "
  FROM Patient;
  
-- Inner Join On two tables, joins Patient and Booking tables on PatientId
SELECT *
FROM Patient
INNER JOIN Booking 
ON Patient.PatientId = Booking.PatientId;

-- Inner Join On three tables, joins Patient, Booking and Chart tables on PatientId
SELECT *
FROM Patient 
INNER JOIN 
	Booking 
ON Patient.PatientId = Booking.PatientId
INNER JOIN 
	Chart 
On Booking.PatientId = Chart.PatientId

-- Left Outer Join, Joins  Booking and Patient tables on PatientId
select
   PatientName,
   RoomNumber
from
   Booking b
left outer join
   Patient p
on
   b.PatientId = p.PatientId;
   
-- Right Outer Join, joins Booking and Invoice tables on ReservationNumber
select 
	*
from
	Booking 
right outer join
	Invoice 
on
	Booking.ReservationNumber = Invoice.ReservationNumber;
   
-- Update Data, change patient 1's name in Patient table from John to Michael
UPDATE Patient
SET PatientName = 'Michael'
WHERE Patient.PatientId = 1;

-- Alter table Patient to add Previous History Of Mental Health Problems column
alter table
   Patient
add
   (
		MentalHealthHistory CHAR(1) DEFAULT 'N';
   );
   
-- Alter table Patient, change MentalHealthHistory column to have a value constraint that checks to make sure the value can only be 'Y' or 'N'
alter table
   Patient
add constraint
   check_MentalHealthHistory
CHECK 
   (
		MentalHealthHistory = 'Y' OR MentalHealthHistory = 'N'
    );

-- Alter table Patient, Modify PatientName column to allow for up to 21 characters instead of 11
ALTER TABLE Patient
  MODIFY PatientName varchar2(21) not null;
  
-- Alter table Patient, drop the MentalHealthHistory column
alter table
   Patient
drop column
   MentalHealthHistory;  
   
-- Alter table Booking, drop Patient_Booking_FK foreign key constraint
ALTER TABLE Booking
DROP CONSTRAINT Patient_Booking_FK;

-- Commit included to persist the data
commit;