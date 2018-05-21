#!/usr/bin/env python3

import sys, re, os, subprocess
from datetime import *

REMOTE_USER = "personal-backup"
HOST = "192.168.0.166"

SSH_KEY = "~/.ssh/{}".format(REMOTE_USER)
SSH_OPT = ['-i' '{}'.format(SSH_KEY)]

HOME = os.environ["HOME"]
SRC = "{}/Documents/".format(HOME)
DST = "/mnt/disk/backup/Documents"

RSYNC_OPT = "-aPh --delete --delete-excluded"
EXCLUDE = "--exclude .git/"

#print(SSH_OPT)

slots = []
slots += [(i, i+10) for i in range(10, 60, 10)]
slots += [(i, i+30) for i in range(60, 180, 30)]
slots += [(i, i+180) for i in range(180, 360, 180)]
begin_slot = (-1, 10)
end_slot = (slots[-1][1], 9999)
#print(slots)

def snapshot_folders_to_timestamps(snapshot_folders):
    """Take a list of snapshot folder paths.
    Return a list of parsed timestamps."""

    re_snapshot_timestamp = re.compile("\d+\.\d{4}-\d{2}-\d{2}")
    timestamps = []
    for snapshot_folder in snapshot_folders:
        if not re_snapshot_timestamp.match(snapshot_folder):
            continue
        timestamp_full = snapshot_folder.split("/")[-1]
        timestamp = int(timestamp_full.split(".")[0])
        timestamps.append(datetime.fromtimestamp(timestamp, tz=timezone.utc))
    return timestamps

def filter_timestamps_by_slots(timestamps, slots):
    """Take a list of timestamps and slots.
    Return a tuple with timestamps to keep and timestamps to remove."""

    last_timestamp = max(timestamps)
    last_date = last_timestamp.date()
    last_date = datetime(year=last_date.year, month=last_date.month, day=last_date.day, tzinfo=timezone.utc)

    end = last_date - timedelta(days=begin_slot[0])
    start = last_date - timedelta(days=begin_slot[1])
    timestamps_keep = list(filter(lambda d: start < d and d <= end, timestamps))

    for slot in slots:
        end = last_date - timedelta(days=slot[0])
        start = last_date - timedelta(days=slot[1])
        slot_timestamps = list(filter(lambda d: start < d and d <= end, timestamps))
        if len(slot_timestamps) > 0:
            timestamps_keep.append(min(slot_timestamps))
            #print(slot, min(slot_timestamps))
    timestamps_keep.sort()
    timestamps_delete = list(set(timestamps).difference(set(timestamps_keep)))
    timestamps_delete.sort()

    return (timestamps_keep, timestamps_delete)

def simulate():
    last_date = datetime.today()
    timestamps_keep = [last_date - timedelta(days=i) for i in range(1, 1000)]

    for i in range(1, 1000):
        timestamps_keep.append(last_date + timedelta(days=i))
        (timestamps_keep, timestamps_delete) = filter_timestamps_by_slots(timestamps_keep, slots)

    return timestamps_keep

print("Retrieving list of snapshot folders...")
p = subprocess.Popen(['sftp', '-q'] + SSH_OPT + ["{}@{}".format(REMOTE_USER, HOST)],
        stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
out = p.communicate("cd {dst}\nls -l1\nexit".format(dst=DST).encode(), timeout=10)
snapshot_folders = out[0].decode('utf8').split('\n')[2:-2]
timestamps = snapshot_folders_to_timestamps(snapshot_folders)
(timestamps_keep, timestamps_delete) = filter_timestamps_by_slots(timestamps, slots)
#print(timestamps_delete)

remove_list_cmd = ""
for timestamp in timestamps_delete:
    filename = "{}.{}".format(int(timestamp.timestamp()), timestamp.strftime("%Y-%m-%d"))
    remove_list_cmd += "\nrename {0} trash/{0}".format(filename)

#print(remove_list_cmd)

# Move folders to delete to trash folder
print("Moving snapshots folder to delete to trash folder...")
p = subprocess.Popen(['sftp', '-q'] + SSH_OPT + ["{}@{}".format(REMOTE_USER, HOST)],
        stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
out = p.communicate("cd {dst}\nmkdir empty\nmkdir trash\n{cmd}\nexit".format(dst=DST, cmd=remove_list_cmd).encode(),
        timeout=10)

if p.returncode != 0:
    print(out[1].decode('utf8'))

# Empty trash folder
print("Emptying trash folder...")
p = subprocess.run(["ssh"] + SSH_OPT + ["{}@{}".format(REMOTE_USER, HOST)] + \
        ["rsync -a --delete {dst}/empty/ {dst}/trash".format(dst=DST)],
        stderr=subprocess.PIPE)

if p.returncode != 0:
    print(p.stderr.decode('utf8'))

# Remove temporary folders
print("Removing temporary folders...")
p = subprocess.Popen(['sftp', '-q'] + SSH_OPT + ["{}@{}".format(REMOTE_USER, HOST)],
        stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
out = p.communicate("cd {dst}\rmdir empty\nrmdir trash\nexit".format(dst=DST).encode(),
        timeout=10)

if p.returncode != 0:
    print(out[1].decode('utf8'))

#snapshot_folders = sys.stdin.readlines()
#timestamps = snapshot_folders_to_timestamps(snapshot_folders)
#(timestamps_keep, timestamps_delete) = filter_timestamps_by_slots(timestamps, slots)

#print("\tKeep")
#[print(d) for d in timestamps_keep]
#
#print("\tDelete")
#[print(d) for d in timestamps_delete]
