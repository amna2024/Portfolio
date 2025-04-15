import csv
import pydot

def sanitize(name):
    return name.replace(":", "").replace("(", "").replace(")", "").replace(" ", "_")

def generate_clustered_graph(csv_file, output_file="ABC_hierarchy_graph.png"):
    graph = pydot.Dot(graph_type="digraph", rankdir="LR", bgcolor="white")

    nodes = {}
    clusters = {}
    folder_parents = {}  # Track parent-child folder structure

    with open(csv_file, newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            parent = row["parent"].strip()
            child = row["child"].strip()
            node_type = row["type"].strip().lower()

            parent_id = sanitize(parent)
            child_id = sanitize(child)

            # Store folder hierarchy
            if node_type == "folder":
                folder_parents[child_id] = parent_id

            # Add nodes and clusters
            if node_type == "folder":
                is_nested = parent.startswith("Folder")
                fill_color = "#E6E6FA" if is_nested else "#FFB6C1"

                if child_id not in clusters:
                    cluster = pydot.Cluster(child_id, label=child, style="filled", fillcolor=fill_color, fontsize="14")
                    clusters[child_id] = cluster

            elif node_type == "project":
                node = pydot.Node(child_id, label=child, shape="component", style="filled", fillcolor="#d8c2fc")
                nodes[child_id] = node

            # Add parent and fallback child node if not created
            if parent_id not in nodes:
                parent_shape = "circle" if parent.lower().startswith("organization") else "ellipse"
                parent_color = "#d2f7d2" if parent.lower().startswith("organization") else "#FAFAD2"
                nodes[parent_id] = pydot.Node(parent_id, label=parent, shape=parent_shape, style="filled", fillcolor=parent_color)

            if child_id not in nodes and node_type != "folder":
                nodes[child_id] = pydot.Node(child_id, label=child, shape="box", style="filled", fillcolor="#ADD8E6")

    # Add nodes into their respective clusters or to the graph
    for cid, node in nodes.items():
        added = False
        for cluster_id, cluster in clusters.items():
            if cid.startswith(cluster_id) or folder_parents.get(cid) == cluster_id:
                cluster.add_node(node)
                added = True
                break
        if not added:
            graph.add_node(node)

    # Add clusters
    for cluster in clusters.values():
        graph.add_subgraph(cluster)

    # Add edges
    with open(csv_file, newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            parent_id = sanitize(row["parent"].strip())
            child_id = sanitize(row["child"].strip())
            graph.add_edge(pydot.Edge(parent_id, child_id))

    graph.write_png(output_file)
    print(f"✅ Graph saved to {output_file}")

# Run it
generate_clustered_graph("ABC_hierarchy.csv") #whatever name you want to give
