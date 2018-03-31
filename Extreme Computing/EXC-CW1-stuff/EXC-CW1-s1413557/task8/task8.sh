hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapred.reduce.tasks=1 \
 -input /user/$USER/data/output/task7 \
 -output /user/$USER/data/output/task8 \
 -mapper /bin/cat \
 -reducer reducer.py \
 -file reducer.py
