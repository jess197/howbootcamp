from sqlalchemy import create_engine
import pandas as pd 

engine = create_engine('postgresql+psycopg2://root:root@localhost/test_db')

sql = ''' 
 select * from vw_artist;
'''

df_artist = pd.read_sql_query(sql,engine)

df_song = pd.read_sql_query('select * from vw_song;',engine)
