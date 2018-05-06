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

### Complete Linkage
- At each step, the *maximum distance* between points in two clusters is used to determine which two clusters should be merged
- Often gives *comparable cluster sizes*
- Less sensitive to outliers
- Works better with *spherical distributions*

### Average Linkage
- At each step, the *average distance* between points in two clusters is used to determine which two clusters should be merged
- A compromise between single and complete linkage
- Less sensitive to outliers
- Works better with *spherical distributions*

## Advantages and Disadvantages of Hierarchical Clustering
- Advantages: gives a family of possible outcomes; computationally fast
- Disadvantages: no optimization criterion; final solution chosen by the data analyst; different merging (splitting) criteria give different solutions

### Hierarchical Clustering vs. Partition-Based Methods
- In hierarchical clustering, a sequence of possible clusterings is generated
- The analyst then decides on the number of clusters (by deciding where to cut the dendrogram)
- In partition-based methods, data is partitioned into a number of *a priori* given clusters
- No need for intervention by analyst; however, number of clusters needs to be specified

## *K*-Means Clustering
- The most popular partition-based methods is *K*-means clustering
- Motivated by a simple and intuitive mathematical problem
- Uses Euclidean distance between points
- Computationally efficient, and can be applied to datasets with a large number of samples (variables)
- No hierarchy among clusters, if *K* is changed, the cluster memberships will also change

### Solution
- Although the optimization problem in *K*-means is simple and intuitive, finding exact solutions (global minimum) is not tractable
- However, we can efficiently find good approximate solutions for this problem (local minimum) using the following algorithm: 
  - Randomly assign each observation to one of the *K* clusters.
  - Iterate until the cluster assignments don't change:
    - For each of the *K* clusters, compute the cluster **centroid**, i.e., the mean of observations assigned to the each cluster. This is a vector of length *p* (for *p* features).

# Dimension Reduction
Find **low dimensional representation** of data; this is a very useful tool for **discovering patterns** in the data, and also improving the performance of regression and prediction methods.
- PCA: principal component analysis
- MDS: multi-dimensional scaling
- Sparse PCA, Kernel PCA, ICA, Manifold learning


