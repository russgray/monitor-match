from fabric.api import *
import fabric.contrib.project as project
import os
import sys
import SimpleHTTPServer
import SocketServer
import requests

# Local path configuration (can be absolute or relative to fabfile)
env.deploy_path = 'dist'
DEPLOY_PATH = env.deploy_path

# Remote server configuration
production = 'russgray@188.226.200.128:22'
env.key_filename = '/home/vagrant/.ssh/id_dsa_digitalocean.pem'
dest_path = '/apps/monitor-match'

def clean():
    if os.path.isdir(DEPLOY_PATH):
        local('rm -rf {deploy_path}/*'.format(**env))

def build():
    local('gulp')

def rebuild():
    clean()
    build()

@hosts(production)
def deploy():
    tmp_dir = '/home/russgray/apps/monitor-match'
    project.rsync_project(
        remote_dir=tmp_dir,
        exclude=".DS_Store",
        local_dir=DEPLOY_PATH.rstrip('/') + '/',
        delete=True,
        extra_opts='-c',
    )
    run('sudo -u www-data rm -rf {}/*'.format(dest_path))
    run('sudo -u www-data mkdir -p {}'.format(dest_path))
    run('sudo -u www-data cp -r {}/* {}'.format(tmp_dir, dest_path))
    run('sudo -u www-data chmod -R 744 {}'.format(dest_path))
    run('sudo -u www-data chmod -R +X {}'.format(dest_path))

@hosts(production)
def r_uname():
    run('uname -a')
