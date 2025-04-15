import csv
from google.cloud import resourcemanager_v3

def get_folders(parent_id):
    client = resourcemanager_v3.FoldersClient()
    folders = []
    request = resourcemanager_v3.ListFoldersRequest(parent=parent_id)
    for folder in client.list_folders(request=request):
        folders.append({
            "id": folder.name.split("/")[-1],
            "name": folder.display_name,
            "full_name": folder.name
        })
    return folders

def get_projects(folder_id):
    client = resourcemanager_v3.ProjectsClient()
    projects = []
    request = resourcemanager_v3.ListProjectsRequest(parent=f"folders/{folder_id}")
    for project in client.list_projects(request=request):
        projects.append({
            "id": project.project_id,
            "name": project.display_name
        })
    return projects

def build_csv_tree(parent_id, writer, parent_name, level=0, max_depth=3):
    if level > max_depth:
        return
    print(f"Fetching folders under: {parent_name}") 
    folders = get_folders(parent_id)
    for folder in folders:
        folder_name = f"Folder: {folder['name']} ({folder['id']})"
        print(f"Adding folder: {folder_name}")
        writer.writerow([parent_name, folder_name, parent_id, "folder"])

        projects = get_projects(folder["id"])
        for project in projects:
            print(f"  Adding project: {project['name']} ({project['id']})")
            project_label = f"Project: {project['name']} ({project['id']})"
            writer.writerow([folder_name, project_label, "project"])

        build_csv_tree(folder["full_name"], writer, folder_name, level + 1, max_depth)
if __name__ == "__main__":
    org_id = "organizations/12344447" # <-- Replace with your org ID
    org_name = f"Organization ({org_id.split('/')[-1]})"

    with open("gcp_hierarchy.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["parent", "child", "type"])
        build_csv_tree(org_id, writer, org_name)

    print("CSV generated: gcp_hierarchy.csv ✅")
