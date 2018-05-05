# Classification

Regression involves predict a continuous-valued response. Classification involves predicting a categorical response. Classification problems tend to occur even more frequently than regression problems in practice. Just like regression, 

- Classification cannot be performed blindly in high-dimensions **because you will get zero training error but awful test error**.
- Properly estimating the test error is crucial.
- Classical classification approaches can be extended to high-dimensions, which we have seen in regression contexts.

There are many approaches out there for performing classification. These include

- Model-based methods: 
  - Logistic regression
  - LDA
  - QDA
  
- Non-parametric methods: KNN classification

- Margin-based classifiers: support vector machines (SVM)

The only difference from regression is that response y is a categorical variable with K categories. We mostly focus on K = 2. 

### Drawbacks of Linear Regression for Classification

If we code the values of y as 0 and 1 (instead of -1 and 1), then the linear regression gives an estimate of the probability P(y = 1 | X), which is sensible. However, there is no guarantee that the estimated probabilities are in fact between 0 and 1. And in general, they are actually not. 

There is also a serious problem if y has more than 2 categories. 
- Suppose that we are trying to predict the medical condition of a patient in th emergency room on the basis of her symptoms, and there are three possible diagnoses: stroke (coded as 1), drug overdose (coded as 2), and epileptic seizure (coded as 3). 
- Unfortunately, this coding implies an ordering on the outcomes, putting drug overdose between stroke and epileptic seizure. 
- In practice, there is no particular reason that this needs to be the case and one could choose any other equally reasonable coding. 

### 0-1 Loss & Optimal Classifier

- A natural loss function for categorical data is the 0-1 loss function which counts how many cases are classified incorrectly.
- As in the setting of linear regression, in general we want to estimate a function that gives the smallest 0-1 loss.
- Using this loss function, a good classifier is one for the test error is minimized.
- It turns out that the test error based on 0-1 loss is minimized by if we assign each observation to the most likely cases, given its predictor values P(Y = k | X = x_0). This is known as the **Bayes classifier**. In general, we cannot use this unless we know the joint probability distribution. 
  - We can also get the Bayes error rate, which is the lowest test error we can get. 

## High Dimensional Classification 
- Classification using linear regression
- Logistic regression (and penalized logistic regression)
- KNN classification
- LDA & QDA
- Support Vector Machines (SVM)

## Logistic Regression
- Straightforward extension of linear regression to the classification setting
- For simplicity, suppose y in {0,1}: a two-class classification problem.
- Instead logistic regression assume a parametric model. 
- If this assumption holds, logistic regression, is a good model-based alternative to Bayes classifier.

## Breast Cancer Subtypes Example

In the past 10 years, global gene expression analyses have identified at least 4 subtypes of breast cancer: 

1. Luminal A
2. Luminal B
3. Her2-enriched
4. Basal-like

Subgroups differ with respect to risk factors, incidence, baseline prognoses, response to therapies. Want to able to determine the subytpe for a new patient with breast cancer. Controversy over the best classifier for this task: 

- PAM50 classifier involves 50 genes.
- More recent proposal involving three genes.

Moving taret: nobody knows the "true" subtype. 

Citation: Prat et al., Breast Cancer Res Treat, 2012
