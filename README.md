# New Relic Infrastructure

New Relic Infrastructure helps you to monitor your entire infrastructure - hosts, cloud providers, container services, backend services, orchestrators, and more.

This repo contains a couple of helper scripts and resources to deploy and manage the New Relic Infrastructure agent and other third-party services such as database management systems.

## Content in this repo:

- nr-infra.sh: a script to deploy New Relic Infrastructure agent specifically for Ubuntu 16.04 operating system. Running, this script on a blank machine will install and configure the agent and start reporting data.

- nr-infra-ubuntu-18.04.sh: a script to deploy New Relic Infrastructure agent specifically for Ubuntu 18.04 operating system. Running, this script on a blank machine will install and configure the agent and start reporting data.

- sql-server-instances.ps1: a PowerShell script to gather all MS SQL Server instances of a MS SQL Server environment. This script will then generate the relevant YML configuration for the New Relic third-party service integration.

- AWS-RDS-NR-Custom-Policy.json: custom AWS RDS IAM policy for New Relic cloud monitoring
