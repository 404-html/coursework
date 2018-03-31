# Sets memory.mb=2500 for my terrible mapper, probably shouldn't do this.
#  -D mapreduce.map.memory.mb=2500 \
# Without this line, the mappers fail a lot, sometimes it fails completely.
# Container [pid=78135,containerID=container_1509985674868_0577_01_000002] is running beyond virtual memory limits. Current usage: 280.3 MB of 1 GB physical memory used; 2.2 GB of 2.1 GB virtual memory used. Killing container.
# \"MapReduce is currently still broken.\"
#    - Kenneth, Nov 6, on Piazza question id 216

# Removed the above line from code.
# \"The cluster should be fixed.\"
#    - Kenneth, Nov 13, on Email.

hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.map.output.key.field.separator=" " \
  -D stream.map.output.field.separator=" " \
  -D stream.num.map.output.key.fields=4 \
  -D num.key.fields.for.partition=4 \
  -D mapreduce.partition.keycomparator.options="-k1,1n -k2,2" \
  -D mapreduce.partition.keypartitioner.options="-k1,2" \
 -input /data/assignments/ex2/part2/stackLarge.txt \
 -output /user/$USER/assignment2/task3-temp/ \
 -mapper ~/Desktop/EXC-CW2-s1413557/task3/mapper.py \
 -file ~/Desktop/EXC-CW2-s1413557/task3/mapper.py \
 -reducer ~/Desktop/EXC-CW2-s1413557/task3/reducer.py \
 -file ~/Desktop/EXC-CW2-s1413557/task3/reducer.py \
 -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.reduces=1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.map.output.key.field.separator=" " \
  -D stream.map.output.field.separator=" " \
  -D stream.num.map.output.key.fields=2 \
  -D mapreduce.partition.keycomparator.options="-k1,1n -k2,2n" \
 -input /user/$USER/assignment2/task3-temp/* \
 -output /user/$USER/assignment2/task3-temp2 \
 -mapper cat \
 -reducer ~/Desktop/EXC-CW2-s1413557/task3/reducer2.py \
 -file ~/Desktop/EXC-CW2-s1413557/task3/reducer2.py \
 -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.reduces=1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.map.output.key.field.separator=";" \
  -D stream.map.output.field.separator=";" \
  -D stream.num.map.output.key.fields=3 \
  -D mapreduce.partition.keycomparator.options=-k2,2nr \
 -input /user/$USER/assignment2/task3-temp2/* \
 -output /user/$USER/assignment2/task3 \
 -mapper cat \
 -reducer ~/Desktop/EXC-CW2-s1413557/task3/reducer3.py \
 -file ~/Desktop/EXC-CW2-s1413557/task3/reducer3.py \
 -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

hdfs dfs -rm -r assignment2/task3-temp/
hdfs dfs -rm -r assignment2/task3-temp2/
