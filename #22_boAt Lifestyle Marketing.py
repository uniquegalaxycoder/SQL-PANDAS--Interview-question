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
