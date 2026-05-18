String cronExpr = '0 0 23 L * ?';
TimeLogAuditorBatch timeLogAuditorBatch = new TimeLogAuditorBatch();
String jobId = System.schedule(cronExpr, timeLogAuditorBatch);
System.debug('Job scheduled successfully. Job ID: ' + jobId);
