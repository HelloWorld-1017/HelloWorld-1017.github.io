---
title: Caption Images by a Pretrained Image-Captioning Model
categories:
 - Python
 - Machine Learning
tags:
 - Python PyTorch
 - <i>Deep Learning with PyTorch</i>
 - Natural Language Processing
 - Computer Vision
date: 2024-07-28 19:10:54 +0800
last_modified_at: 2024-07-28 19:10:54 +0800
---

# Introduction to image-captioning model

The book, *Deep Learning with PyTorch* (Subchapter 2.3, *A pretrained network that describes scenes*), introduces an image-captioning model[^1], which can generate an English caption describing the input image:

<div class="quote--left" markdown="1">

... The model is trained on a large dataset of images along with a paired sentence description: for example, “A Tabby cat is leaning on a wooden table, with one paw on a laser mouse and the other on a black laptop.”

This captioning model has two connected halves. The first half of the model is a network that learns to generate “descriptive” numerical representations of the scene (Tabby cat, laser mouse, paw), which are then taken as input to the second half. That second half is a *recurrent neural network* (RNN) that generates a coherent sentence by putting those numerical descriptions together. The two halves of the model are trained together on image-caption pairs.

The second half of the model is called *recurrent* because it generates its outputs (individual words) in subsequent forward passes, where the input to each forward pass includes the outputs of the previous forward pass. This generates a dependency of the next word on words that were generated earlier, as we would expect when dealing with sentences or, in general, with sequences.

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407271620684.png" alt="image-20240727161845529" style="zoom:67%;" />

</div>

Briefly speaking, this image-captioning model looks like an end-to-end RNN trained on the basis of image(features)-caption(labels) data set (supervised training).

Above model, named ImageCaptioning.pytorch, can be obtained from the GitHub repo[^2]. It is a clone from Ruotian Luo’s repository[^3], and as said in the book, Luo’s model is an implementation of model NeuralTalk2[^4] by Andrej Karpathy.

<br>

# Make model inference

## Caption one image

To realized a model inference---like ResNet-101[^5] and CycleGAN[^6] introduced in the book---based on the pretrained model ImageCaptioning.pytorch, we should download the repository[^2]. After downloading, we could firstly have a glance at repository structure:

```powershell
tree /F
```

```
G:.
│  dataloader.py
│  dataloaderraw.py
│  eval.py
│  eval_utils.py
│  opts.py
│  README.md
│  train.py
│
├─data
│  ├─FC
│  │      fc-infos.pkl
│  │      fc-model.pth
│  │
│  └─imagenet_weights
│          resnet101a.pth
│          resnet101b.pth
│
├─misc
│      resnet.py
│      resnet_utils.py
│      utils.py
│      __init__.py
│
├─models
│      Att2inModel.py
│      AttModel.py
│      CaptionModel.py
│      FCModel.py
│      OldModel.py
│      ShowTellModel.py
│      __init__.py
│
├─scripts
│      convert_old.py
│      prepro_feats.py
│      prepro_labels.py
│
└─vis
    │  index.html
    │  jquery-1.8.3.min.js
    │
    └─imgs
            dummy
```

As can be seen, there’s a `data` folder in root folder, and at this point we can new a subfolder `images` in it. Then, we should put images to be captioned in `images` folder (or directly put images under `data` folder). For the first try, I only put one image, i.e. `zebra.jpg`[^6], in `images`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407270944781.jpg" alt="zebra"  />

 After that, execute the command:

<div id="command-1"></div>

```powershell
python eval.py --model .\data\FC\fc-model.pth --infos_path .\data\FC\fc-infos.pkl --image_folder .\data\images\ --dump_images 0 --batch_size 1
```

By the way, to make it run, I install two packages, i.e. `h5py`, `scikit-image`. When installing `scikit-image`, an error, `ERROR: THESE PACKAGES DO NOT MATCH THE HASHES FROM THE REQUIREMENTS FILE.`, occurs due to unstable Internet connection[^11].
{: .notice--primary}

then I have:

<div id="first-result"></div>

```
DataLoaderRaw loading images from folder:  .\data\images\
0
listing all images in directory .\data\images\
DataLoaderRaw found  1  images
G:\...\ImageCaptioning.pytorch-master\models\FCModel.py:147: UserWarning: Implicit dimension choice for log_softmax has been deprecated. Change the call to include dim=X as an argument.
  logprobs = F.log_softmax(self.logit(output))
G:\...\ImageCaptioning.pytorch-master\models\FCModel.py:123: UserWarning: Implicit dimension choice for log_softmax has been deprecated. Change the call to include dim=X as an argument.
  logprobs = F.log_softmax(self.logit(output))
image 1: a group of zebras standing in a field
evaluating validation preformance... -1/1 (0.000000)
loss:  0.0
```

where message on 9th line shows that predicted caption for the image is “a group of zebras standing in a field”. 

The result is so-so, not that accurate, but before further discussing model performance, some points about the [inference command](#command-1) should be firstly introduced.

## Option `batch_size`

At first, option `batch_size` specify the batch size while making model inference. Its default value is `10`, and if the number of remained images is less than `10`, script will automatically repeat images from the beginning in order. For example, if we don’t specify value for this option

```powershell
python eval.py --model .\data\FC\fc-model.pth --infos_path .\data\FC\fc-infos.pkl --image_folder .\data\images\ --dump_images 0
```

then we have results:

```
... ...
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
image 1: a group of zebras standing in a field
evaluating validation preformance... -1/1 (0.000000)
loss:  0.0
```

Batch size influence the model inference speed in a way---if the batch size is too small, total inference time will become long. However, if the total number of image to be tested is relatively small, it’s better to specify a suitable value, as we set `--batch_size 1` above.

## Option `dump_images`

In the [command](#command-1), option `dump_images` determines “whether dump images into vis/imgs folder for vis”: value `1` (default) means “yes”, `0` means “no”. However, on Windows systems, some errors will occur if we choose “yes”:

<div id="command-2"></div>

```powershell
python eval.py --model .\data\FC\fc-model.pth --infos_path .\data\FC\fc-infos.pkl --image_folder .\data\images\ --batch_size 1
```

```
... ...
cp ".\data\images\zebra.jpg" vis/imgs/img1.jpg
'cp' 不是内部或外部命令，也不是可运行的程序
或批处理文件。
image 1: a group of zebras standing in a field
evaluating validation preformance... -1/1 (0.000000)
loss:  0.0
```

where printed information `cp ".\data\images\zebra.jpg" vis/imgs/img1.jpg` states that `cp` is not a valid command, although dump images or not doesn’t influence model inference. This error is caused by command `cp` is not valid on Windows systems, we should use `copy` function instead[^7]. 

Another point would incur error is the path delimiter `/`  --- we should replace it with `\` on Windows.

In order to avoid both errors, we should modify the code snippet in file `.\eval_utils.py`:

```python
            # ...
    		if eval_kwargs.get('dump_images', 0) == 1:
                # dump the raw image to vis/ folder
                cmd = 'cp "' + os.path.join(eval_kwargs['image_root'], data['infos'][k]['file_path']) + '" vis/imgs/img' + str(len(predictions)) + '.jpg' # bit gross
                print(cmd)
                os.system(cmd)
            # ...
```

to:

```python
            # ...
    		if eval_kwargs.get('dump_images', 0) == 1:
                # dump the raw image to vis/ folder
                cmd = 'copy "' + os.path.join(eval_kwargs['image_root'], data['infos'][k]['file_path']) + '" vis\imgs\img' + str(len(predictions)) + '.jpg' # bit gross
                print(cmd)
                os.system(cmd)
            # ...
```

then rerun the [command](#command-2), we have:

```
... ...
copy ".\data\images\zebra.jpg" vis\imgs\img1.jpg
已复制         1 个文件。
image 1: a group of zebras standing in a field
evaluating validation preformance... -1/1 (0.000000)
loss:  0.
```

with no error any more.

However, I don’t know why and when there’s a need to dump images, so at last I decide to deactive this option as in the [command](#command-1).

## Change caption-printing format

As showed [before](#first-result), predicted image captions will be displayed in text like `image xx: xxxxxx`. If the number of images increases, it’s difficult to identify which image is image 1, image 2, or image 3 etc. So, still in `.\eval_utils.py` file, we can change:

```python
            # ...
            if verbose:
                print('image %s: %s' %(entry['image_id'], entry['caption']))
            # ...
```

to:

```python
            # ...
    		if verbose:
                print('\"%s\": %s' %(data['infos'][k]['file_path'], entry['caption']))
            # ... 
```

then rerun the [command](#command-1), we could get the result:

```
... ... 
".\data\images\zebra.jpg": a group of zebras standing in a field
evaluating validation preformance... -1/1 (0.000000)
loss:  0.0
```

on the host. More straightforward.

## Captioning multiple images

After above discussions, we could go further, captioning multiple images. I put 7 extra images, with different resolutions, in `.\data\images` folder:

<div id="multiple-images"></div>

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407272109504.png" alt="image-20240727210900379" style="zoom:67%;" />

and run the command:

```powershell
python eval.py --model .\data\FC\fc-model.pth --infos_path .\data\FC\fc-infos.pkl --image_folder .\data\images\ --dump_images 0 --batch_size 8
```

to get result:

<div id="multiple-captions"></div>

```
".\data\images\Camus.jpg": a man with a beard and a tie
".\data\images\horse.jpg": a person riding a horse on a beach
".\data\images\moon.jpg": a close up of a white and white plate
".\data\images\QingFengChuiFu.jpg": a couple of people standing on top of a lush green field
".\data\images\sunset.jpg": a flock of birds standing on top of a sandy beach
".\data\images\Tommy.jpg": a blurry photo of a blurry image of a person
".\data\images\YourName.jpg": a person is flying a kite in the sky
".\data\images\zebra.jpg": a group of zebras standing in a field
evaluating validation preformance... -1/8 (0.000000)
loss:  0.0
```

By the way, if the image to be tested has four channels, i.e. RGBA, an error will occur. We should convert it into three channels[^10].

<br>

# In closing

Look at those [images](#multiple-images) and their [corresponding captions](#multiple-captions), truth to be told, ability of the model is really limited. The book attribute it to “insufficient” training samples---the model didn’t ever seen images with certain content while training. But on the other hand, believe deep training, without too many rules, is fascinating and promising (and surely it is):

<div class="quote--left" markdown="1">

... it [caption `".\data\images\zebra.jpg": a group of zebras standing in a field` for image `zebra.jpg`] got the animal right, but it saw more than one zebra in the image. Certainly this is not a pose that the network has ever seen a zebra in, nor has it ever seen a rider on a zebra (with some spurious zebra patterns). In addition, it is very likely that zebras are depicted in groups in the training dataset, so there might be **some bias** that we could investigate. The captioning network hasn’t described the rider, either. Again, it’s probably for the same reason: **the network wasn’t shown a rider on a zebra in the training dataset.** In any case, this is an impressive feat: **we generated a fake image with an impossible situation, and the captioning network was flexible enough to get the subject right**. 

We’d like to stress that something like this, which would have been extremely hard to achieve before the advent of deep learning, can be obtained with under a thousand lines of code, with a general-purpose architecture that knows nothing about horses or zebras, and a corpus of images and their descriptions (the MS COCO dataset, in this case). **No hardcoded criterion or grammar---everything, including the sentence, emerges from patterns in the data.**

...

At the time of this writing, **models such as these exist more as applied research or novelty projects, rather than something that has a well-defined, concrete use**. The results, while promising, just aren’t good enough to use … yet. With time (and **additional training data**), we should expect this class of models to be able to **describe the world to people with vision impairment**, **transcribe scenes from video**, and perform other similar tasks.

</div>

See footnotes[^2][^3][^4], aforementioned three GitHub repos were created between 2016 and 2018 (creation time is obtained by GitHub REST API[^8][^9]), and the book was published on 2020[^1]. During that period, image-captioning models or some models like this, as the book says, hadn’t become mature products. However in recent years, LLMs, like ChatGPTs, more functional and user-friendly, are booming. Deeper network structure and more training data. 

<br>

**References**

[^1]: [Deep Learning with PyTorch](https://isip.piconepress.com/courses/temple/ece_4822/resources/books/Deep-Learning-with-PyTorch.pdf), Eli Stevens, Luca Antiga, and Thomas Viehmann, 2020, GitHub repository: [deep-learning-with-pytorch](https://github.com/deep-learning-with-pytorch/dlwpt-code), pp. 33-35.
[^2]: [deep-learning-with-pytorch/ImageCaptioning.pytorch: image captioning codebase in pytorch(finetunable cnn in branch "with_finetune";diverse beam search can be found in 'dbs' branch; self-critical training is under my self-critical.pytorch repository.)](https://github.com/deep-learning-with-pytorch/ImageCaptioning.pytorch), API: [https://api.github.com/repos/deep-learning-with-pytorch/ImageCaptioning.pytorch](https://api.github.com/repos/deep-learning-with-pytorch/ImageCaptioning.pytorch) (Created on 05 May, 2018; Last pushed on 03 July, 2024).
[^3]: [ruotianluo/ImageCaptioning.pytorch: I decide to sync up this repo and self-critical.pytorch. (The old master is in old master branch for archive)](https://github.com/ruotianluo/ImageCaptioning.pytorch), API: [https://api.github.com/repos/ruotianluo/ImageCaptioning.pytorch](https://api.github.com/repos/ruotianluo/ImageCaptioning.pytorch) (Ceated on 10 Feb. 2017; Last pushed on 05 Oct. 2023).
[^4]: [karpathy/neuraltalk2: Efficient Image Captioning code in Torch, runs on GPU](https://github.com/karpathy/neuraltalk2), API: [https://api.github.com/repos/karpathy/neuraltalk2](https://api.github.com/repos/karpathy/neuraltalk2 ) (Created on 20 Nov. 2015; Last pushed on 07 Nov., 2017).
[^5]: [Make A Deep Learning Model Inference based on the Pretrained ResNet-101 - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-26/15-58-39.html).
[^6]: [A Simple Example to Know about CycleGAN - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-27/11-27-16.html).
[^7]: [https://github.com/wangshub/wechat\_jump\_game/issues/20#issuecomment-768050579](https://github.com/wangshub/wechat_jump_game/issues/20#issuecomment-768050579).
[^8]: [Get GitHub Repository Information (in JSON Format) through REST API - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-06-28/00-19-15.html).
[^9]: [Three GitHub Repo Timestamps Obtained through REST API: `created_at`, `updated_at`, and `pushed_at` (including a simple introduction to ISO 8601) - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-28/16-03-22.html).
[^10]: [Convert 4D-array Image (with RGBA Channels) to Normal 3D-array Image by PIL - WHAT A STARRY NIGHT~](http://helloworld-1017.github.io/2024-07-29/11-37-06.html).

[^11]: [An Error Caused by Unstable Internet Connection when Installing Python Package: `ERROR: THESE PACKAGES DO NOT MATCH THE HASHES FROM THE REQUIREMENTS FILE.` - WHAT A STARRY NIGHT~](http://helloworld-1017.github.io/2024-07-28/19-48-44.html).
