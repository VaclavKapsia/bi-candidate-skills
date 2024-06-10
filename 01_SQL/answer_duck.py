import duckdb


def print_query(sql_script):
    with open(sql_script, 'r') as f:
        # Opted for dataframe just to easily display the column header
        result_df = con.execute(f.read()).fetchdf()
        print(result_df)
        print('\n========\n')


con = duckdb.connect("01_sql.db")
print_query('answer_1.sql')
print_query('answer_2.sql')
print_query('answer_3.sql')
