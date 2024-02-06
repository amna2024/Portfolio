# Azure AD Connect - Force Synchronization

## Overview

This document explains how to force a synchronization cycle using the `Start-ADSyncSyncCycle` cmdlet in Azure AD Connect. Azure AD Connect is a Microsoft tool designed to synchronize on-premises Active Directory objects to Azure AD.

## Prerequisites

- Azure AD Connect installed and configured.
- Administrative privileges on the server.
- PowerShell module for Azure AD Connect loaded (`Import-Module ADSync`).

## Forcing Synchronization Steps

1. **Open PowerShell:**
   - Launch PowerShell with administrative privileges.

2. **Import Azure AD Connect Module:**
   - Import the Azure AD Connect module to enable the use of `Start-ADSyncSyncCycle` cmdlet.
   ```powershell
   Import-Module ADSync
   ```

3. **Force Delta Synchronization:**
   - Initiate a delta synchronization to synchronize changes made since the last synchronization.
   ```powershell
   Start-ADSyncSyncCycle -PolicyType Delta
   ```

4. **Force Full Synchronization:**
   - Initiate a full synchronization to synchronize all objects.
   ```powershell
   Start-ADSyncSyncCycle -PolicyType Initial
   ```

## Usage Instructions

1. **Scheduled Synchronization:**
   - Azure AD Connect typically runs synchronization cycles automatically based on a predefined schedule. Forced synchronizations are useful for immediate updates.

2. **Monitoring Synchronization:**
   - Monitor the synchronization process using Azure AD Connect Health or review the synchronization logs for any errors.

3. **Impact on Users:**
   - Forced synchronization may lead to increased load on the server and temporary resource usage. Ensure it does not impact users during critical times.

## Considerations

- **Scheduled Synchronization:**
  - Whenever possible, rely on the scheduled synchronization cycles defined in Azure AD Connect to manage synchronization.

- **Delta Synchronization:**
  - Delta synchronization processes only the changes made since the last synchronization cycle, making it quicker than a full synchronization.

- **Full Synchronization:**
  - A full synchronization processes all objects, making it more resource-intensive and time-consuming than a delta synchronization.

## Example Scenario

Suppose you have made critical changes in your on-premises Active Directory and need those changes to reflect in Azure AD immediately. By following these steps, you can force synchronization to apply the changes without waiting for the next scheduled cycle.

## Note

This documentation provides guidance on forcing synchronization cycles using `Start-ADSyncSyncCycle`. Exercise caution and consider the impact on the environment before performing forced synchronizations.
