# BigQuery Performance Monitoring

This repository contains a Looker block for monitoring and optimizing **Google BigQuery** usage and performance, built off of the new Information Schema tables provided natively within BigQuery. The block uses the Information Schema metadata tables to monitor resource usage and query performance across an entire organization, with specific metrics and visualizations for both On-Demand and Flat-Rate customers.

## About the Block

This block is designed to provide a comprehensive view of all jobs and queries processed in BigQuery, tracking resource consumption and query performance on a millisecond by millisecond level, to proactively act to improve performance across the environment.

For Flat-Rate customers, this block allows for near real-time monitoring of slot usage against capacity commitments, as well as any queries being cached or slowed down due to heavy consumption. Identify spikes in slot usage across the organization, correlating to an increase in pending units and a slowdown across the system due to capacity being reached.

For On-Demand customers, the near real-time analysis tracks Gigabytes processed across all projects and queries, with a cost estimator mapped to BigQuery;s on-demand model, to understand what is driving spend across the organization and identify patterns in usage over time.
From this real-time tracking of slot usage and bytes processed across the organization, we can identify the spikes in usage and spend, drill down to the individual jobs that are driving these spikes, and optimize these queries by breaking them down into the execution stages and tables required to complete the job.
