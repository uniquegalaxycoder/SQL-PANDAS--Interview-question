"""
boAt Lifestyle is focusing on influencer marketing to build and scale their brand. They want to partner with power creators for their upcoming campaigns. 
The creators should satisfy below conditions to qualify:

1- They should have 100k+ followers on at least 2 social media platforms and
2- They should have at least 50k+ views on their latest YouTube video.

Write an SQL to get creator id and name satisfying above conditions.

Table: creators
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| id          | int         |
| name        | varchar(10) |
| followers   | int         |
| platform    | varchar(10) |
+-------------+-------------+

Table: youtube_videos
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| id           | int       |
| creator_id   | int       |
| publish_date | date      |
| views        | int       |
+--------------+-----------+

"""

import pandas as pd
import numpy as np
# print(creators_df)
# print(youtube_videos_df)

df1 = creators_df[creators_df['followers']> 100000].groupby(['id', 'name']).agg(platfom_count =('platform', 'count'))

df11 = df1[df1['platfom_count'] >= 2].reset_index()
# print(df11)

youtube_videos_df['row number'] = youtube_videos_df.sort_values(['creator_id', 'publish_date'], ascending=[True, False]).groupby('creator_id').cumcount()+1

df2 = youtube_videos_df[(youtube_videos_df['row number']==1) & (youtube_videos_df['views'] >= 50000)]

# joining both the table (df11 & df2 )

final_df = pd.merge(
	left = df11,
	right = df2,
	how = 'inner',
	left_on = 'id',
	right_on = 'creator_id'
).reset_index()

final_df = final_df.rename(columns = {'id_x': 'id'})
result = final_df[['id', 'name']]
print(result)
