#!/usr/bin/env python3
import re
import sys
import yaml


# Read input from stdin
input_data = sys.stdin.readlines()
# Define regex patterns to extract fields
ip_pattern = r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
name_pattern = r"name:(\w+)"
domain_pattern = r"domain:([^)]+)"
os_pattern = r"\[\*\].*\(name:"
signing_pattern = r"signing:(True|False)"
smbv1_pattern = r"SMBv1:(True|False)"

# Extract fields using regex
machines = {}
try:
    for line in input_data:
       ip = re.search(ip_pattern, line)[0]
       name = re.search(name_pattern, line)[0].split(":")[1]
       domain = re.search(domain_pattern, line)[0].split(":")[1]
       signing = re.search(signing_pattern, line)[0].split(":")[1]
       smbv1 = re.search(smbv1_pattern, line)[0].split(":")[1]
       os = re.search(os_pattern, line)[0][4:-6]
       machines[name] ={"IP": ip, "Domain": domain, "OS": os, "Notes": f"SMB signing: {signing}, SMBv1: {smbv1}"}
       print(line)
except Exception as e:
    print(e)

# Convert the dictionary to YAML
yaml_string = yaml.dump(machines, default_flow_style=False)
print(yaml_string)
