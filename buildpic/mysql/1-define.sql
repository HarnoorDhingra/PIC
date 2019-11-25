-- csv2mysql with arguments:
--   -o
--   1-define.sql
--   -u
--   -k
--   -p
--   -z
--   ADMISSIONS.csv
--   CHARTEVENTS.csv
--   DIAGNOSES_ICD.csv
--   D_ICD_DIAGNOSES.csv
--   D_ITEMS.csv
--   D_LABITEMS.csv
--   EMR_SYMPTOMS.csv
--   ICUSTAYS.csv
--   INPUTEVENTS.csv
--   LABEVENTS.csv
--   MICROBIOLOGYEVENTS.csv
--   OR_EXAM_REPORT.csv
--   OUTPUTEVENTS.csv
--   PATIENTS.csv
--   PRESCRIPTIONS.csv
--   SURGERY_VITAL.csv

warnings

DROP TABLE IF EXISTS ADMISSIONS;
CREATE TABLE ADMISSIONS (	-- rows=13449
   ROW_ID SMALLINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ADMITTIME DATETIME NOT NULL,
   DISCHTIME DATETIME,
   DEATHTIME DATETIME,
   ADMISSION_DEPARTMENT VARCHAR(255) NOT NULL,	
   DISCHARGE_DEPARTMENT VARCHAR(255) NOT NULL,	
   INSURANCE VARCHAR(255) NOT NULL,	
   LANGUAGE VARCHAR(255),	
   RELIGION VARCHAR(255),	
   MARITAL_STATUS VARCHAR(255),	
   ETHNICITY VARCHAR(255) NOT NULL,	
   EDREGTIME DATETIME,
   EDOUTTIME DATETIME,
   DIAGNOSIS VARCHAR(255),
   ICD10_CODE_CN VARCHAR(255), 	
   HOSPITAL_EXPIRE_FLAG TINYINT UNSIGNED NOT NULL,
   HAS_CHARTEVENTS_DATA TINYINT UNSIGNED NOT NULL,
  UNIQUE KEY ADMISSIONS_ROW_ID (ROW_ID),	-- nvals=13449
  UNIQUE KEY ADMISSIONS_HADM_ID (HADM_ID)	-- nvals=13449
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'ADMISSIONS.csv' INTO TABLE ADMISSIONS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\' ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ADMITTIME,@DISCHTIME,@DEATHTIME,@ADMISSION_DEPARTMENT,@DISCHARGE_DEPARTMENT,@INSURANCE,@LANGUAGE,@RELIGION,@MARITAL_STATUS,@ETHNICITY,@EDREGTIME,@EDOUTTIME,@DIAGNOSIS,@ICD10_CODE_CN,@HOSPITAL_EXPIRE_FLAG,@HAS_CHARTEVENTS_DATA)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ADMITTIME = @ADMITTIME,
   DISCHTIME = IF(@DISCHTIME='', NULL, @DISCHTIME),
   DEATHTIME = IF(@DEATHTIME='', NULL, @DEATHTIME),
   ADMISSION_DEPARTMENT = @ADMISSION_DEPARTMENT,
   DISCHARGE_DEPARTMENT = @DISCHARGE_DEPARTMENT,
   INSURANCE = @INSURANCE,
   LANGUAGE = IF(@LANGUAGE='', NULL, @LANGUAGE),
   RELIGION = IF(@RELIGION='', NULL, @RELIGION),
   MARITAL_STATUS = IF(@MARITAL_STATUS='', NULL, @MARITAL_STATUS),
   ETHNICITY = @ETHNICITY,
   EDREGTIME = IF(@EDREGTIME='', NULL, @EDREGTIME),
   EDOUTTIME = IF(@EDOUTTIME='', NULL, @EDOUTTIME),
   DIAGNOSIS = IF(@DIAGNOSIS='', NULL, @DIAGNOSIS),
   ICD10_CODE_CN = IF(@ICD10_CODE_CN='', NULL, @ICD10_CODE_CN),
   HOSPITAL_EXPIRE_FLAG = @HOSPITAL_EXPIRE_FLAG,
   HAS_CHARTEVENTS_DATA = @HAS_CHARTEVENTS_DATA;

DROP TABLE IF EXISTS CHARTEVENTS;
CREATE TABLE CHARTEVENTS (	-- rows=2278978
   ROW_ID INT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID MEDIUMINT UNSIGNED,
   ITEMID VARCHAR(255) NOT NULL,
   CHARTTIME DATETIME NOT NULL,
   STORETIME DATETIME,
   VALUE VARCHAR(255),	
   VALUENUM FLOAT,
   VALUEUOM VARCHAR(255),
  UNIQUE KEY CHARTEVENTS_ROW_ID (ROW_ID)	-- nvals=2278978
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'CHARTEVENTS.csv' INTO TABLE CHARTEVENTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ICUSTAY_ID,@ITEMID,@CHARTTIME,@STORETIME,@VALUE,@VALUENUM,@VALUEUOM)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ICUSTAY_ID = IF(@ICUSTAY_ID='', NULL, @ICUSTAY_ID),
   ITEMID = @ITEMID,
   CHARTTIME = @CHARTTIME,
   STORETIME = IF(@STORETIME='', NULL, @STORETIME),
   VALUE = IF(@VALUE='', NULL, @VALUE),
   VALUENUM = IF(@VALUENUM='', NULL, @VALUENUM),
   VALUEUOM = IF(@VALUEUOM='', NULL, @VALUEUOM);

DROP TABLE IF EXISTS DIAGNOSES_ICD;
CREATE TABLE DIAGNOSES_ICD (	-- rows=13365
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   SEQ_NUM TINYINT UNSIGNED,
   ICD10_CODE_CN VARCHAR(255),	
  UNIQUE KEY DIAGNOSES_ICD_ROW_ID (ROW_ID)	-- nvals=13365
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'DIAGNOSES_ICD.csv' INTO TABLE DIAGNOSES_ICD
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@SEQ_NUM,@ICD10_CODE_CN)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   SEQ_NUM = IF(@SEQ_NUM='', NULL, @SEQ_NUM),
   ICD10_CODE_CN = IF(@ICD10_CODE_CN='', NULL, @ICD10_CODE_CN);

DROP TABLE IF EXISTS D_ICD_DIAGNOSES;
CREATE TABLE D_ICD_DIAGNOSES (	-- rows=25378
   ROW_ID SMALLINT UNSIGNED NOT NULL,
   ICD10_CODE_CN VARCHAR(255) NOT NULL,
   ICD10_CODE MEDIUMTEXT,	
   TITLE_CN VARCHAR(255) NOT NULL,	
   TITLE VARCHAR(255) NOT NULL,	
  UNIQUE KEY D_ICD_DIAGNOSES_ROW_ID (ROW_ID),	-- nvals=25378
  UNIQUE KEY D_ICD_DIAGNOSES_ICD10_CODE_CN (ICD10_CODE_CN)	-- nvals=25378
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'D_ICD_DIAGNOSES.csv' INTO TABLE D_ICD_DIAGNOSES
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@ICD10_CODE_CN,@ICD10_CODE,@TITLE_CN,@TITLE)
 SET
   ROW_ID = @ROW_ID,
   ICD10_CODE_CN = @ICD10_CODE_CN,
   ICD10_CODE = IF(@ICD10_CODE='', NULL, @ICD10_CODE),
   TITLE_CN = @TITLE_CN,
   TITLE = @TITLE;

DROP TABLE IF EXISTS D_ITEMS;
CREATE TABLE D_ITEMS (	-- rows=466
   ROW_ID SMALLINT UNSIGNED NOT NULL,
   ITEMID VARCHAR(255) NOT NULL,
   LABEL_CN VARCHAR(255)NOT NULL,
   LABEL TEXT NOT NULL,	
   LINKSTO VARCHAR(255) NOT NULL,	
   CATEGORY VARCHAR(255),	
   UNITNAME VARCHAR(255),		
  UNIQUE KEY D_ITEMS_ROW_ID (ROW_ID),	 -- rows=466
  UNIQUE KEY D_ITEMS_ITEMID (ITEMID)	 -- rows=466
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'D_ITEMS.csv' INTO TABLE D_ITEMS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@ITEMID,@LABEL_CN,@LABEL,@LINKSTO,@CATEGORY,@UNITNAME)
 SET
   ROW_ID = @ROW_ID,
   ITEMID = @ITEMID,
   LABEL_CN = @LABEL_CN,
   LABEL = @LABEL,
   LINKSTO = @LINKSTO,
   CATEGORY = IF(@CATEGORY='', NULL, @CATEGORY),
   UNITNAME = IF(@UNITNAME='', NULL, @UNITNAME);

DROP TABLE IF EXISTS D_LABITEMS;
CREATE TABLE D_LABITEMS (	-- rows=832
   ROW_ID SMALLINT UNSIGNED NOT NULL,
   ITEMID SMALLINT UNSIGNED NOT NULL,
   LABEL_CN TEXT NOT NULL,
   LABEL VARCHAR(255) NOT NULL,
   FLUID VARCHAR(255),
   CATEGORY VARCHAR(255),
   LOINC_CODE VARCHAR(255),
  UNIQUE KEY D_LABITEMS_ROW_ID (ROW_ID),	-- nvals=832
  UNIQUE KEY D_LABITEMS_ITEMID (ITEMID)	-- nvals=832
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'D_LABITEMS.csv' INTO TABLE D_LABITEMS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@ITEMID,@LABEL_CN,@LABEL,@FLUID,@CATEGORY,@LOINC_CODE)
 SET
   ROW_ID = @ROW_ID,
   ITEMID = @ITEMID,
   LABEL_CN = @LABEL_CN,
   LABEL = @LABEL,
   FLUID = IF(@FLUID='', NULL, @FLUID),
   CATEGORY = IF(@CATEGORY='', NULL, @CATEGORY),
   LOINC_CODE = IF(@LOINC_CODE='', NULL, @LOINC_CODE);

DROP TABLE IF EXISTS EMR_SYMPTOMS;
CREATE TABLE EMR_SYMPTOMS (	-- rows=402142
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   EMR_ID MEDIUMINT UNSIGNED NOT NULL,
   RECORDTIME DATETIME NOT NULL,
   SYMPTOM_NAME_CN VARCHAR(255) NOT NULL,
   SYMPTOM_NAME VARCHAR(255) NOT NULL,
   SYMPTOM_ATTRIBUTE VARCHAR(255) NOT NULL,
  UNIQUE KEY EMR_SYMPTOMS_ROW_ID (ROW_ID)	-- nvals=402142
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'EMR_SYMPTOMS.csv' INTO TABLE EMR_SYMPTOMS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@EMR_ID,@RECORDTIME,@SYMPTOM_NAME_CN,@SYMPTOM_NAME,@SYMPTOM_ATTRIBUTE)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   EMR_ID = @EMR_ID,
   RECORDTIME = @RECORDTIME,
   SYMPTOM_NAME_CN = @SYMPTOM_NAME_CN,
   SYMPTOM_NAME = @SYMPTOM_NAME,
   SYMPTOM_ATTRIBUTE = @SYMPTOM_ATTRIBUTE;

DROP TABLE IF EXISTS ICUSTAYS;
CREATE TABLE ICUSTAYS (	-- rows=13941
   ROW_ID SMALLINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID MEDIUMINT UNSIGNED NOT NULL,
   FIRST_CAREUNIT VARCHAR(255) NOT NULL,	
   LAST_CAREUNIT VARCHAR(255) NOT NULL,	
   FIRST_WARDID SMALLINT UNSIGNED NOT NULL,
   LAST_WARDID SMALLINT UNSIGNED NOT NULL,
   INTIME DATETIME NOT NULL,
   OUTTIME DATETIME,
   LOS FLOAT,
  UNIQUE KEY ICUSTAYS_ROW_ID (ROW_ID),	-- nvals=13941
  UNIQUE KEY ICUSTAYS_ICUSTAY_ID (ICUSTAY_ID)	-- nvals=13941
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'ICUSTAYS.csv' INTO TABLE ICUSTAYS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ICUSTAY_ID,@FIRST_CAREUNIT,@LAST_CAREUNIT,@FIRST_WARDID,@LAST_WARDID,@INTIME,@OUTTIME,@LOS)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ICUSTAY_ID = @ICUSTAY_ID,
   FIRST_CAREUNIT = @FIRST_CAREUNIT,
   LAST_CAREUNIT = @LAST_CAREUNIT,
   FIRST_WARDID = @FIRST_WARDID,
   LAST_WARDID = @LAST_WARDID,
   INTIME = @INTIME,
   OUTTIME = IF(@OUTTIME='', NULL, @OUTTIME),
   LOS = IF(@LOS='', NULL, @LOS);

DROP TABLE IF EXISTS INPUTEVENTS;
CREATE TABLE INPUTEVENTS (	-- rows=26884
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID MEDIUMINT UNSIGNED,
   CHARTTIME DATETIME NOT NULL,
   AMOUNT FLOAT NOT NULL,
   AMOUNTUOM VARCHAR(255),	
   STORETIME DATETIME NOT NULL,
  UNIQUE KEY INPUTEVENTS_ROW_ID (ROW_ID)	-- nvals=26884
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'INPUTEVENTS.csv' INTO TABLE INPUTEVENTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ICUSTAY_ID,@CHARTTIME,@AMOUNT,@AMOUNTUOM,@STORETIME)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ICUSTAY_ID = IF(@ICUSTAY_ID='', NULL, @ICUSTAY_ID),
   CHARTTIME = @CHARTTIME,
   AMOUNT = @AMOUNT,
   AMOUNTUOM = IF(@AMOUNTUOM='', NULL, @AMOUNTUOM),
   STORETIME = @STORETIME;

DROP TABLE IF EXISTS LABEVENTS;
CREATE TABLE LABEVENTS (	-- rows=10094117
   ROW_ID INT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ITEMID SMALLINT UNSIGNED NOT NULL,
   CHARTTIME DATETIME NOT NULL,
   VALUE TEXT,
   VALUENUM FLOAT,
   VALUEUOM VARCHAR(255),	
   FLAG VARCHAR(255),	
  UNIQUE KEY LABEVENTS_ROW_ID (ROW_ID)	-- nvals=10094117
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'LABEVENTS.csv' INTO TABLE LABEVENTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ITEMID,@CHARTTIME,@VALUE,@VALUENUM,@VALUEUOM,@FLAG)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ITEMID = @ITEMID,
   CHARTTIME = @CHARTTIME,
   VALUE = IF(@VALUE='', NULL, @VALUE),
   VALUENUM = IF(@VALUENUM='', NULL, @VALUENUM),
   VALUEUOM = IF(@VALUEUOM='', NULL, @VALUEUOM),
   FLAG = IF(@FLAG='', NULL, @FLAG);

DROP TABLE IF EXISTS MICROBIOLOGYEVENTS;
CREATE TABLE MICROBIOLOGYEVENTS (	-- rows=183869
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   CHARTTIME DATETIME NOT NULL,
   SPEC_ITEMID TEXT,
   SPEC_TYPE_DESC TEXT,
   ORG_ITEMID VARCHAR(255),
   ORG_NAME VARCHAR(255),	
   AB_ITEMID VARCHAR(255),
   AB_NAME VARCHAR(255),	
   DILUTION_TEXT VARCHAR(255),	
   DILUTION_COMPARISON VARCHAR(255),	
   DILUTION_VALUE FLOAT,
   INTERPRETATION VARCHAR(255),	
  UNIQUE KEY MICROBIOLOGYEVENTS_ROW_ID (ROW_ID)	-- nvals=183869
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'MICROBIOLOGYEVENTS.csv' INTO TABLE MICROBIOLOGYEVENTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@CHARTTIME,@SPEC_ITEMID,@SPEC_TYPE_DESC,@ORG_ITEMID,@ORG_NAME,@AB_ITEMID,@AB_NAME,@DILUTION_TEXT,@DILUTION_COMPARISON,@DILUTION_VALUE,@INTERPRETATION)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   CHARTTIME = @CHARTTIME,
   SPEC_ITEMID = IF(@SPEC_ITEMID='', NULL, @SPEC_ITEMID),
   SPEC_TYPE_DESC = IF(@SPEC_TYPE_DESC='', NULL, @SPEC_TYPE_DESC),
   ORG_ITEMID = IF(@ORG_ITEMID='', NULL, @ORG_ITEMID),
   ORG_NAME = IF(@ORG_NAME='', NULL, @ORG_NAME),
   AB_ITEMID = IF(@AB_ITEMID='', NULL, @AB_ITEMID),
   AB_NAME = IF(@AB_NAME='', NULL, @AB_NAME),
   DILUTION_TEXT = IF(@DILUTION_TEXT='', NULL, @DILUTION_TEXT),
   DILUTION_COMPARISON = IF(@DILUTION_COMPARISON='', NULL, @DILUTION_COMPARISON),
   DILUTION_VALUE = IF(@DILUTION_VALUE='', NULL, @DILUTION_VALUE),
   INTERPRETATION = IF(@INTERPRETATION='', NULL, @INTERPRETATION);

DROP TABLE IF EXISTS OR_EXAM_REPORTS;
CREATE TABLE OR_EXAM_REPORTS (	-- rows=183809
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   EXAMTIME DATETIME,
   REPORTTIME DATETIME,
   EXAM_ITEM_TYPE_NAME VARCHAR(255),
   EXAM_ITEM_NAME VARCHAR(255),
   EXAM_PART_NAME VARCHAR(255),	
  UNIQUE KEY OR_EXAM_REPORTS_ROW_ID (ROW_ID)	-- nvals=183809
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'OR_EXAM_REPORTS.csv' INTO TABLE OR_EXAM_REPORTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@EXAMTIME,@REPORTTIME,@EXAM_ITEM_TYPE_NAME,@EXAM_ITEM_NAME,@EXAM_PART_NAME)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   EXAMTIME =IF(@EXAMTIME='', NULL, @EXAMTIME),
   REPORTTIME =IF(@REPORTTIME='', NULL, @REPORTTIME),
   EXAM_ITEM_TYPE_NAME = IF(@EXAM_ITEM_TYPE_NAME='', NULL, @EXAM_ITEM_TYPE_NAME),
   EXAM_ITEM_NAME = IF(@EXAM_ITEM_NAME='', NULL, @EXAM_ITEM_NAME),
   EXAM_PART_NAME = IF(@EXAM_PART_NAME='', NULL, @EXAM_PART_NAME);

DROP TABLE IF EXISTS OUTPUTEVENTS;
CREATE TABLE OUTPUTEVENTS (	-- rows=39891
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID MEDIUMINT UNSIGNED,
   CHARTTIME DATETIME NOT NULL,
   ITEMID VARCHAR(255) NOT NULL,
   VALUE FLOAT NOT NULL,
   VALUEUOM VARCHAR(255),	
   STORETIME DATETIME NOT NULL,
  UNIQUE KEY OUTPUTEVENTS_ROW_ID (ROW_ID)	-- nvals=39891
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'OUTPUTEVENTS.csv' INTO TABLE OUTPUTEVENTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ICUSTAY_ID,@CHARTTIME,@ITEMID,@VALUE,@VALUEUOM,@STORETIME)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ICUSTAY_ID = IF(@ICUSTAY_ID='', NULL, @ICUSTAY_ID),
   CHARTTIME = @CHARTTIME,
   ITEMID = @ITEMID,
   VALUE = @VALUE,
   VALUEUOM = IF(@VALUEUOM='', NULL, @VALUEUOM),
   STORETIME = @STORETIME;
   
DROP TABLE IF EXISTS PATIENTS;
CREATE TABLE PATIENTS (	-- rows=12881
   ROW_ID SMALLINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   GENDER VARCHAR(255) NOT NULL,
   DOB DATETIME NOT NULL,	
   DOD DATETIME,
   EXPIRE_FLAG TINYINT UNSIGNED NOT NULL,
  UNIQUE KEY PATIENTS_ROW_ID (ROW_ID),	-- nvals=12881
  UNIQUE KEY PATIENTS_SUBJECT_ID (SUBJECT_ID)	-- nvals=12881
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'PATIENTS.csv' INTO TABLE PATIENTS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@GENDER,@DOB,@DOD,@EXPIRE_FLAG)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   GENDER = @GENDER,
   DOB = @DOB,
   DOD = IF(@DOD='', NULL, @DOD),
   EXPIRE_FLAG = @EXPIRE_FLAG;

DROP TABLE IF EXISTS PRESCRIPTIONS;
CREATE TABLE PRESCRIPTIONS (	-- rows=1256591
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID MEDIUMINT UNSIGNED,
   STARTDATE DATETIME,
   ENDDATE DATETIME,
   DRUG_NAME_CN VARCHAR(255) NOT NULL,
   DRUG_NAME VARCHAR(255) NOT NULL,	
   PROD_STRENGTH VARCHAR(255),
   DRUG_NAME_GENERIC VARCHAR(255),	
   DOSE_VAL_RX VARCHAR(255),	
   DOSE_UNIT_RX VARCHAR(255),	
   DRUG_FORM VARCHAR(255),	
  UNIQUE KEY PRESCRIPTIONS_ROW_ID (ROW_ID)	-- nvals=1256591
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'PRESCRIPTIONS.csv' INTO TABLE PRESCRIPTIONS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@ICUSTAY_ID,@STARTDATE,@ENDDATE,@DRUG_NAME_CN,@DRUG_NAME,@PROD_STRENGTH,@DRUG_NAME_GENERIC,@DOSE_VAL_RX,@DOSE_UNIT_RX,@DRUG_FORM)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   ICUSTAY_ID = IF(@ICUSTAY_ID='', NULL, @ICUSTAY_ID),
   STARTDATE = IF(@STARTDATE='', NULL, @STARTDATE),
   ENDDATE = IF(@ENDDATE='', NULL, @ENDDATE),
   DRUG_NAME_CN = @DRUG_NAME_CN,
   DRUG_NAME = @DRUG_NAME,
   PROD_STRENGTH = IF(@PROD_STRENGTH='', NULL, @PROD_STRENGTH),
   DRUG_NAME_GENERIC = IF(@DRUG_NAME_GENERIC='', NULL, @DRUG_NAME_GENERIC),
   DOSE_VAL_RX = IF(@DOSE_VAL_RX='', NULL, @DOSE_VAL_RX),
   DOSE_UNIT_RX = IF(@DOSE_UNIT_RX='', NULL, @DOSE_UNIT_RX),
   DRUG_FORM = IF(@DRUG_FORM='', NULL, @DRUG_FORM);

DROP TABLE IF EXISTS SURGERY_VITAL_SIGNS;
CREATE TABLE SURGERY_VITAL_SIGNS (	-- rows=1216011
   ROW_ID MEDIUMINT UNSIGNED NOT NULL,
   SUBJECT_ID MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID MEDIUMINT UNSIGNED NOT NULL,
   VISIT_ID TINYINT UNSIGNED NOT NULL,
   OPER_ID TINYINT UNSIGNED NOT NULL,
   ITEM_NO MEDIUMINT UNSIGNED NOT NULL,
   MONITORTIME DATETIME NOT NULL,
   ITEMID VARCHAR(255) NOT NULL,
   VALUE SMALLINT UNSIGNED NOT NULL,
  UNIQUE KEY SURGERY_VITAL_SIGNS_ROW_ID (ROW_ID)	-- nvals=1216011
  )
  CHARACTER SET = UTF8;

LOAD DATA LOCAL INFILE 'SURGERY_VITAL_SIGNS.csv' INTO TABLE SURGERY_VITAL_SIGNS
   FIELDS TERMINATED BY ',' ESCAPED BY '\\'  ENCLOSED BY '"'
   LINES TERMINATED BY '\r\n'
   IGNORE 1 LINES
   (@ROW_ID,@SUBJECT_ID,@HADM_ID,@VISIT_ID,@OPER_ID,@ITEM_NO,@MONITORTIME,@ITEMID,@VALUE)
 SET
   ROW_ID = @ROW_ID,
   SUBJECT_ID = @SUBJECT_ID,
   HADM_ID = @HADM_ID,
   VISIT_ID = @VISIT_ID,
   OPER_ID = @OPER_ID,
   ITEM_NO = @ITEM_NO,
   MONITORTIME = @MONITORTIME,
   ITEMID = @ITEMID,
   VALUE = @VALUE;
