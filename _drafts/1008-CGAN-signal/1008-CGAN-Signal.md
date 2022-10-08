[Generate Synthetic Signals Using Conditional GAN - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/generate-synthetic-pump-signals-using-conditional-generative-adversarial-network.html).



在我目前看到的应用GAN生成数据的场景中，基本上都是使用GAN来生成图像或者震动信号。我觉得之所以这两种场景中应用比较多，是因为GAN生成的数据有很多噪声，比如XXX的原始图像和生成图像之间的对比：



可以看到，噪声是比较明显的。而在这两种场景之下，噪声的影响是不太重要的，或者可以通过后期处理掉的。比如图像有图像处理，而对于震动信号，我们主要关心它的频域特征和时频域特征，时域噪声中的影响是很小的，因此我们可以不太关心。

文章XX和XX分别介绍了MATLAB官方提供的三个关于GAN