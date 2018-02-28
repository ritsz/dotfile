#!/usr/bin/python
import os
import sys
import paramiko


hostname = "uslinux01.commvault.com"
port = 22
username = "gbuilder"
password = "gbuilder"
nbytes = 4096
nodeName = ''


def SSH_Session():
    ssh = paramiko.Transport((hostname, port))
    ssh.connect(username=username, password=password)
    session = ssh.open_channel(kind='session')
    return session

# Convert local nfs parent path to the parent path on the server.
# Assumes that the fullpath of file in local nfs mount is provided.
def create_path(s, revIndex = 0):
    global nodeName
    index = int(-1 - revIndex)
    #Ignore the first 2 splits as it is '' and 'DIR'
    x = s.split('/')[2:index]
    nodeName = '/build/11.0/Build80_'+x[0]
    print "Nodename: ", nodeName
    x.pop(0)
    x.insert(0, nodeName)
    path = '/'.join(x)
    return path

def get_file_name(s):
    # Diff of entires directory.
    if(s[-1] == '/'):
        return '.'

    x = s.split('/')
    return x[-1]

def downloaddiff(fileParentPath, fileName, rev = ''):
    print fileParentPath
    print fileName
    cmd = 'cd ' + fileParentPath + '; cvs diff ' + rev + fileName
    cmd += ' > diff_file; cat diff_file; rm -f diff_file'
    print cmd
    session = SSH_Session();
    session.exec_command(cmd)

    stdout_data = []
    stderr_data = []

    while True:
        if session.recv_ready():
            stdout_data.append(session.recv(nbytes))
        if session.recv_stderr_ready():
            stderr_data.append(session.recv_stderr(nbytes))
        if session.exit_status_ready():
            break

    if( session.recv_exit_status() != 0 ):
        print ''.join(stderr_data)
        return 13 #error in diff
    else:
        tmpdiffname = '/tmp/tmpdiff'
        print 'Writing diff to ' + tmpdiffname
        with open(tmpdiffname, 'w') as tmpdiff:
            tmpdiff.write(''.join(stdout_data))


def compile(path):
    global nodeName
    cmd = ''
    if 'ClProxyConnAPI/Client' in path:
        cmd = 'cd ' + nodeName +'/cxunix/source; ./buildIBMI'
    else:
        cmd = 'cd ' + path + '; make64; '
    session = SSH_Session();
    session.exec_command(cmd)

    stdout_data = []
    stderr_data = []

    while True:
        if session.recv_ready():
            stdout_data.append(session.recv(nbytes))
        if session.recv_stderr_ready():
            stderr_data.append(session.recv_stderr(nbytes))
        if session.exit_status_ready():
            break

    if( (session.recv_exit_status() != 0) and (''.join(stderr_data) == 'make: *** No targets specified and no makefile found.  Stop.\n')):
        print ''.join(stderr_data)
        return 11 #error; no make file
    else:
        if(session.recv_exit_status() != 0):
            print 'Exit Code: ', session.recv_exit_status()
            print ''.join(stderr_data)
            return 12   #error in compilation
        else:
            print ''.join(stdout_data)
            return 0 #success


if __name__ == "__main__":
    if(len(sys.argv) < 3):
        sys.exit(-1)    #Give an option, #1 job, #2 file-path
    
    s = sys.argv[2]

    if(int(sys.argv[1]) < 3):
        retries = 0
        ret = 0
        while retries < int(sys.argv[1]):
            path = create_path(s, retries)
            retries = retries + 1;
            ret = compile(path)
        
        # For option 1, it returns the success/error of current path.
        # Caller can handle the error and decide if it wants to retry.
        # For option 2, it always does a retry and returns the final code.
        sys.exit(ret)
    elif(int(sys.argv[1]) == 3):
        #TODO: Handle other CVS commands
        rev = ''
        if(len(sys.argv) >= 4):
            rev = sys.argv[3]

        ret = downloaddiff(create_path(sys.argv[2]), get_file_name(sys.argv[2]), rev)
        sys.exit(ret)
