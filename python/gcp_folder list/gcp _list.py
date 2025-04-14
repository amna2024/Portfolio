
from google.cloud import resourcemanager_v3
from google.api_core.exceptions import GoogleAPICallError

def get_folders(parent_id):
    client = resourcemanager_v3.FoldersClient()
    folders = []
    
    request = resourcemanager_v3.ListFoldersRequest(parent=parent_id)
    for folder in client.list_folders(request=request):
        folder_id = folder.name.split("/")[-1]
        folders.append({
          "id": folder_id,
          "name": folder.display_name,
          "full_name": folder.name
            })
    except GoogleAPICallError as e:
        print(f"Could not access {parent_id}: {e}")
    
    return folders

def get_projects(folder_id):
    client = resourcemanager_v3.ProjectsClient()
    projects = []
    
    try:
    request = resourcemanager_v3.ListProjectsRequest(parent=f"folders/{folder_id}")
    for project in client.list_projects(request=request):
            projects.append({
                "id": project.project_id,
                "name": project.display_name
            })
    except GoogleAPICallError as e:
       print(f"Couldn't list projects in folder {folder_id}: {e}")
    
    return projects

def print_tree(parent_id, prefix=""):
    if prefix.count('--') >= 3:
       return 
    
    folders = get_folders(parent_id)

    for folder in folders:
        print(f"{prefix}- Folder: {folder['name']} (ID: {folder['id']})")
        
        projects = get_projects(folder["id"])
        for project in projects:
            print(f"{prefix}  -- Project: {project['name']} (ID: {project['id']})")
        
        print_tree(folder["full_name"], prefix + "  ")

if __name__ == "__main__":
    org_id = "organizations/123456789"  # 🔁 Replace with your real org ID
    print_tree(org_id)
