#!/usr/bin/env python
# -*- coding: utf-8 -*-

#    Copyright (C) 2014 Thibaut Lapierre <root@epheo.eu>. All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.


import ConfigParser
import os
import json
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-f", "--config", dest="config_file",
                  help="Config json file",)
parser.add_option("-s", "--service",
                  dest="service", default='', type=str,
                  help="Openstack service to apply configuration.")

(options, args) = parser.parse_args()

def apply_config(configfile, d):
    config = ConfigParser.RawConfigParser()
    config.read(configfile)

    for section in d.keys():
        if not set([section]).issubset(
                config.sections()) and section != 'DEFAULT':
            config.add_section(section)
        inner_dict = d.get(section)
        print(inner_dict)
        for key in inner_dict.keys():
            config.set(section, key, inner_dict.get(key))
            print('Writing %s : %s in section %s of the file %s'
                  % (key,
                     inner_dict.get(key),
                     section,
                     configfile))

    with open(configfile, 'w') as configfile:
        config.write(configfile)
    print('Done')
    return True

if __name__ == '__main__':
    with open(options.config_file, "r") as json_conf:
        data = json.load(json_conf)
        apply_config(options.service, data)
