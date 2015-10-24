#!/usr/bin/python

import argparse
from github3 import login

parser = argparse.ArgumentParser(
    description='Create a new GitHub release for specified repository.')
parser.add_argument('username', metavar='username', help='login name')
parser.add_argument('password', metavar='password', help='password for username')
parser.add_argument('id', metavar='id',help='addon id')
parser.add_argument('name', metavar='name', help='addon name')
parser.add_argument('version', metavar='version', help='addon version')

args = parser.parse_args()

gh = login(args.username, password=args.password)

repo = gh.repository(args.username, args.id)

release = repo.create_release(
    'v%s' % (args.version), name='%s for Kodi Release %s' % (args.name, args.version), body='', draft=True)

print release
