# Sets memory.mb=2500 for my terrible mapper, probably shouldn't do this.
# -D mapreduce.map.memory.mb=2500 \
# "MapReduce is currently still broken."
#    - Kenneth, 6 Nov, on Piazza question id 216

hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.reduces=1 \
  -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
  -D mapreduce.map.output.key.field.separator=" " \
  -D stream.map.output.field.separator=" " \
  -D stream.num.map.output.key.fields=2 \
  -D mapreduce.partition.keycomparator.options=-k1,1nr \
 -input /data/assignments/ex2/part2/stackLarge.txt \
 -output /user/$USER/assignment2/task2 \
 -mapper ~/Desktop/EXC-CW2-s1413557/task2/mapper.py \
 -file ~/Desktop/EXC-CW2-s1413557/task2/mapper.py \
 -reducer ~/Desktop/EXC-CW2-s1413557/task2/reducer.py \
 -file ~/Desktop/EXC-CW2-s1413557/task2/reducer.py \
 -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner
