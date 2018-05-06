# Unsupervised Learning Methods

# Cluster Analysis
Find **similar groups** of variables/samples; this can be the final goal of analysis or a preliminary step.
- Hierarchical Clustering: Agglomerative (bottom-up) clustering
- Partition-based Methods: K-means, model-based clustering, spectral clustering
- Self-organizing maps, bi-clustering

## Objective
- Grouping objects into **meaningful** subsets or **clusters**, such that objects within each cluster are more similar to one another than objects in other clusters.
- Need to define what a "meaningful" cluster is
- Need to define what we mean by "similarity"
- Can cluster **observations** or **features**: 
  - **Observations**: clustering cancer samples to find cancer subtypes
  - **Features**: clustering genes based on similar functions (pathways)
  - Clustering features is similar to clustering observations (work with the transpose of the data matrix)
  
## Methods of Hierarchical Clustering
Hierarchical clustering results in a sequence of solutions (nested clusters), organized in a hierarchical tree structure, called the **dendrogram**.
- Bottom-Up/Agglomerative (**we focus on this type**): start from *n* individual clusters, and group them together into using a measure of similarity.
  - Start from *n* individual clusters.
  - At each step, merge the closest pair of clusters until all objects form a single cluster.
- Top-Down/Divisive: Start from one cluster containing all objects, and break them down using a measure of distance
  - Start from 1 cluster
  - At each step, split the most heterogenous cluster until every cluster only has one member
  
### Interpreting the Dendrogram
- At the bottom of the tree, there is a leaf for each observation
- As we move up the tree, some leaves being to fuse into branches: these are observations that are similar to each other
- The earlier (lower in the tree) fusions occur, the more similar the groups of observations are to each other
- Observations that fuse later (near the top of the tree) can be quite different
- The heigh of the point in the tree where branches containing two observations are first fused, as measured on the vertical axis, indicates how different they are from each other
- However, we cannot draw conclusions about the similarity of two observations based on their proximity along the horizontal axis

## Measures of Inter-Cluster Similarity

### Single Linkage
- At each step, the *minimum distance* between points in two clusters is used to determine which two clusters should be merged.
- Can handle diverse shapes.
- Very sensitive to outliers/noise
- In practice, often results in unbalanced clusters; may break down the clusters by "chaining" their members
- Can result in extended, trailing clusters in which observations are fused one-at-a-time

# Dimension Reduction
Find **low dimensional representation** of data; this is a very useful tool for **discovering patterns** in the data, and also improving the performance of regression and prediction methods.
- PCA: principal component analysis
- MDS: multi-dimensional scaling
- Sparse PCA, Kernel PCA, ICA, Manifold learning


