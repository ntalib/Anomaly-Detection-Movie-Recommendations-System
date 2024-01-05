# Anomaly-Detection-System

## **Overview**


This is a Anamoly Detection and Recommender system using MATLAB. 

The anamoly detection project uses the Multivariate Gaussian Distribution to fit the training data. We  collected data, m=307, when the detection algorithm detected anomalous behavior in the computer servers, thus the unlabeled dataset { x^1, ..., x^m}. The features measure the throughput (mb/s) and latency (ms) of response of each server and we suspect that the vast majority of these examples are "normal" or non-anomalous examples of the servers operating normally but there is a possibility that some of the examples from the servers is acting anomalously from the collected data. 




## **The Dataset**

The graph below is the first dataset:



![Image 1-3-24 at 7 29 PM](https://github.com/ntalib/Anomaly-Detection-System/assets/90749418/5944de0a-6f73-4fcb-baba-c9ac087b5bc6)



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

![Image 1-3-24 at 7 30 PM](https://github.com/ntalib/Anomaly-Detection-System/assets/90749418/6707f1cd-e382-4f31-9f87-c3921159b777)


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


Then we compute precision and recall by computing:


  prec = a / (a + b);
  
  rec = a / (a + c);


  where,

*a* is the number of true positives: the ground truth lavel says it's an anomaly and our algorithm correctly classified it as an anomaly 

*b* is the number of false positives: the ground truth label says it's not an anomaly, but our algorithm incorrectly classified it as an anomaly.

*c* is the number of false negatives: the ground truth lable says it's an anomaly, but our algorithm incorrectly classified it as not being anomalous. 


**selectThreshold.m** has a loop that will try different values of ε, and will select the best ε based on the F<sub>1</sub> score. To compute a, b and c, we are using a vectors. We can implement this by using MATLAB equality test between a vector and a single number. If there is a several binary values in a n-dimensional binary vector
![Image 1-3-24 at 2 47 PM](https://github.com/ntalib/Anomaly-Detection-System/assets/90749418/c50daa43-2f9b-4f01-a3e7-731594b8fd59) 

we can find out how many values in this vector are 0 by using: *sum(v == 0)*. We can also apply a logical and operator to binary vectors. 



![Image 1-3-24 at 2 26 PM](https://github.com/ntalib/Anomaly-Detection-System/assets/90749418/2674b105-1d94-4e93-b682-d33394d45c47)

We should see the value for epsilon approximately at 8.99e-05 when we run 


![Image 1-3-24 at 3 04 PM](https://github.com/ntalib/Anomaly-Detection-System/assets/90749418/47d84763-7d7e-432d-8dac-f74f7ac001ea)


## Project Schema 3: Dimensional dataset

The last part of the script of Anomaly.m is it will run the anomaly detection algotithm using a more dimensional dataset. This dataset has 11 features that captures more properties of the computer servers. The script will also use the code to estimate Gaussian parameters (μi and σi2) and evaluate the probabilities for both the training data X from were we estimated the Gaussian parameters and also fo the cross validation set Xval. Finally, it will use the *selectThreshold* to find the best threshold ε. We would see the value epsilon of about 1.38e-18 and 117 anomalies detected. 














