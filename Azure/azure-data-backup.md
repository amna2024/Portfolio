# Azure Data Backup Guide

## 1. Backup Azure Virtual Machines (VMs)

### Create a Recovery Services Vault
1. Go to the [Azure portal](https://portal.azure.com).
2. Search for and select **"Recovery Services vaults"**.
3. Click **"Add"** to create a new vault.
4. Provide the necessary information (name, subscription, resource group, and region).
5. Click **"Review + create"** and then **"Create"**.

### Configure Backup for VMs
1. Navigate to the Recovery Services vault you created.
2. Under **"Getting Started"**, click **"Backup"**.
3. Choose **"Azure"** as the **"Where is your workload running?"** and **"Virtual machines"** as the **"What do you want to back up?"**.
4. Click **"Backup"** to start the configuration process.

### Select VMs to Backup
1. In the **"Backup items"** section, click **"Backup"**.
2. Choose the VMs you want to back up.
3. Click **"Enable backup"** and configure the backup policy (schedule and retention).

### Monitor and Manage Backups
1. Check the **"Backup Items"** and **"Recovery Points"** in the Recovery Services vault to monitor and manage your backups.

## 2. Backup Azure SQL Databases

### Configure Backup for Azure SQL Database
1. Azure SQL Databases are automatically backed up by default.
2. To configure additional backups or long-term retention, go to the [Azure portal](https://portal.azure.com).
3. Navigate to your SQL Database and select **"Backups"** from the settings.

### Set Up Long-Term Retention
1. Go to the SQL server in the Azure portal.
2. Click **"Long-term retention"** under the **"Settings"** section.
3. Configure the retention policy according to your requirements.

## 3. Backup On-Premises Servers or Files

### Install Azure Backup Agent
1. Download and install the Microsoft Azure Backup agent on your on-premises server or workstation.

### Register the Server
1. Open the Azure Backup agent and register the server with your Recovery Services vault using the credentials provided in the Azure portal.

### Configure Backup
1. Select the data you want to back up (files, folders, or system state).
2. Configure the backup schedule and retention policy.

### Perform Backups
1. Start the initial backup and monitor progress through the Azure portal or Backup agent interface.

## 4. Backup Azure Blob Storage

###
