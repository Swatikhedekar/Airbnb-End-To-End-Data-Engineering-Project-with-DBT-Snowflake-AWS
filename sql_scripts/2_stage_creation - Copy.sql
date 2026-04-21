--CREATE FILE FORMAT AND STAGE
CREATE OR REPLACE FILE FORMAT csv_format 
TYPE = 'CSV' 
FIELD_DELIMITER = ',' 
SKIP_HEADER = 1 
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

SHOW FILE FORMATS;

CREATE OR REPLACE STAGE snowstage 
FILE_FORMAT = csv_format 
URL = 's3://snowbucket-sk/source/';


SHOW STAGES;
-- insert data from aws s3 to snowflake
COPY INTO AIRBNB_DB.STAGING.BOOKINGS
FROM
    @snowstage FILES =('bookings.csv') CREDENTIALS =(
        aws_key_id = '#####',
        aws_secret_key = '####'
        );

COPY INTO AIRBNB_DB.STAGING.HOSTS
FROM
    @snowstage FILES =('hosts.csv') CREDENTIALS =(
        aws_key_id = '####',
        aws_secret_key = '####'
        );
        
COPY INTO AIRBNB_DB.STAGING.LISTINGS   
FROM
    @snowstage FILES =('listings.csv') CREDENTIALS =(
        aws_key_id = '####',
        aws_secret_key = '####'
        );
        
-- SEE THE DATA IN TABLE
SELECT COUNT(*) FROM BOOKINGS;
SELECT COUNT(*) FROM HOSTS;
SELECT COUNT(*) FROM LISTINGS;

SELECT * FROM BOOKINGS;
SELECT * FROM HOSTS;
SELECT * FROM LISTINGS;