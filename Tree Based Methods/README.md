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

### Trees: Pros & Cons

Pros
- very easy to interpret and explain to others
- can be easily displayed graphically (especially if they are very small)
- can easily handle qualitative predictors without the need to create dummy variables

Cons
- unfortunately, trees generally do not have the same level of predictive accuracy as some of the other regression and classification methods we've discussed so far

By aggregating many decision trees, the predictive performance of trees can be substantially improved.

## Bootstrap 

https://medium.com/@SeattleDataGuy/how-to-develop-a-robust-algorithm-c38e08f32201

Confidence Intervals: http://www2.stat.duke.edu/~banks/111-lectures.dir/lect13.pdf
- Data is normally distributed (which rarely happens in practice)
- The sample size *n* is large enough that this holds asymptotically (CLT)

Bootstrap method refers to random sampling with replacement. This sample is referred to as a resample. This allows the model or algorithm to get a better understanding of the various biases, variances and features that exist in the resample. Taking a sample of the data allows the resample to contain different characteristics than it might have contained as a whole. This is good for small size datasets that have a tendency to overfit.

Bootstrap is useful because it provides stability of a solution. By using multiple sample datasets and then testing multiple methods, it can increase robustness. Bootstrapping uses both bagging and boosting, which will be discussed later.

- Bagging, random forests, and boosting use trees as building blocks to construct more powerful prediction models (unfortunately, this comes at the cost of ease of interpretation)
- All of these methods build many trees to improve the performance of tree-based methods. This is motivated by the fact that usual trees have high variance.
- Both bagging and random forests build trees by sampling from the original data using the bootstrap
- Bootstrap is a powerful and general procedure that can be used assess the variability of estimators. Here, we see that bootstrap can also be used to improve the performance of estimators.

### Additional comments of bootstrap
- When does the bootstrap (probably) work? 
  - When our statistic, suitably centered and scaled, has a reasonable asymptotic distribution.
- When does bootstrap not work? 
  - When our statistic is weird (not a smooth function of the data), or when *n* is really small (boostrap is an asymptotic procedure too).
- Other thoughts
  - Using "fancier" bootstraps (ABC, BCA, "t", etc.) can lead to more correct CI (more correct than using asymptotic normality)
  - Bootstrap can also be used to estimate the test error, but this is not straightforward.
  - We don't have to take a sample size of *n*, we can take a smaller sample of size *m* (especially when the original bootstrap does not work), but the sampling should always be with replacement. 

## Bagging

Bagging refers to **bootstrap aggregators**. Bagging predictors is a method for generating multiple versions of a predictor and using these to get an aggregated predictor. Bagging helps reduce variance from models that may be very accurate, but only the data they were trained on (overfitting). Decision trees can be easily overfit, as they are composed of if-else statements. Thus, if the dataset is changed to a new dataset that might have some bias or difference in spread of underlying featuers compared to the previous set. The model will fail to be accurate because test data will not fit it as well. 

Bagging overcomes this because it creating it's own variance amongst the data by sampling and replacing data while it tests multiple hypothesis (models). This reduces noise by utilizing multiple samples that would most likely be made up of data with various attributes (median, average, etc.)

Once each model has developed a hypothesis, the models use *voting for classification* or *averaging for regression*. Each hypothesis has the same weight as all the others. All of the models run at the same time, and vote on which hypothesis is the most accurate. This helps decrease variance, i.e., reduce the overfit. 

The usual decision trees (regression or classification) have high variance: 
- If we split the training data into two parts, we get very different trees
- Methods with low variance (e.g., linear regression with small *p*) give similar models in this case

This is a general purpose procedure for reducing the variance of a statistical learning method.

Some remarks: 
- For classification trees, majority voting takes the place of averaging
- When using bagging with trees, each tree is grown deep and is not pruned
- Thus, each individual tree has high variance, but low bias. Averaging these *B* trees reduces the variance. 
- The value of *B* is not critical: 
  - Using a very lare value of *B* will not lead to overfitting
  - As *B* increases, computation becomes more expensive
  - In practice, *B* = 100 to *B* = 1000 works pretty well
  
## Random Forests
- Suppose that there is one very strong predictor in the dataset, along with a number of moderately strong ones.
- Then in the collection of bagged trees, most or all of the trees will use this strong predictor in the top split, and they all look somewhat similar.
- This means that predictions from the bagged trees can be highly correlated.
- Averaging many highly correlated predictors does not lead to as large of a reduction in variance as uncorrelated predictors.
- In such a case, bagging may not give significance reduction in variance compared to a single tree. 

### Out-of-Bag Error Estimations
- It turns out that we can easily estimate the test error in a *bagged model*
- In general, the chance of a single observation being included in a given boostrap sample is about 2/3
- The remaining one-third of the observations not used to fit a given bagged tree are called out-of-bag (OOB) observations
- These OOB observations can be used to estimate the test error

## Interpreting the Results
- Unfortunately, bagging and random forests result in models that are not easily interpretable: 
  - It is unclear how each variable affects each of the tree models, and how we should interpret the final model
- A very useful tool for gaining insight about individual variables is the variable importance plot
  - The plot shows the total amount of improvement in RSS/Gini Index/entropy resulting from splits over a given predictor, averaged over all *B* trees
  
## Boosting
Boosting refers to a group of algorithms that utilize weighted averages to make weak learners into stronger learners. Unlike bagging that had each model run independently and then aggregate the outputs at the end without preference to any model, boosting is all about the "teamwork." Each model that runs, dictates what features the next model will focus on. 

Boosting also requires bootstrapping. Unlike bagging, boosting weighs each sample of data, so samples will be run more often than others.

- Boosting is another approach for improving the performance of tree-based methods
- Like bagging and random forests, boosting uses multiple trees. The main difference is that
  - Bagging and random forests aggregate trees based on multiple copies of the data
  - Boosting aggregates trees based on a modified version of the same data
- Although we focused here on tree-based methods, bagging and boosting are general purpose methods that can improve the performance of any prediction method  
- Boosting does not involve on bootstrap sampling, and everything is based on a single dataset.
- In boosting, the trees are grown sequentially: each tree is grown using information based on previously grown trees.
- Instead of fitting a single large decision tree, which can potentially overfit of the data, in boosting we learn slowly.
  - Each tree is small, with just a few terminal nodes.
  - Given the current model, we fit a decision tree to the residuals from the previous model as the response.
  - We then add this new decision tree into the fitted function and update the residuals.
- By fitting small trees to the residuals, we slowly improve the projected function in areas where it does not perform well.
- The *i*th classifier is supposed to correct the mistakes made by the previous classifier (*i* - 1). It is done by weighing more the misclassified observations. The final classifier is calculated by a weighted mean of all the "weak" classifiers, the weights being close the accuracies calculated for each classifier.
