*GCP Hierarchy CSV Generator*

Overview
This script generates a CSV file that describes the hierarchy of Google Cloud Platform (GCP) resources within an organization. It fetches the folders and projects under a given parent folder (usually an organization or a specific folder), and stores this information in a CSV format. The CSV file is structured to represent the relationships between the parent and child resources, which can be visualized using a graph visualization tool.

The output CSV is particularly useful for visualizing GCP's organizational structure, understanding folder/project hierarchy, and performing audits.

Functionality
The script will retrieve all folders and projects under a specified parent folder or organization.

It will then generate a CSV file containing the following columns:

parent: The parent resource (e.g., Organization, Folder).

child: The child resource (e.g., Folder, Project).

type: The type of resource (either folder or project).

Prerequisites
Before running the script, ensure the following are installed and set up:

1. Google Cloud SDK
The script interacts with Google Cloud API to fetch resources. Ensure the Google Cloud SDK is installed and configured on your machine.

Install the Google Cloud SDK: Installation Guide

Authenticate using:

bash
Copy
Edit
gcloud auth login
gcloud auth application-default login
2. Python 3.x
Ensure Python 3.x is installed on your system.

Download Python: Official Python Website

3. Required Python Libraries
You need the google-cloud library for accessing GCP's resources, and csv (standard Python library) to write the CSV file.

Install the necessary libraries using pip:

bash
Copy
Edit
pip install google-cloud
You must also set up Google Cloud credentials. Refer to this link for setting up service account credentials: Service Accounts.

4. GCP Organization ID
You will need your Google Cloud Organization ID to specify the parent resource for the script to start fetching folders and projects.

To find your organization ID:

Run gcloud organizations list to get the organization ID.

Script Explanation
1. Get Folders
The function get_folders fetches all folders under a given parent ID (organization or folder). It calls the ListFolders API from the Google Cloud Resource Manager and extracts folder information like ID, name, and full name.

2. Get Projects
The function get_projects fetches all projects under a given folder by calling the ListProjects API from Google Cloud.

3. Build CSV Tree
The build_csv_tree function recursively constructs the hierarchy of resources (folders and projects) and writes the relationships to the CSV file. It accepts the following parameters:

parent_id: The ID of the parent resource.

writer: The CSV writer object to write rows to the CSV.

parent_name: The name of the parent resource (for human-readable output).

level: The current recursion depth (default is 0).

max_depth: The maximum depth to traverse (default is 3).

The function recursively fetches folders and projects for each folder and writes these relationships to the CSV file.

4. Main Execution
The script's main execution starts by setting the org_id (your Google Cloud Organization ID) and org_name. It then opens a CSV file and calls the build_csv_tree function to populate it with the folder and project hierarchy.

Usage
Replace the org_id with your Google Cloud Organization ID in the script:

python
Copy
Edit
org_id = "organizations/12344447"  # <-- Replace with your org ID
Run the script:

bash
Copy
Edit
python generate_csv.py
The script will generate a CSV file named gcp_hierarchy.csv in the current directory, containing the parent-child relationships of GCP resources.

Example Output
The generated gcp_hierarchy.csv file will look something like this:

csv
Copy
Edit
parent,child,type
Organization (12344447),Folder: Base (5597205),folder
Folder: Base (5597205),Folder: Automations (1993149760),folder
Folder: Automations (1993149760),Project: mega-base-ic-ar-0 (vega-bae-ac-ar-0),project
Customization
You can modify the following parameters in the script to fit your needs:

max_depth: The maximum depth of folder hierarchy to retrieve. By default, the script will fetch up to 3 levels of nested folders.

CSV Output File: The script generates a CSV file named gcp_hierarchy.csv by default. You can change this filename by editing the open("gcp_hierarchy.csv", "w", newline="") line in the script.

Contributions
If you'd like to contribute or suggest improvements to the script, feel free to open an issue or submit a pull request.

License
This script is open-source and available for modification under the MIT License.
