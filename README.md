# CCDC Scripts & Templates
---
## Purpose
This repository aims to store blue team scripts (Bash, Batch, Python, VBS, etc.) that aim to establish initial network defense. The scripts are meant to be used on any computer, but are really designed for [CCDC competition](https://www.nationalccdc.org). The competition itself involves managing network defense _during_ business management tasks; most processes in setting up the network for normal operation can and should be automated. Therefore anything that may aid in competition without explicitly breaking the rules can be dropped in this repository as a means of central organization.

## Compliance
- Tools must be either open source or free install files, no proprietary tools or free trials.  No pirated software is allowed
- All files must be freely accessible, no password zip files, encryption, &c
-	Scripts must be readable source or executable files with an instruction file that includes a description and how to use the tool
-	No ISO files for operating system installation or prebuilt VMs
-	Documents must be pertinent to the CCDC, including how to documents, organization charts, strategy outlines, templates, notes, screen shots, &c
-	No prepared inject responses, based on past CCDC events, are allowed.  Document templates for injects and incident responses are permitted
-	No custom docker containers
-	The repository must not contain personal written content, images, or links to inappropriate media following professional behavior guidelines

## Reference

### Network Topology
The most recent CCDC network was structured as follows:

<img src="https://images.seth-phillips.com/CCDC%20Network%20Diagram.png" style="width: 50%; height: 50%">

### Known Vulnerabilities
 - _todo_

## To-Do List
Legend:
`[O]` - Online services; internet required
`[B]` - Background process; can be executed (at least initially) without a human

#### Anti-Red Team Utilities

- `[O]` Update package manager 
- Change system passwords
- Block all IPs except for machines that're supposed to be connected
- `[O]` Replace binaries (BusyBox)
- `[B]` Check environmental variables (especially $PATH)
- Check /etc/passwd
    - Get common users, take diff, and let human compare
- Check ps -aux
    - Get common processes, take diff, and let human compare
- `[O]` Download screen for background utility
- `[B]` Run data finder across filesystem
- `[O]` `[B]` Set up Splunk connector
- Check:
  - ~/.bashrc,
	- ~/.bash_aliases
	- ~/.ssh/authorized_keys
	- /etc/profile
	- /etc/sudoers
	- crontab -e
	- /var/backups
	- /etc/apt/sources.list
- Make static systems immutable

#### Inject Automation
- Updating MOTD
- Set up SSH user via password and/or key
- Set up VPN
- List of users
- List of processes
_What else?_

#### Server-Specific
##### Phantom & Splunk (SOAR/Logging)
 - _todo_

##### Debian (MySQL)
 - Check DB users

##### CentOS 6.0 (E-commerce)
 - Change site passwords

##### Ubuntu (BIND DNS)
 - Check DNS entries

##### Windows 2008 (AD/DNS)
 - _how does AD even work_

##### Fedora 21 (Webmail)
 - Check CVEs for applicable versions
    - Postfix
    - Dovecot
    - Amavis
    - ClamAV
    - RoundCube

##### Meta
 - Make centralized inject management portal
