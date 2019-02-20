BEGIN TRANSACTION;
CREATE TABLE accounts (
	id INTEGER NOT NULL, 
	name VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "accounts" VALUES(1,'Demo Account 1');
INSERT INTO "accounts" VALUES(2,'Demo Account 2');
CREATE TABLE cumulusci_demo (
	id INTEGER NOT NULL, 
	name VARCHAR(255), 
	demo_date INTEGER(255), 
	account__c VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cumulusci_demo" VALUES(1,'Demo 1',100000,'1');
INSERT INTO "cumulusci_demo" VALUES(2,'Demo 2',-100000,'2');
COMMIT;
