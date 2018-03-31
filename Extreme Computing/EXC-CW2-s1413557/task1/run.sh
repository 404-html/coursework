hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.map.output.key.field.separator=" " \
  -D stream.map.output.field.separator=" " \
  -D stream.num.map.output.key.fields=3 \
  -D num.key.fields.for.partition=1 \
  -D mapreduce.partition.keycomparator.options="-k1,1 -k3,3n" \
  -D mapreduce.partition.keypartitioner.options="-k1,1" \
 -input /data/assignments/ex2/part1/large \
 -output /user/$USER/assignment2/task1-temp \
 -mapper ~/Desktop/EXC-CW2-s1413557/task1/mapper.py \
 -file ~/Desktop/EXC-CW2-s1413557/task1/mapper.py \
 -combiner ~/Desktop/EXC-CW2-s1413557/task1/combiner.py \
 -file ~/Desktop/EXC-CW2-s1413557/task1/combiner.py \
 -reducer ~/Desktop/EXC-CW2-s1413557/task1/reducer.py \
 -file ~/Desktop/EXC-CW2-s1413557/task1/reducer.py \
 -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

#some final sorting 'n stuff
hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.reduces=1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.map.output.key.field.separator=" " \
  -D stream.map.output.field.separator=" " \
  -D stream.num.map.output.key.fields=2 \
  -D num.key.fields.for.partition=1 \
  -D mapreduce.partition.keycomparator.options="-k1,1" \
  -D mapreduce.partition.keypartitioner.options="-k1,1" \
 -input /user/$USER/assignment2/task1-temp/* \
 -output /user/$USER/assignment2/task1/ \
 -mapper cat \
 -reducer cat \
 -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

hdfs dfs -rm -r assignment2/task1-temp/
