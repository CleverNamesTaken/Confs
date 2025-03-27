#!/usr/bin/python
# vim: fileencoding=utf-8
# SPDX-License-Identifier: MIT

u"""Translate YAML written text to graphviz dot language

Input YAML text like below:

---
foo:
  - bar
  - baz:
    - hello:
      - world
  - lorum
---

Modified from
Reference: https://gist.github.com/nakamuray/7653403
Author: Richard Caceres, richard@archive.org
Usage: python yaml2dot-tree.py test.yaml > output.gv 

"""


import yaml
import sys
from datetime import datetime

def prepMain():
    ''' Prepare the main headers for the diagram '''
    date = datetime.now().strftime("%d %b %Y")
    main = f'''digraph switches {{
    // Main Section
    label="Network Diagram - { date }";
    fontname="arial";
    layout=twopi;
    ratio=auto;
    ranksep=3;
    node [
    //shape=box, 
    fontname="arial",
    fontsize=8,
    style=filled,
    color="#d3edea"
    ];
    splines="compound"

    // Node section
    cloud [ label="The Internet",
        shape=none, 
        image="images/cloud.png" ,
        labelloc=b ,
        color="#ffffff"]
    '''
    return main

def edge_str(a, b=None):
    if b is not None:
        return "%s -> %s" % (quote(a), quote(b))
    else:
        return "%s" % quote(a)


def get_edges(name, children):
    edges = []
    edges.append(edge_str(name))
    for c in children:
        if isinstance(c, basestring):
            edges.append(edge_str(name, c))
        elif isinstance(c, dict):
            key = c.keys()[0]
            edges.append(edge_str(name, key))
            edges = edges + get_edges(key, c[key])
    return edges

def get_machine_path(data,key):
    ''' Extract network data for each machine '''
    return_data = []
    try:
        return_data = data[key]['PATH']
    except:
        return_data = f" cloud -> {key}\n"
    return return_data

def get_machine_data(data,key):
    ''' Extract data for each machine '''
    return_data = []
    return_data = data[key]['IP'] + '\n PORTS: 443'
    #Remove the IP here.  Create an html document with the device data as a hyperlink
    for subkey in data[key].keys():
        return_data += (f"{subkey}: {data[key][subkey]}\n")
    return return_data

def network_parse(yml):
    ''' Draw out the network diagram '''
    networkSection = '// Network diagram section\n'
    with open(yml,'r') as f:
        yaml_data = yaml.safe_load(f)
    for FRIENDLYNAME in yaml_data.keys():
        path = get_machine_path(yaml_data,FRIENDLYNAME)
        networkSection += path
    return networkSection

def machine_parse(yml):
    ''' Create the description for each host '''
    edges = []
    with open(yml,'r') as f:
        yaml_data = yaml.safe_load(f)
    for FRIENDLYNAME in yaml_data.keys():
        IP = get_machine_data(yaml_data,FRIENDLYNAME)
        edges.append(f"""{FRIENDLYNAME} [ label = "{IP}",
               shape=none ,
               image="images/router.png" ,
               labelloc=b ,
               color="#ffffff" ];
        """)
    return edges


if __name__ == "__main__":

    yaml_input = sys.argv[1]
    # Prepare the overall structure
    mainSection = prepMain()
    # Prepare the individual machines
    hostSection = machine_parse(yaml_input)
    networkDiagramSection = network_parse(yaml_input)
    endSection = '}'
    # Put it all together
    full = mainSection + "".join(hostSection) + networkDiagramSection + endSection
    print(full)

'''
graph switches {
  
  label="Network Diagram - 30 January 2025";
  fontname="arial";
  
  node [
    shape=box, 
    fontname="arial",
    fontsize=8,
    style=filled,
    color="#d3edea"
  ];
  splines="compound"
  
// define the routers
  router [ label= "192.168.1.250", 
           shape=none ,
           image="images/router.png" ,
           labelloc=b ,
           color="#ffffff" ];

// define access servers
  servers [ label="Servers",
            shape=none,
            image="images/servers.png",
            labelloc=b,
            color="#ffffff" ];
  
// define clouds
  cloud [ label="The Internet",
          shape=none, 
          image="images/cloud.png" ,
          labelloc=b ,
          color="#ffffff"]
  
// create the network diagram
  cloud -- router;
  cloud -- servers [color="#ffbb00"];
}
'''
