#!/usr/bin/python
import os
import sys
import paramiko


hostname = "blr-dbc401.eng.vmware.com"
port = 22
username = "rritesh"
nbytes = 4096
diffCommand = "p4 diff -dub "
privkeyfile = "/mts-blr/home/rritesh/.ssh/id_rsa"


def SSH_Session():
    key = paramiko.RSAKey.from_private_key_file(privkeyfile)
    sshc = paramiko.Transport((hostname, port))
    sshc.connect(username = username, pkey = key  )
    return sshc.open_channel(kind='session')

def get_workspace(path):
    if path:
        return path.split("/")[4]

def downloaddiff(fileName, rev = ''):
    print fileName
    dirPath = os.path.dirname(fileName)
    client_root = get_workspace(fileName)
    cmd = 'goto %s ; ' % (client_root)
    cmd += 'cd %s ; ' % (dirPath)
    cmd += diffCommand + rev + fileName
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
    cmd = 'goto %s ; ' %(get_workspace(path))
    cmd += 'cd %s ; vbazel build ...:all' % (path)
    print(cmd)
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
            print 'Exit Code: ', session.recv_exit_status()
            print 'Data : '.join(stdout_data)
            return 0 #success


if __name__ == "__main__":
    if(len(sys.argv) < 3):
        sys.exit(-1)    #Give an option, #1 job, #2 file-path

    if(int(sys.argv[1]) < 3):
        path = os.path.dirname(sys.argv[2])
        print "Compiling : ", path
        ret = compile(path)
        sys.exit(ret)
    elif(int(sys.argv[1]) == 3):
        ret = downloaddiff(sys.argv[2])
        sys.exit(ret)
