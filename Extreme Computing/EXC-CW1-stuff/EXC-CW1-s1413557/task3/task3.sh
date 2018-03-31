hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapred.reduce.tasks=1 \
 -input /user/$USER/data/output/task2 \
 -output /user/$USER/data/output/task3 \
 -mapper mapper.py \
 -file mapper.py \
 -reducer reducer.py \
 -file reducer.py
