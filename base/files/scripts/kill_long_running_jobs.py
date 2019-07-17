#!/usr/bin/python3
import yarn_api_client
import subprocess

RM_HOST = "yarn-master-0.yarn-service.yarn"
RM_PORT = 8088
##Kill jobs after MAX_JOB_ELAPSED_TIME
# Try to set this to 1.5 * (maximum expected runtime)
MAX_JOB_EXPECTED_RUNTIME = 18 * 60 
MAX_JOB_ELAPSED_TIME = 1.5 * MAX_JOB_EXPECTED_RUNTIME

def get_longest_running_job(rm):
    apps_raw = rm.cluster_applications(state="RUNNING").data
    if apps_raw["apps"] is None:
        return
    apps_data = apps_raw["apps"]["app"]
    apps_data.sort(key=lambda x: x['elapsedTime'], reverse=True)
    return apps_data[0]

def kill_job(rm, job_id):
    command_args = ["/opt/hadoop/bin/yarn", 'application', '-kill', job_id]
    print("Kill jobs [{}], command = [{}]".format(job_id, command_args))
    subprocess.run(command_args, check=True)

def connect_to_resource_manager():
    rm = yarn_api_client.resource_manager.ResourceManager(address=RM_HOST, port=RM_PORT)
    if not rm:
        raise "Could not connect to resource manager"
    return rm

rm = connect_to_resource_manager()
while True:
    app = get_longest_running_job(rm)
    if app is None:
        continue
    e_time = app["elapsedTime"] / 1000 #convert from mills to seconds
    if e_time > MAX_JOB_ELAPSED_TIME:
        kill_job(rm, app['id'])
