# Anomaly-Detection-And-Movie-Recommendations-System

## **Overview**


This is a Anamoly Detection and Recommender system using MATLAB. 

The anamoly detection project uses the Multivariate Gaussian Distribution to fit the training data. We  collected data, m=307, when the detection algorithm detected anomalous behavior in the computer servers, thus the unlabeled dataset { x^1, ..., x^m}. The features measure the throughput (mb/s) and latency (ms) of response of each server and we suspect that the vast majority of these examples are "normal" or non-anomalous examples of the servers operating normally but there is a possibility that some of the examples from the servers is acting anomalously from the collected data. 




## **The Dataset**

The graph below is the first dataset:



![Image 12-30-23 at 4 40 PM](https://github.com/ntalib/Anomaly-Detection-Movie-Recommendations-System/assets/90749418/8c163b82-44a5-470c-a8a0-70f26129f2b2)




## **Gaussian Distribution**


To perform this anomaly detection, we need to fit the model to the data's distribution. 

Given that our training set {x^1,...,x^m}, where x^i ∈ R^n, we want to estimate the Gaussian distribution for each of the features x^i. For each i=1...n, we need to find parameters μ<sub>i</sub> and σ<sub>i</sub><sup>2</sup>  that fit the data in the i<sup>th<sup> dimension {*x*<sub>i</sub> ^1 ,....,*x*<sub>i</sub>^m} 

The Gaussian distribution is given by:



![Image 12-30-23 at 6 12 PM](https://github.com/ntalib/Anomaly-Detection-Movie-Recommendations-System/assets/90749418/49af44e8-e824-4c96-bb31-404f081dae53)


Where miu is the mean and the sigma squared controlss the variance.



## Project Schema 1: Estimating the parameters for a Gaussian distribution


To estimate the parameters (miu, sigma squared) of the ith feature by using the following equations. 


To estimate the mean, miu, we will use:

![Image 12-30-23 at 6 17 PM](https://github.com/ntalib/Anomaly-Detection-Movie-Recommendations-System/assets/90749418/c4cb466c-22d0-4f2f-8575-3a8b19f6ac87)


and for the variance, sigma, we will use:

![Image 12-30-23 at 6 18 PM](https://github.com/ntalib/Anomaly-Detection-Movie-Recommendations-System/assets/90749418/ef659cc9-19c9-4bea-aa0e-25ac9aeeb966)


The file *estimateGaussian.m* is a function that takes data matrix X as input and output an n-dimension vector *mu* that hols the mean of all the *n* features and another n-dimension vector mu that holds the mean of all the n features and another n-dimension vector sigma2 that holds the variances of all the features. 

We will also be visulaizing the contours of the fitted Gaussian distribution and we should have a plot similar to below: 

![Image 12-30-23 at 6 40 PM](https://github.com/ntalib/Anomaly-Detection-Movie-Recommendations-System/assets/90749418/7d8b5894-25d1-4b48-ac9b-e03376ea01a0)


From the plot visuals, we can see that most of non-anomalous examples are in the region with the highest probility, while the anomalous training examples are in the region with lower probabilities. 


## Project Schema 2: Selecting the threshold, ε


After estimating or Gaussian distribution parameters, we can now investigate which training examples have a very high probability given this distribution and which training example has a low probability. 


The low probability training examples are more likely to be the anomalies in our traning examples, and a way to determine which examples are anomalies is to select athreshole based on a cross validation set. 


In this part of the project we will implement as algorithm to select the threshold ε using F<sub>1</sub> score on the cross validation set. For this we use a cross validation trainging set 

{(*x*<sub>cv</sub><sup>(1)</sup>,*y*<sub>cv</sub><sup>(1)</sup>),...,(*x*<sub>cv</sub><sup>(m)</sup>,*y*<sub>cv</sub><sup>(m)</sup>), where the label y=1 corresponds to an anomalous training example and y=0  corresponds to a normal training example. For each cross validation training example, we will compute *p*(x<sub>cv</sub><sup>(i)</sup>). The vector of all these probabilities *p*(x<sub>cv</sub><sup>(1)</sup>),...,*p*(x<sub>cv</sub><sup>(m)</sup>) is passed to the file function **selectThreshold.m** in the vector *pval*, and *y*<sub>cv</sub><sup>(m)</sup>) is passed through it as well.

**selectThreshold.m** will then return (1) the selected threshold, ε and (2) the F<sub>1</sub> score. When it returns (1) the selected threshold, ε , and an example *x* has a low probability of *p(x)<ε* , then it is considered to be an anamoly. And when it return (2) the F<sub>1</sub> score, that should tells you how good we're doing on finding the ground truth anomalies given a certain threshold. 


For the various value of ε, we will also compute the F<sub>1</sub> score by computing how many examples the current threshold classifies correctly. 

F<sub>1</sub> is compute by using *prec* and *rec*:

![Image 1-3-24 at 12 16 PM](https://github.com/ntalib/Anomaly-Detection-Movie-Recommendations-System/assets/90749418/356de2e0-67d8-450a-a677-7654bd738b91)


Then we compute precision and recall by:


  prec = a / (a + b);
  rec = a / (a + c);


  where,

*a* is the number of true positives: the ground truth lavel says it's an anomaly and our algorithm correctly classified it as an anomaly 

*b* is the number of false positives: the ground truth label says it's not an anomaly, but our algorithm incorrectly classified it as an anomaly.

*c* is the number of false negatives: the ground truth lable says it's an anomaly, but our algorithm incorrectly classified it as not being anomalous. 



















