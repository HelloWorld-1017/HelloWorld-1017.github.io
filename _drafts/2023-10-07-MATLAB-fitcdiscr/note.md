



MATLAB `fitcdiscr` function [1] is for 'Fit discriminant analysis classifier', and the algorithm introduction in the official documentation gives more information: 

![image-20231007224244709](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231007224244709.png)









It can bee seen that, `fitcdiscr` function is actually used to fit the 

Taking `fisheriris` dataset as an example, the following text will analyse the `fitcdiscr` function.

## Linear discriminant analysis

For sake of easy visual analysis in the later part, we select the first three features of `meas` variable to analyse:

```matlab
load fisheriris
meas = meas(:,1:3);

mdl = fitcdiscr(meas,species); % DiscrimType: 'linear'(fault)
mus = mdl.Mu;
Sigmas = mdl.Sigma;
```

```
mus =
    5.0060    3.4280    1.4620
    5.9360    2.7700    4.2600
    6.5880    2.9740    5.5520
Sigmas =
    0.2650    0.0927    0.1675
    0.0927    0.1154    0.0552
    0.1675    0.0552    0.1852
```

As described, for linear discriminant analysis, the multiviriate normal distribution of each class has its own mean value, but all the classes have a common covariance matrix. 

And the the mean vector of each multiviriate normal distribution is estimated by the sample mean vector of each class, but the covariance matrix is not estimated by neither the sample covariance matrix of all the samples, nor the sample covariance matrix of each class:

```matlab
[ClassVariables,Classes] = findgroups(species);
means = splitapply(@mean,meas,ClassVariables);
Covs = splitapply(@(x){cov(x)},meas,ClassVariables);
Covs{1},Covs{2},Covs{3}
cov(meas)
```

```
>> means,celldisp(Covs),Cov_all
means =
    5.0060    3.4280    1.4620
    5.9360    2.7700    4.2600
    6.5880    2.9740    5.5520
Covs{1} =
    0.1242    0.0992    0.0164
    0.0992    0.1437    0.0117
    0.0164    0.0117    0.0302
Covs{2} =
    0.2664    0.0852    0.1829
    0.0852    0.0985    0.0827
    0.1829    0.0827    0.2208
Covs{3} =
    0.4043    0.0938    0.3033
    0.0938    0.1040    0.0714
    0.3033    0.0714    0.3046
Cov_all =
    0.6857   -0.0424    1.2743
   -0.0424    0.1900   -0.3297
    1.2743   -0.3297    3.1163
```

The common covariance matrix is *likely* **the weighted average of sample covariance matrix of each class**:

```
>> Covs{1}/3+Covs{2}/3+Covs{3}/3
ans =
    0.2650    0.0927    0.1675
    0.0927    0.1154    0.0552
    0.1675    0.0552    0.1852
```

and he coefficient is *seemingly* determined by the `mdl.Prior`, which is sample number proportion of each class (default value `emperical`):

```
>> mdl.Prior
ans =
    0.3333    0.3333    0.3333
```

![image-20231008130410990](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231008130410990.png)

> If we change the sample number of each class to 40, 30, and 20, respectively, and re-run the code:
>
> ```matlab
> load fisheriris
> meas = meas(:,1:3);
> 
> idx = [1:10,61:80,101:130];
> meas(idx,:) = [];
> species(idx,:) = [];
> 
> mdl = fitcdiscr(meas,species); % DiscrimType: 'linear'(fault)
> mus = mdl.Mu;
> Sigmas = mdl.Sigma;
> 
> [ClassVariables,Classes] = findgroups(species);
> means = splitapply(@mean,meas,ClassVariables);
> Covs = splitapply(@(x){cov(x)},meas,ClassVariables);
> ```
>
> ```
> >> mdl.Prior
> ans =
>     0.4444    0.3333    0.2222
> ```
>
> ```
> >> Sigmas,mdl.Prior(1)*Covs{1}+mdl.Prior(2)*Covs{2}+mdl.Prior(3)*Covs{3}
> Sigmas =
>     0.2278    0.0976    0.1170
>     0.0976    0.1214    0.0501
>     0.1170    0.0501    0.1317
> ans =
>     0.2285    0.0975    0.1176
>     0.0975    0.1212    0.0503
>     0.1176    0.0503    0.1323
> ```
>
> The difference between the covariance matrix of `mdl` and the one we calculated still exist, although small. I don't check whether or not this deviation is caused by numerical calculation error.

So to my mind, strictly speaking, the description in the official documentation 'the model assumes `X` has a Gaussian mixture distribution' is not that appropriate (at least for this case where using the default easy linear discriminant analysis), as the coefficients are not estimated but just calculated by sample number. Another MATLAB documentation `fitgmdist` using EM iterative algorithm is more reasonable, the analysis of which could be found in blog [2].

After getting the sample mean and shared weighted covariance matrix, we could use `mvnrnd` function to generate samples, and compared them with the samples in `fisheiris` dataset:

```matlab
clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl = fitcdiscr(meas,species); % DiscrimType: 'linear'(fault)
mus = mdl.Mu;
Sigmas = mdl.Sigma;

numNew = 200;
newSetosa = mvnrnd(mus(1,:),Sigmas,numNew);
newVersicolor = mvnrnd(mus(2,:),Sigmas,numNew);
newVirginica = mvnrnd(mus(3,:),Sigmas,numNew);

meas_setosa = meas(strcmp(species,"setosa"),:);
meas_versicolor = meas(strcmp(species,"versicolor"),:);
meas_virginica = meas(strcmp(species,"virginica"),:);

figure("Units","pixels","Position",[390.3333333333333,465,1550,420])
tiledlayout(1,3,"TileSpacing","tight")
markerSize = 20;
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_setosa(:,1),meas_setosa(:,2),meas_setosa(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newSetosa(:,1),newSetosa(:,2),newSetosa(:,3), ...
    markerSize,"filled","DisplayName","Generated","MarkerFaceColor",[249,82,107]/255)
legend("Location","north","Orientation","horizontal");
title("Species: Setosa")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_versicolor(:,1),meas_versicolor(:,2),meas_versicolor(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVersicolor(:,1),newVersicolor(:,2),newVersicolor(:,3), ...
    markerSize,"filled","DisplayName","Generated","MarkerFaceColor",[249,82,107]/255)
legend("Location","north","Orientation","horizontal");
title("Species: Versicolor")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_virginica(:,1),meas_virginica(:,2),meas_virginica(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVirginica(:,1),newVirginica(:,2),newVirginica(:,3), ...
    markerSize,"filled","DisplayName","Generated","MarkerFaceColor",[249,82,107]/255)
legend("Location","north","Orientation","horizontal");
title("Species: Virginica")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")
```

![image-20231008105612371](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231008105612371.png)

<br>

## Quadratic discriminant analysis

As pointed out in the official documentation [1], specifying the property `DiscrimType` to `quadratic` could make a quadratic discriminant analysis and at which case, both mean and covariance matrix of each class vary.

```matlab
load fisheriris
meas = meas(:,1:3);

mdl = fitcdiscr(meas,species,"DiscrimType","quadratic"); % DiscrimType: quadratic
mus = mdl.Mu;
Sigmas = mdl.Sigma;
```

```
>> mus,Sigmas
mus =
    5.0060    3.4280    1.4620
    5.9360    2.7700    4.2600
    6.5880    2.9740    5.5520
Sigmas(:,:,1) =
    0.1242    0.0992    0.0164
    0.0992    0.1437    0.0117
    0.0164    0.0117    0.0302
Sigmas(:,:,2) =
    0.2664    0.0852    0.1829
    0.0852    0.0985    0.0827
    0.1829    0.0827    0.2208
Sigmas(:,:,3) =
    0.4043    0.0938    0.3033
    0.0938    0.1040    0.0714
    0.3033    0.0714    0.3046
```

Similarly, we could compare these parameters with the calculated ones:

```
>> means,celldisp(Covs)
means =
    5.0060    3.4280    1.4620
    5.9360    2.7700    4.2600
    6.5880    2.9740    5.5520
Covs{1} =
    0.1242    0.0992    0.0164
    0.0992    0.1437    0.0117
    0.0164    0.0117    0.0302
Covs{2} =
    0.2664    0.0852    0.1829
    0.0852    0.0985    0.0827
    0.1829    0.0827    0.2208
Covs{3} =
    0.4043    0.0938    0.3033
    0.0938    0.1040    0.0714
    0.3033    0.0714    0.3046
```

It can be seen that, for quadratic discriminant analysis, the mean vector and covariance matrix are respectively estimated by sample mean vector and unbiased sample variance matrix of each class, that is making a unbiased estimation for multivariate normal distribution of each class.

At last, we could graphically compare the generated samples, including generated by linear model and by quadratic model, and original ones:

```matlab
clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl_linear = fitcdiscr(meas,species); % DiscrimType: linear
mus_linear = mdl_linear.Mu;
Sigmas_linear = mdl_linear.Sigma;

mdl_quadratic = fitcdiscr(meas,species,"DiscrimType","quadratic"); % DiscrimType: quadratic
mus_quadratic = mdl_quadratic.Mu;
Sigmas_quadratic = mdl_quadratic.Sigma;

numNew = 50;

newSetosa_linear = mvnrnd(mus_linear(1,:),Sigmas_linear,numNew);
newSetosa_quadratic = mvnrnd(mus_quadratic(1,:),Sigmas_quadratic(:,:,1),numNew);

newVersicolor_linear = mvnrnd(mus_linear(2,:),Sigmas_linear,numNew);
newVersicolor_quadratic = mvnrnd(mus_quadratic(2,:),Sigmas_quadratic(:,:,2),numNew);

newVirginica_linear = mvnrnd(mus_linear(3,:),Sigmas_linear,numNew);
newVirginica_quadratic = mvnrnd(mus_quadratic(3,:),Sigmas_quadratic(:,:,3),numNew);

meas_setosa = meas(strcmp(species,"setosa"),:);
meas_versicolor = meas(strcmp(species,"versicolor"),:);
meas_virginica = meas(strcmp(species,"virginica"),:);

figure("Units","pixels","Position",[390.3333333333333,465,1550,420])
tiledlayout(1,3)
markerSize = 20;
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_setosa(:,1),meas_setosa(:,2),meas_setosa(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newSetosa_linear(:,1),newSetosa_linear(:,2),newSetosa_linear(:,3), ...
    markerSize,"filled","DisplayName","Linear model","MarkerFaceColor",[249,82,107]/255)
scatter3(newSetosa_quadratic(:,1),newSetosa_quadratic(:,2),newSetosa_quadratic(:,3), ...
    markerSize,"filled","DisplayName","Quadratic model","MarkerFaceColor","g")
legend("Location","northeast","Orientation","horizontal");
title("Species: Setosa")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_versicolor(:,1),meas_versicolor(:,2),meas_versicolor(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVersicolor_linear(:,1),newVersicolor_linear(:,2),newVersicolor_linear(:,3), ...
    markerSize,"filled","DisplayName","Linear model","MarkerFaceColor",[249,82,107]/255)
scatter3(newVersicolor_quadratic(:,1),newVersicolor_quadratic(:,2),newVersicolor_quadratic(:,3), ...
    markerSize,"filled","DisplayName","Quadratic model","MarkerFaceColor","g")
legend("Location","north","Orientation","horizontal");
title("Species: Versicolor")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_virginica(:,1),meas_virginica(:,2),meas_virginica(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVirginica_linear(:,1),newVirginica_linear(:,2),newVirginica_linear(:,3), ...
    markerSize,"filled","DisplayName","Linear model","MarkerFaceColor",[249,82,107]/255)
scatter3(newVirginica_quadratic(:,1),newVirginica_quadratic(:,2),newVirginica_quadratic(:,3), ...
    markerSize,"filled","DisplayName","Quadratic model","MarkerFaceColor","g")
legend("Location","northeast","Orientation","horizontal");
title("Species: Virginica")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")
```

![image-20231008122309274](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231008122309274.png)

We could simply test the similarity of generated samples and original ones by Mahalanobis Distance (could see blog [3]) for both models:

```matlab
fprintf("Linear model, Avarage Mahalanobis distance: \n" + ...
    "(setosa): %.4f\n" + ...
    "(versicolor): %.4f\n" + ...
    "(Virginica): %.4f\n", ...
    mean((sqrt(mahal(newSetosa_linear,meas_setosa)))), ...
    mean((sqrt(mahal(newVersicolor_linear,meas_versicolor)))), ...
    mean((sqrt(mahal(newVirginica_linear,meas_virginica)))));
disp(newline)
fprintf("Quadratic model, Avarage Mahalanobis distance: \n" + ...
    "(setosa): %.4f\n" + ...
    "(versicolor): %.4f\n" + ...
    "(Virginica): %.4f\n", ...
    mean((sqrt(mahal(newSetosa_quadratic,meas_setosa)))), ...
    mean((sqrt(mahal(newVersicolor_quadratic,meas_versicolor)))), ...
    mean((sqrt(mahal(newVirginica_quadratic,meas_virginica)))));
```

```
Linear model, Avarage Mahalanobis distance: 
(setosa): 2.8597
(versicolor): 1.6980
(Virginica): 1.4635

Quadratic model, Avarage Mahalanobis distance: 
(setosa): 1.5988
(versicolor): 1.6957
(Virginica): 1.5438
```

In a word, for class setosa, quadratic model is better than linear model, while for other two classes, the performance of both model is similar.

<br>

Actually, if see official documentation in detail, we could find that the `fitcdiscr` function actually support using cross validation to automatically optimize hyperparameters of the model. Some concerned arguments of `fitcdiscr` function are about this setting, but here we just take an official example to partly introduce it. The official examples are as followings:

```matlab
clc,clear,close all
rng(1)

load fisheriris.mat
meas = meas(:,1:3);
mdl = fitcdiscr(meas,species, ...
    'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions', ...
    struct('AcquisitionFunctionName','expected-improvement-plus'));
```

The command line window will display optimization information during process, and simultaneously, two progress figure are plotted dynamically.

```
|=====================================================================================================|
| Iter | Eval   | Objective   | Objective   | BestSoFar   | BestSoFar   |        Delta |        Gamma |
|      | result |             | runtime     | (observed)  | (estim.)    |              |              |
|=====================================================================================================|
|    1 | Best   |     0.66667 |    0.097063 |     0.66667 |     0.66667 |       13.261 |      0.25218 |
|    2 | Best   |    0.046667 |    0.063293 |    0.046667 |     0.08907 |   2.7404e-05 |     0.073264 |
|    3 | Accept |    0.053333 |    0.094705 |    0.046667 |    0.046743 |   3.2455e-06 |      0.46974 |
|    4 | Accept |     0.66667 |    0.060125 |    0.046667 |    0.046775 |       14.879 |      0.98622 |
|    5 | Accept |        0.06 |    0.061027 |    0.046667 |    0.047394 |    1.099e-05 |      0.57159 |
|    6 | Accept |         0.1 |    0.066511 |    0.046667 |     0.05231 |   0.00050462 |      0.99565 |
|    7 | Accept |    0.086667 |    0.062412 |    0.046667 |    0.051108 |   1.0009e-06 |      0.87313 |
|    8 | Best   |        0.04 |    0.072547 |        0.04 |    0.046615 |   2.1933e-05 |      0.40979 |
|    9 | Accept |        0.04 |    0.071383 |        0.04 |    0.044901 |   2.3684e-05 |      0.16106 |
|   10 | Accept |        0.04 |    0.072423 |        0.04 |     0.04387 |   2.5137e-05 |      0.18557 |
|   11 | Accept |     0.66667 |    0.068188 |        0.04 |    0.043785 |       997.45 |      0.87848 |
|   12 | Accept |    0.086667 |     0.06196 |        0.04 |    0.038679 |   3.1401e-05 |      0.85968 |
|   13 | Accept |    0.046667 |    0.074078 |        0.04 |     0.04082 |   4.3139e-06 |    1.726e-05 |
|   14 | Accept |    0.046667 |    0.064147 |        0.04 |    0.039845 |   1.6147e-05 |    0.0013389 |
|   15 | Accept |        0.04 |    0.071702 |        0.04 |    0.039819 |   1.0189e-06 |      0.17587 |
|   16 | Accept |        0.04 |    0.060839 |        0.04 |    0.039729 |   0.00010818 |      0.35198 |
|   17 | Accept |        0.04 |    0.064474 |        0.04 |    0.038731 |   5.0829e-05 |      0.32588 |
|   18 | Accept |        0.04 |    0.068561 |        0.04 |    0.038734 |   1.0133e-06 |     0.015301 |
|   19 | Accept |        0.04 |    0.069015 |        0.04 |    0.039063 |   4.9562e-05 |      0.31226 |
|   20 | Accept |        0.04 |     0.06588 |        0.04 |    0.039067 |   1.0051e-06 |      0.15054 |
|=====================================================================================================|
| Iter | Eval   | Objective   | Objective   | BestSoFar   | BestSoFar   |        Delta |        Gamma |
|      | result |             | runtime     | (observed)  | (estim.)    |              |              |
|=====================================================================================================|
|   21 | Accept |        0.04 |    0.079592 |        0.04 |    0.039188 |   3.4961e-05 |      0.29902 |
|   22 | Accept |    0.046667 |    0.069204 |        0.04 |    0.039317 |     0.037935 |   0.00090253 |
|   23 | Accept |    0.046667 |    0.073799 |        0.04 |    0.039225 |    0.0040557 |   0.00046815 |
|   24 | Accept |        0.04 |    0.069003 |        0.04 |    0.039226 |     0.013049 |      0.36435 |
|   25 | Accept |    0.046667 |     0.06255 |        0.04 |    0.039268 |     0.014585 |     0.011052 |
|   26 | Accept |        0.04 |    0.065089 |        0.04 |    0.039265 |   0.00073402 |      0.23526 |
|   27 | Accept |        0.04 |    0.069593 |        0.04 |    0.039259 |    0.0028255 |      0.34862 |
|   28 | Accept |        0.04 |    0.077335 |        0.04 |    0.039264 |     0.026283 |      0.31726 |
|   29 | Accept |        0.04 |    0.089576 |        0.04 |    0.039284 |   0.00025517 |      0.21955 |
|   30 | Accept |    0.086667 |     0.06082 |        0.04 |     0.03928 |     0.018889 |      0.89185 |

__________________________________________________________
Optimization completed.
MaxObjectiveEvaluations of 30 reached.
Total function evaluations: 30
Total elapsed time: 15.5541 seconds
Total objective function evaluation time: 2.1069

Best observed feasible point:
      Delta        Gamma 
    __________    _______

    2.1933e-05    0.40979

Observed objective function value = 0.04
Estimated objective function value = 0.041926
Function evaluation time = 0.072547

Best estimated feasible point (according to models):
      Delta        Gamma 
    __________    _______

    3.4961e-05    0.29902

Estimated objective function value = 0.03928
Estimated function evaluation time = 0.074397
```

![image-20231008133239246](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231008133239246.png)

![image-20231008133245704](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231008133245704.png)







<br>





<br>

**References**

[1] [fitcdiscr - MathWorks](https://ww2.mathworks.cn/help/stats/fitcdiscr.html).

[2] [Gaussian Mixture Model(GMM) - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/machine learning/Gaussian-Mixture-Model/).

[3] [Multivariate Normal Distribution and Mahalanobis Distance - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Multivariate-Normal-Distribution-and-Mahalanobis-Distance/).









