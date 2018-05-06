# Tree Based Methods
Tree based methods can be for classification & regression
- Classification & regression trees
- Bootstrap
- Bagging & boosting
- Random forests

The main steps of tree-based methods are as follows: 
- Stratify (or segment) the predictor space into small and simple regions
- For each observation, determine which segment it belongs to; the stratification of space can be captured by a tree
- Predict the outcome by the mean (regression) or mode (classification) of outcomes in that segment

## Decision Trees
- The **regression tree** gives an over-simplification of the true relationship between variables.
- However, it is very easy to interpret, and has a nice graphical representation: you can easily explain it to a non-statistician, and don't need a computer (or even a calculator) to get an estimate.

### Tree Pruning
- The complexity of the regression tree is determined by the number of regions *J*
- A tree with large *J* may work well in the training data, but would be very bad on test data
- A smaller tree with fewer splits might have lower variance and better interpretation at the cost of a little bias
- One option is to consider a split only if the drop in RSS is larger than some (high) threshold
- However, this may not be a good strategy since a so-so split at step *j* may be followed by a great one at step *j* + 1
- Instead, we first grow a large tree, e.g., until no region has > 5 observations, and then prune it to obtain a subtree

## Algorithm: Building a Regression Tree

1. Use recursive binary splitting to grow a large tree on the training data, stopping only when each terminal node has fewer than some minimum number of observations.
2. Apply cost complexity pruning to the large tree in order to obtain a sequence of best subtrees, as a function of alpha.
3. Use K-fold cross-validation to choose alpha. That is, divide the training observations into K folds. For each k = 1,...,K:
  a. Repeat steps 1 and 2 on all but the *k*th fold of the training data.
  b. Evaluate the mean squared prediction error on the data in the left-out *k*th fold, as a function of alpha.
  
  Average the results for each value of alpha, and pick alpha to minimize the average error.

4. Return the subtree from Step 2 that corresponds to the chosen value of alpha.
