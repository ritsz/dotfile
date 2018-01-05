#!/usr/bin/python
import os
import sys
import paramiko


hostname = "uslinux01.commvault.com"
port = 22
username = "gbuilder"
password = "gbuilder"
nbytes = 4096


def SSH_Session():
    ssh = paramiko.Transport((hostname, port))
    ssh.connect(username=username, password=password)
    session = ssh.open_channel(kind='session')
    return session

def create_path(s, retry):
    #Ignore the first 2 splits as it is '' and 'DIR'
    print s
    index = int(-1 - retry)
    x = s.split('/')[2:index]
    nodeName = '/build/11.0/Build80_'+x[0]
    print 'Node Name ', nodeName
    x.pop(0)
    x.insert(0, nodeName)
    path = '/'.join(x)
    return path

def getfullpath(s):
	pdir = os.getcwd()
	return pdir + '/' + s;

def compile(s):
    if(len(s.split('/')) == 1):
	s = getfullpath(s)
	print("Compile path:", s)

    retry = 0
    while(retry < 2):
        path = create_path(s, retry)
        retry = retry + 1
        print 'Compiling :', path
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

        if(retry == 1 and (session.recv_exit_status() != 0) and (''.join(stderr_data) == 'make: *** No targets specified and no makefile found.  Stop.\n')):
            print "No Makefile found. Check parent folder"
            pass
        else:
            if(session.recv_exit_status() == 0):
                print ''.join(stdout_data)
                return
            print 'Exit Code: ', session.recv_exit_status()
            print ''.join(stderr_data)


if __name__ == "__main__":
    if(len(sys.argv) > 1):
        compile(sys.argv[1])

