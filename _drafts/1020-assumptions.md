今天在重新看MATLAB的`filloutliers`函数的官方文档时，注意到了一个参考：

> [1] *NIST/SEMATECH e-Handbook of Statistical Methods*, [https://www.itl.nist.gov/div898/handbook/](https://www.itl.nist.gov/div898/handbook/), 2013.

这是一本电子指南，由美国国家标准与技术研究所(National Institute of Standards and Technology, NIST)下的其中一个研究所——信息技术实验室(Information Technology Laboratory, ITL)——提供。

>The Information Technology Laboratory (ITL) is one of NIST’s six research laboratories that focuses on IT measurements, testing, and standards, and is a globally recognized and trusted source of high-quality, independent, and unbiased research and data. As a world-class measurement and testing laboratory encompassing a wide range of areas of computer science, mathematics, statistics, and systems engineering, ITL’s research program supports NIST’s mission to promote U.S. innovation and industrial competitiveness by advancing measurement science, standards, and related technology.

这本指南详细地阐述了探索性数据分析(Exploratory Data Analysis, EDA)的方法论和哲学。

> Exploratory Data Analysis (EDA) is an approach/philosophy for data analysis that employs a variety of techniques (mostly graphical) to
>
> 1. maximize insight into a data set;
> 2. uncover underlying structure;
> 3. extract important variables;
> 4. detect outliers and anomalies;
> 5. test underlying assumptions;
> 6. develop parsimonious models; and
> 7. determine optimal factor settings.

EDA所研究的内容就是如何更好地开展数据分析：

>  The EDA approach is precisely that--an approach--not a set of techniques, but an attitude/philosophy about how a data analysis should be carried out.

EDA的哲学：

> EDA is not identical to statistical graphics although the two terms are used almost interchangeably. Statistical graphics is a collection of techniques--all graphically based and all focusing on one data characterization aspect. EDA encompasses a larger venue; **EDA is an approach to data analysis that postpones the usual assumptions about what kind of model the data follow with the more direct approach of allowing the data itself to reveal its underlying structure and model.** EDA is not a mere collection of techniques; **EDA is a philosophy as to how we dissect a data set; what we look for; how we look; and how we interpret.** It is true that EDA heavily uses the collection of techniques that we call "statistical graphics", but it is not identical to statistical graphics per se.

总之，这本指南是一个很好的学习资料。

在指南的第四章介绍了数据的过程建模(Process Modeling)，
