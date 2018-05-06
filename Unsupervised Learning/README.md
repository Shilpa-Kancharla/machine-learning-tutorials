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
    - Assign each observations to the cluster with closest centroid (based on Euclidean distance).

### Properties
- In *K*-means there is no hiearchy among clusters, if *K* is changed, the cluster memberships will also change.
- *K*-means works best with compact spherical clusters with comparable number of members
- Does not work well when cluster sizes are different
- Results depend on the initial cluster assignment; may not get the best solution
- May result in empty clustesr
- May result in artificially small clusters (a possible solution is to eliminate outliers)

### Improving *K*-Means
A practical solution for obtaining better solutions *K*-means is to run the algorithm with a number of random starting points, and then choose the solution with lowest objective function.

### Choosing *K* (Number of Clusters)
- Look at the values of within cluster dissimilarity (e.g., WSS) for different *K*
- In general, WSS decreases as *K* increases
- Suppose there is *K-star* true clusters
- If *K < K-star*, increasing *K* will improve WSS significantly
- If *K > K-star*, increasing *K* will improve WSS slightly
- Therefore, need to look for an **elbow** in the plot of WSS for *K*

### Other Methods for Choosing *K*
- Gap statistics: compares the curve of *log WSS* to the curve obtained from data uniformly distributed (i.e., no clusters), and estimates the optimal number of clusters to be the place where the gap between the two curves is largest
- The Silhouette Coefficient: combines homogeneity and separation, can find the best number of clusters by minimizing this coefficient over range of values of *K*
- Statistical Significance of Clustering

### Caveats of Cluster Analysis
Although many clustering algorithms are available, this is sitll a challenging problem: 
- There is no one-size-fits-all solution to clustering, or even a consensus of what "good" clustering should look like.
- There is no single best criterion for obtaining a partition because no precise and workable definition of "cluster" exists
- Clusters can be of any arbitrary shapes and sizes in a high dimensional dataset
- Each clustering criterion imposes a certain structure on the data, and if the data happen to conform to the requirements of a particular criterion, the true clusters are recovered.
- It is very hard to evaluate how well a clustering algorithm performs on typical high dimensional datasets.
- Also, note that centering and scaling will significantly affect the results of cluster analysis

Final Remarks
- Clustering is very useful for gaining insight in high dimensional data
- Different clustering results for the same data, using different methods/distance matrices
- No formal way to verify the results of clustering
- Determining number of clusters is a challenging problem
- Results of clustering may vary for normalized observations
- Best practice is to try different methods/distances and use the results that are more consistent across methods/distances
- Clustering is a data exploration step, and its results hsould be interpreted that way; cannot make strong claims

`kmeans` and `hclust` in R

# Dimension Reduction
- Map the data into a new low-dimensional space where important characteristics of the data are preserved.
- The new space often gives a (linear or nonlinear) transformation of the original data.
- Visualization and analysis (clustering/prediction/...) is then performed in the new space.
- In many cases, (especially for nonlinear transformations) interpretation becomes difficult. 
Find **low dimensional representation** of data; this is a very useful tool for **discovering patterns** in the data, and also improving the performance of regression and prediction methods.
- PCA: principal component analysis
- MDS: multi-dimensional scaling
- Sparse PCA, Kernel PCA, ICA, Manifold learning

## Why Dimension Reduction? 
For Big Data: 
- Data visualization becomes very difficult
- Big data often has a high degree of redundancy (i.e., correlation among features)
- Many features may be uninformative for the particular problem under study (noise features)
- Dimension reduction ideally allows us to retain information on most important features of the data, while reducing noise and simplifying visualization & analysis


## Principal Components Analysis (PCA)
Set-up:
- Data matrix: X (n by p), *n* observations and *p* features.

Idea:
- Not all *p* features are needed (much redundant information)
- Find low-dimensional representations that capture most of the variation in data.

Uses:
- Ubiquitously used: dimension reduction, data visualization, pattern recognition, exploratory analysis, etc.
- Best linear dimension reduction possible

Main Idea: What is the best 1D representation of the data? 

Some possibilities:
- Use one of the variables (e.g. x_1)
- Better idea: use a linear combination of the variables (i.e. a weighted average)
    z_1 = (v_1)(x_1) + (v_2)(x_2) = (v^T)(X)
    
How do we choose the weights? (v_1 and v_2) 

We need to find a line that maximizes the variance of the data projected on to the line. Subsequent components orthogonal (perpendicular). 
- PCA minimizes orthogonal projection on the line.
- Slope of line: v2/v1 (if features centered)
- Note: Not same as OLS which minimizes projection of y onto x.

### PCA - Properties
- Unique
  - **U** and **V** unique up to a sign change
  - **D** unique
- Global solution

### PCA - Pattern Recognition
- **u_1** - first column of **U** encodes first major pattern in observation space
- **v_1** - first column of **V** encodes the associated first pattern in feature space
- *d_1* gives strength of first pattern
- Subsequent patterns are **uncorrelated** to first pattern (i.e., orthogonal)

### PCA - Data Visualization
- PC Scatterplots: 
  - Problem: can't visualize
  - Solution: plot **u_1** vs **u_2** and so forth
  - Advantages: 
    - Dramatically reduces number of 2D scatterplots to visualize
    - Focuses on patterns with most variance
- PC Loadings Plots: 
  - Scatterplots of **v_1** vs **v_2**
  - Visualizations of **v_k**
- Biplot: scatter plot of PC1 vs PC2 with loadings of **v_1** vs **v_2** overlaid

### PCA - Dimension Reduction
How to choose *K*? 
- Elbow in screeplot
- Take *K* that explains at least 90% (95%, 99%, etc) variance.
- More sophisticated: 
  - CV done internally 
  - Validation via matrix completion
  - Nuclear norm penalties

### PCA - Center and Scale?
- Typically, one should center features (i.e., columns of X)
  - Maximizing variance interpretation (assumes multivariate Gaussian model)
- Scaling changes PCA solution
  - Features with large scale contribute more to variance, have large PC loadings
- General Suggestions
  - Scale if features measured differently
  - Don't scale if features measured in same way & scale has meaning

### PC Analysis in R
- By default, `prcomp` centers the variables
- The option `scale = TRUE` standardizes the variables to have standard deviation 1
- The `rot` is shorthand for **rotation**, which reflects the fact that PC's are linear combinations of the original variables
- Each PC (column) in the table gives the weights for the linear combination for calculating the *m*th PC. So the columns of the table give the **PC loadings**.


### PC loadings
- Each PC loading is unique up to a sign flip (change of sign doesn't change the direction), so multiplying by -1 does not change the PCs.
- We can easily get the PC's from the PC loadings: the *m*th PC score vector is given by *Z_m* = *Xv_m*, where *v_m*  is the *m*th PC loading (*m*th column)
- More generally, we can get the PC score matrix *Z = XV* where *V* is the matrix of PC loadings.
- Observations can be plotted ("projected") in the space of PC's.
- Roughly this is equivalent to rotating the axes and plotting the original data points in the new axes Z_1 and Z_2
- We can get these by setting `retx = TRUE` in the `prcomp` call: `pc.out <- prcomp(USArrests, scale=TRUE, retx=TRUE)`
- `pc.out$x` is a matrix of dimension 50 by 4 (from USArrests dataset), which has as its columns the PC score vectors
- Plotting the observations in the space of PC scores can reveal interesting relationshps between them.
  - `plot(pc.out$x[,1], pc.out$x[,2], type="n", xlab="1st PC", ylab="2nd PC")`
  - `text(pc.out$x[,1], pc.out$x[,2], labels=states)`
- We can also plot the variables in the space of PC loadings: 
  - `plot(pc.out$rot, type="n")`
  - `text(pc.out$rot, names(USArrests), col=4)`

### PCA - Summary
Strengths: 
- Best linear dimension reduction
- Ordered/orthogonal components
- Unique, global solution

Weaknesses: 
- Nonlinear patterns
- Ultra high-dimensional settings (p >> n)

## Sparse PCA
- Motivation:
  - When p >> n, many features irrelevant.
  - PCA can perform poorly
- Idea:
  - Sparsity in **V**: zero out irrelevant features from PC loadings
  - Advantage: find important features that contribute to major patterns in the data
- How? 
  - Typically, optimize PCA criterion with sparsity-encouraging penalty of **V**
  - Many methods, active area of research
  
In R: `SPC` in `PMA` package.  
