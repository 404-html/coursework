# Using same code for mapper and reducer. (Just to reduce work on reducer)
# Each mapper pick 1 line from stream, and reducer pick 1 line from mapper outputs. 
hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
  -D mapreduce.job.reduces=1 \
 -input /data/assignments/ex2/part3/webLarge.txt \
 -output /user/$USER/assignment2/task4 \
 -mapper ~/Desktop/EXC-CW2-s1413557/task4/reducer.py \
 -file ~/Desktop/EXC-CW2-s1413557/task4/reducer.py \
 -reducer ~/Desktop/EXC-CW2-s1413557/task4/reducer.py \
 -file ~/Desktop/EXC-CW2-s1413557/task4/reducer.py
