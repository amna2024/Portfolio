# Visualizing Data Analysis Using Amazon QuickSight

## Step 1: Prepare Your Data

1. **Create a CSV file** with the data you want to analyze (e.g., Netflix data or any other application dataset).
2. **Create a JSON file** (manifest file) for the dataset you want to visualize. This file is a map that tells QuickSight where your data is stored and how to read it. 
   - Store the CSV and JSON files in an **Amazon S3 bucket**.

## Step 2: Set Up an Amazon S3 Bucket

1. **Log in to your AWS Console**.
2. **Create an S3 bucket**:
   - Go to the S3 service and click "Create Bucket."
   - Name your bucket and select the AWS region closest to you.
   - Keep the other settings as default and click "Create Bucket."
3. **Upload your CSV file** to the S3 bucket.
4. **Update your JSON file**:
   - Copy the S3 URL of your CSV file and update the S3 URI in your JSON file (manifest.json).
   - This step is crucial, as the correct S3 URI ensures that QuickSight connects to the right dataset location.

## Step 3: Create a QuickSight Account

1. Go to **Amazon QuickSight** and create an account.
   - You can use the **free trial** for 30 days without being charged.
   - The setup process takes a few minutes.
2. During setup, **enable S3 bucket access** for QuickSight to access your data.
   - Make sure to uncheck the additional cost options.

## Step 4: Create a Dataset in QuickSight

1. In QuickSight, go to the **datasets** section.
2. Choose **S3** as the data source.
3. **Upload your JSON file** (manifest.json) by pasting the S3 URL.
   - The JSON file tells QuickSight where the data lives and how to interpret it.

> **Note:** The manifest file (e.g., xyz.json) acts like a guide for QuickSight to understand your data format. Without it, QuickSight might not display the data correctly in visualizations.

4. After selecting "Connect," click on "Visualize" to start building your dashboard.

## Step 5: Create Your First QuickSight Visualization

1. Start by dragging fields from the **left-hand panel** to the canvas to create visualizations.
2. Choose from various chart types (e.g., bar charts, pie charts, line graphs).
3. Customize your visualization:
   - Add multiple charts/graphs by clicking the **"Add+"** button.
   - Resize charts by adjusting the frame size.
   - Edit chart titles by double-clicking and modifying them as needed.
4. Once you're satisfied with your visualizations, save them to your dashboard.

## Step 6: Publish Your Analysis

1. When you're ready, go to the top-right corner and click **"Publish"** to make your dashboard public.
2. Name your dashboard (e.g., **"Netflix Titles Analysis"**) and click the **"Publish Dashboard"** button.
3. You can also **export your analysis** by clicking on the "Export" icon and downloading it as a PDF.

## Step 7: Clean Up Resources

1. To avoid unnecessary charges, **delete all resources**:
   - Remove the S3 bucket you created.
   - Delete your QuickSight account if you no longer need it.
