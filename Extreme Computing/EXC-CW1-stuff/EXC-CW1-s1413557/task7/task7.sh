hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapred.reduce.tasks=1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D stream.num.map.output.key.fields=4 \
  -D mapreduce.partition.keycomparator.options="-k2,2n -k1,1r -k3,3" \
 -input /data/assignments/ex1/uniLarge.txt \
 -output /user/$USER/data/output/task7 \
 -mapper mapper.py \
 -file mapper.py \
 -reducer reducer.py \
 -file reducer.py
