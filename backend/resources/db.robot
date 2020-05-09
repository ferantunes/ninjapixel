*** Keywords ***
Connect DB
    Connect To Database    psycopg2    ninjapixel    postgres    qaninja    pgdb    5432

Clear Product Table
    Delete All Rows From Table    products
