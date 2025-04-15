# **Graph Visualization Script for Cloud Resource Hierarchies**

## **Purpose**
This script visualizes hierarchical structures of cloud resources (like folders and projects) using the **`pydot`** library. It reads data from a **CSV** file, processes the data, and generates a graphical representation of cloud resources in the form of a directed graph. This graph can be used to easily understand relationships between top-level folders, subfolders, and projects within an organization, and visualize their dependencies and structure.

## **Features**
- **CSV Input**: The script takes in a CSV file where each row represents a relationship between a parent and child resource, with a type (folder or project).
- **Graph Generation**: The script generates a directed graph using the **`pydot`** library and visualizes the structure as a tree, with nodes representing folders and projects.
- **Folder & Project Visualization**: 
    - **Folders** are represented by nodes that can be clustered, with different colors indicating their level or type.
    - **Projects** are represented by rectangular nodes, colored distinctly from folders.
- **Hierarchy Representation**: It displays the relationship between a parent resource and a child resource, supporting both folders and projects, making it ideal for visualizing cloud environments.
- **Custom Styling**: The script allows you to modify node colors and shapes, which can represent different types of resources in a cloud hierarchy.

---

## **Script Explanation**

### **1. Sanitizing Node Names**
The `sanitize` function ensures that any special characters (e.g., `:` and spaces) are removed from the names of the resources. This is crucial for generating valid node IDs in the graph.

```python
def sanitize(name):
    return name.replace(":", "").replace("(", "").replace(")", "").replace(" ", "_")
```

### **2. Graph Generation**
The main function of the script, `generate_clustered_graph`, is responsible for reading the CSV file and building the graph based on the relationships defined in it. It makes use of **pydot** to create clusters and nodes and visualize the hierarchical structure.

```python
def generate_clustered_graph(csv_file, output_file="gcp_hierarchy_graph.png"):
    graph = pydot.Dot(graph_type="digraph", rankdir="LR", bgcolor="white")
    nodes = {}
    clusters = {}
```

### **3. Reading the CSV Data**
The script uses the `csv.DictReader` to read each row of the CSV file. Each row represents a relationship between a `parent` and a `child`, along with the resource type (`folder` or `project`).

```python
with open(csv_file, newline="") as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        parent = row["parent"].strip()
        child = row["child"].strip()
        node_type = row["type"].strip().lower()
```

### **4. Creating Nodes and Clusters**
The script creates a **cluster** for each folder using **pydot.Cluster** to group related folders together. Projects are represented as rectangular nodes, and different colors are used for visual distinction.

```python
if node_type == "folder":
    is_nested_folder = parent.startswith("Folder")
    fill_color = "#E6E6FA" if is_nested_folder else "#FFB6C1"
    if child_id not in clusters:
        cluster = pydot.Cluster(child_id, label=child, style="filled", fillcolor=fill_color, fontsize="14")
        clusters[child_id] = cluster
elif node_type == "project":
    node = pydot.Node(child_id, label=child, shape="box", style="filled", fillcolor="#d8c2fc")
    nodes[child_id] = node
```

### **5. Adding Parent-Child Connections**
The script ensures that every parent-child relationship is represented by an edge in the graph. For this, it uses **pydot.Edge** to create directed edges between nodes.

```python
edge = pydot.Edge(parent_id, child_id)
graph.add_edge(edge)
```

### **6. Output**
After building the graph, the script writes the resulting graph to an image file (e.g., PNG format) using **pydot**.

```python
graph.write_png(output_file)
print(f"✅ Graph saved to {output_file}")
```

---

## **Requirements**
- Python 3.x
- `pydot` library for graph generation
- `csv` (standard Python library)

Install the necessary Python packages using the following command:

```bash
pip install pydot
```

Additionally, you need **Graphviz** installed on your system because `pydot` depends on Graphviz to render graphs. You can install it using:

```bash
# For Linux (Ubuntu/Debian)
sudo apt install graphviz

# For macOS (using Homebrew)
brew install graphviz

# For Windows, you can download the installer from:
# https://graphviz.gitlab.io/download/
```

---

## **CSV Format**
The script expects the CSV file to contain the following columns:
- **parent**: The name or ID of the parent resource (folder or project).
- **child**: The name or ID of the child resource (folder or project).
- **type**: The type of the child resource (either `folder` or `project`).

Example CSV:

```csv
parent,child,type
Organization (187305027),Folder: Batman (5597205),folder
Folder: Batman (5500097205),Folder: ABCs (1993149760),folder
Folder: Abss (1000000000),Project: mega-bat-ic-ar-0 (mega-bat-ac-ar-0),project
```

---

## **Usage**
1. Prepare your CSV file with the resource hierarchy (parent-child relationships and resource types).
2. Run the script as follows:

```bash
python gph.py
```

This will read the CSV file `gcp_hierarchy.csv` and generate the corresponding graph. The resulting graph will be saved as a PNG image (`ABC_hierarchy_graph.png`).

## **Customization**
- **Node Colors**: The fill colors for folders and projects are customizable. You can modify the `fillcolor` values in the script to match your preferences.
- **Node Shapes**: You can change the node shapes by modifying the `shape` attribute in the `pydot.Node()` function.

---

## **Contributions**
If you'd like to contribute to the script or report any issues, feel free to open an issue or submit a pull request!

---

