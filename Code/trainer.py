from __future__ import print_function
import tensorflow as tf
import argparse
import time
import os
import sys


FLAGS = None
log_dir = '/logdir'

def main(_):
	ps_hosts = FLAGS.ps_hosts.split(",")
	worker_hosts = FLAGS.worker_hosts.split(",")


	# Erstelle ein Cluster aus Parameterserver und Arbeiter
	# Somit weiß jede Instance über die anderen Instanzen Bescheid
	cluster = tf.train.ClusterSpec({"ps": ps_hosts, "worker": worker_hosts})
	
	# Starte einen Server
	server = tf.train.Server(cluster,
          job_name=FLAGS.job_name,
          task_index=FLAGS.task_index)
	
	if FLAGS.job_name == 'ps': 
		server.join()
	else:
		# Ist der Arbeiter Master?
		is_chief = (FLAGS.task_index == 0)
		

		# Graph
		with tf.device(tf.train.replica_device_setter(
        worker_device="/job:worker/task:%d" % FLAGS.task_index,
        cluster=cluster)):
			a = tf.Variable(tf.truncated_normal(shape=[2]),dtype=tf.float32)
			b = tf.Variable(tf.truncated_normal(shape=[2]),dtype=tf.float32)
			c=a+b

			target = tf.constant(100.,shape=[2],dtype=tf.float32)
			loss = tf.reduce_mean(tf.square(c-target))
		
			opt = tf.train.GradientDescentOptimizer(.0001).minimize(loss)

# Session
    # Monitored Training Session
		sess = tf.train.MonitoredTrainingSession(
          master=server.target,
          is_chief=is_chief)
		begin_time = time.time()
		for i in range(500):
			if sess.should_stop(): 
				print("break")	
				break
			sess.run(opt)
			if i % 10 == 0:
				r = sess.run(c)
				print(r)
				# print(sess.run({'ab':(a, b), 'total':c}))
			time.sleep(.1)
		print("Total Time: %3.2fs" % float(time.time() - begin_time))
		sess.close()

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.register("type", "bool", lambda v: v.lower() == "true")
  # Flags for defining the tf.train.ClusterSpec
  parser.add_argument(
      "--ps_hosts",
      type=str,
      default="",
      help="Comma-separated list of hostname:port pairs"
  )
  parser.add_argument(
      "--worker_hosts",
      type=str,
      default="",
      help="Comma-separated list of hostname:port pairs"
  )
  parser.add_argument(
      "--job_name",
      type=str,
      default="",
      help="One of 'ps', 'worker'"
  )
  # Flags for defining the tf.train.Server
  parser.add_argument(
      "--task_index",
      type=int,
      default=0,
      help="Index of task within the job"
  )
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)

