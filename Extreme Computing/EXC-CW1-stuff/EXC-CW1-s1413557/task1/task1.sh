hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapred.reduce.tasks=0 \
 -input /data/assignments/ex1/webLarge.txt \
 -output /user/$USER/data/output/task1 \
 -mapper mapper.py \
 -file mapper.py
