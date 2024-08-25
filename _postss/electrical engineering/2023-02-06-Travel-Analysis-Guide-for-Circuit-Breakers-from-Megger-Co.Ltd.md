---
title: Travel Analysis Guide for Circuit Breakers from Megger Co.Ltd
categories: 
 - Electrical Engineering
tags:
 - Circuit Breaker
date: 2023-02-06 19:44:31 +0800
last_modified_at: 2024-07-17 12:26:55 +0800
---

本博客学习[Megger公司](https://megger.com/)技术文章：[*Circuit Breaker and Transducer: Where do I connect?*](https://uk.megger.com/support/technical-library/application-notes/circuit-breaker-and-transducer-where-do-i-connect) ，该文章主要讨论的是断路器的Travel analysis.

# Abstract

Time analysis和Travel analysis是重要的用于判断断路器运行状态的试验。

> Time and travel analysis is the most important test used to determine the correct operation of a circuit breaker.

大多数技术人员都会进行timing measurements，但是由于实施起来非常复杂，travel analysis（AKA motion measurements）经常会被忽略。实际上，motion measurements是routine testing and maintenance中一个重要环节。

> Although the majority of technicians perform timing measurements; travel analysis, or motion measurements, are often ignored. The motion measurement of the contacts and mechanism in circuit breakers provide a variety of important information <u>when performing routine testing and maintenance</u>; however it is a practice that is marginalized due to its <u>apparent difficulty and complexity</u>.

绕过motion measurements会导致断路器的灾难性故障：

> Bypassing this measurement and its results can lead to a catastrophic failure in the circuit breaker.

这篇application note用于：

（1）enable the reader to have a better understanding of **where to install** the transducer；

（2）**how to properly set up** the test plan；

（3）**give guidance for instances** where the manufacturer provides a minimal amount of data on travel analysis setup.

<br>

# Introduction

断路器可以定义为是"A mechanical switching devices"，而time and travel analyzer就被用于评估断路器的operating characteristic，进而辅助判断断路器的mechanical switching function是否正常运行。

> A circuit breaker is defined as “**A mechanical switching device**” and the way to determine if the mechanical switching function is working correctly is to hook up a time and travel analyzer to evaluate the operating characteristics of the circuit breaker.

在bulk oil circuit breakers盛行的年代，人们一定会进行travel measurements。但这些年，由于停机时间不足、维修人员不足、以及transducer安装复等原因，travel measurements开展得越来越少。原本完整的time and travel measurements被内容较少的contact timing measurement所代替，或者减少到只进行first trip testing. 

> When bulk oil circuit breakers were the prevalent technology in substations, travel measurements were performed without question. Over the years, because of various reasons such as lack of outage time, lack of maintenance personnel, and the complexity of hooking up a transducer to the circuit breaker, travel measurements are being performed less and less. Time and travel measurements have been replaced with just contact timing or reduced to solely first trip testing.

CIGRE WG A3.06 于2012年发布的一项最新研究发现：断路器50%的重大故障（MF）是由operating mechanism造成的，30%是由electrical control and auxiliary circuits造成的。

> A recent study by CIGRE working group A3.06 released in 2012 found that 50% of the major failures in a circuit were due to the operating mechanism and 30% were due to the electrical control and auxiliary circuits.

虽然开展的Contact timing和first trip test很重要，但是它们不能完整地测试mechanism的operating characteristics；因此，如果想要确定断路器的真实健康状况，人们就不能忽略travel measurements。

> While contact timing and first trip are important tests and should be performed, they will **not fully** test the operating characteristics of the mechanism; therefore neglecting travel measurements should not be standard practice if the true health of the circuit breaker is to be determined.

<br>

# Basic measurements made with the transducer

虽然transducer可以安装在断路器的不同位置用于测试不同部件的运动情况（例如减震器dashpot），但是motion transducer的主要应用是测量the motion of the main/arcing contacts.

注：main contacts和arcing contacts分别指的是主触头和弧触头，主触头存在于所有型号的断路器中；而弧触头主要用于SF6断路器中，它们的作用是不一样的："...The main contacts conducts the normal operating currents and the arcing contacts are used to take the load off the main contacts when the CB opens and closes."。[1] 
{: .notice--primary}

> Although the transducer can be attached to the circuit breaker to determine the travel of different parts of its components such as the dashpot, the primary application of a motion transducer is to measure the motion of the main/arcing contacts in the circuit breaker.

Motion transducer可以安装在断路器的不同部件上，比如：1）直接安装在主触头的拉杆上；2）直接安装在操动或传动机构上；3）连接到辅助开关上。

> The transducer can be hooked to many different parts of the circuit breaker, <u>directly to the pull rod of the main contacts</u>, <u>directly to the mechanism</u>, <u>somewhere on the linkage in between or even to an auxiliary switch</u>.

我们可以从transducer测出的结果中得到很多有用的parameters，其中最重要的measurements是断路器的stroke（实际上所有其他的参数都可以由stroke中得到）。

Stroke定义的是触头所走过的整个行程：

> The **stroke** is defined as the **total travel distance** of the contacts from resting position in one state, e.g. Closed, to the resting position in the other state i.e. Open or vice versa.

断路器的制造商通常会推荐motion transducer的安装位置，技术人员采取的最明智的做法就是将motion transducer安装在这些位置上；如果无法直接将motion transducer与contacts相连，则可以使用multiplication factors进行矫正。

> It is imperative that one is diligent in connecting the transducer to the **manufacturer’s recommended attachment point** on the circuit breaker and correcting for any **multiplication factors** if a direct connection to the contacts cannot be made.

注意，为了trend the results，技术人员至少要保证在进行periodic maintenance时，用于测量stroke的transducer的位置是一致的 。

> At the very least the technician must be consistent in measuring the stroke through periodic maintenance in order to trend the results.

另外，对于三相断路器：如果三相共用一个操动机构（gang operated），则只需要一个transducer即可；如果是三相分别采用一个操动机构，则每个操动机构都需要一个transducer。

> If the circuit breaker is gang operated i.e. it has one mechanism operating all three phases then **only one transducer** is needed, if the circuit breaker has separate operating mechanisms for each phase, then **an individual transducer** should be used for each mechanism.

一旦确定了断路器的Stroke，技术人员就可以计算出travel曲线不同区域的触头速度。其中最常用的用于计算速度的区域是arcing zone。

> Once the stroke of the circuit breaker is determined you can derive the velocity of the contacts in different regions of the travel. The most common region to measure velocity is during the **arcing zone** of the circuit breaker where it is actually interrupting or clearing the fault.

有时候，我们可以计算travel curve的damping zone区域（或者是damping zone内两个预定义点之间的时间）的速度以计算断路器的damping。

> Occasionally damping is also measured on the travel curve by calculating the velocity in the damping zone or the time between two predefined points on the travel curve in the damping zone. 

根据travel curve，我们还可以计算Penetration（or contact wipe）。Penetration定义为：

> By observing the closing time along with the travel measurement the **penetration or contact wipe** can be determined, <u>this is how far the contacts are engaged</u>. **Penetration** is the length measured from <u>initial contact touch</u> to the <u>final resting position after the operation</u>. 

Overtravel 定义为：

> Overtravel is measured directly from the travel curve and is **the maximum displacement past the resting position** that the contacts reach during the operation.

同样地可以定义Rebound：

> **Rebound** is **measured from minimum displacement**, after the maximum displacement (Overtravel), **to the final resting position** of the contacts.

由travel curve确定的（1）Stoke，（2）Penetration（or contact wipe），（3）Overtravel，和（4）Rebound：

![image-20230205162356712](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230205162356712.png?raw=true)

<br>

# Types of transducers

用于测量contacts运动的transducer有两种类型：linear transducer或者rotary transducer. Linear transducer通常测量的是长度值，单位一般是英寸（inches）或者毫米（millimeters）；而rotary transducer测大多量的是角度，单位是通常是度（degrees），之后必须转换为长度单位。

> There are two types of transducers used to measure the contacts of the circuit breaker, linear or rotary. A **linear transducer** will measure a <u>value of length</u> typically in either <u>inches</u> or <u>millimeters</u> whereas a **rotary transducer** will measure a <u>value of angle</u>, typically <u>degrees</u>, which then must be converted to inches or millimeters.

虽然这些传感器的测量原理有所差异，但是它们通常都会输出模拟量或者数字量。

> There are various designs of transducers such as resistive, optical, magnetic etc. but they generally give an analog or digital output.

Linear transducer通常具有不同的量程，从25 mm或者更少（通常用于真空断路器），一直到1000 mm或者更多（通常225-300 mm用于SF6 dead tank circuit breakers；500-600 mm用于bulk oil circuit breakers）。

> Linear transducers are available in a wide variety of lengths ranging from 25 mm or less, commonly used for vacuum circuit breakers, all the way up to 1000 mm or more, typical
> lengths are from 225-300 mm for SF6 dead tank circuit breakers and 500-600 mm for bulk oil circuit breakers.

首次设置motion measurements时，我们需要选择合适的传感器类型。

虽然需要断路器允许我们使用各个类型的transducer，但是制造商通常会给出一些推荐。我们最好使用制造商指定的attachment point，transducer type和conversion factor（间接测量时使用，rotary transducer会用到，linear transducer也会用到，只要是间接测量就会使用）.

> <u>When first setting up for motion measurements</u>, the type of transducer to be used, rotary or linear, <u>must be selected</u>.
>
> Although a lot of breakers allow you to use either type of transducer, the <u>manufacturer generally will specify a preference</u> and it is always recommended to use the manufacturer’s specified <u>attachment point</u>, <u>transducer type</u>, and <u>conversion factor</u> (if needed).

⚠⚠⚠注意！！！在安装和连接tranducer时，一定要确保断路器处于open position，确保mechanism中没有存储的能量（可以在安装前释放掉mechanism中的所有能量），确保安装了用于block operation的maintenance pin，最后断开控制电路的电源。

无论transducer安装在哪里，transducer本身、mounting bracket或travel rod（如果使用）的任何部分都不得位于断路器的任何移动部件的直接路径中，否则会损坏传感器或其附件。

> Caution: Before connecting the transducer, always ensure that the circuit breaker is in the open position, make sure no energy is stored in the mechanism, or if it is impractical to discharge all the energy in case of some pneumatic or hydraulic mechanisms, make sure the maintenance pin that blocks operation is set, finally de-energize the power going to the control circuitry. No matter where the transducer is placed, no part of the transducer, mounting bracket, or travel rod if used, must be in the direct path of any moving parts of the circuit breaker that will cause damage to the transducer or its accessories.

如果使用linear transducer，那么需要保证其量程可以涵盖在合闸或者分闸过程中可能遇到的total travel distance. 

> If a linear transducer is used it must be of suitable length to cover the total travel distance the transducer will encounter, including overtravel, on both close and open operations.

如果不确定这一点，可以进行进行一些探索性地尝试，例如：

> If unsure of whether the transducer is of suitable length, a common practice is to attach the transducer in one position e.g. closed, then detach the transducer and operate the circuit breaker so it changes state. Now that the circuit breaker is in the opposite position i.e. open, re-attach the circuit breaker to see if it is of suitable length.

除了量程之外，transducer的size也是我们必须所考虑的问题：

> Once a transducer of adequate length is selected, the **next consideration in size** is to make sure the transducer **will fit in the space provided**.

## Two Types of Measurements Made with a Linear Transducer: Direct and indirect Measurement 

使用Linear transducer有两种的测量方式，一种是直接测量，即transducer或者linkage rod直接于moving contacts相连。“直接测量”通常用于bulk oil circuit breakers，minimum oil breakers，大多数的vacuum circuit breakers和一些dead tank SF6 circuit breakers.

> There are two types of measurements made with a linear transducer, the first is a **direct measurement** as in Figure 2, where the transducer or linkage rod is connected directly to the moving contacts; direct measurements are common in bulk oil circuit breakers, minimum oil breakers, most vacuum CBs and some dead tank SF6 circuit breakers.

![image-20230205172253489](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230205172253489.png?raw=true)

直接测量的缺点是：有时候难以找到合适的mounting bracket，并且安装时非常困难；

优点是：actual stroke of the transducer就等于actual stroke of the contacts，不需要转换，获得的parameters都是direct representative，不会因为gears，linkages或者mechanical play（机械间隙）的存在而导致转换误差。

> Although finding a suitable mounting bracket and correctly mounting the transducer can be difficult at times, this method is beneficial because the actual stroke of the transducer is equal to the actual stroke of the contacts, therefore no conversion factor is needed and all parameters measured with the transducer are direct representatives of the motion of the contacts in the circuit breaker; the motion isn’t distorted by any gears, linkages or mechanical play of the interconnections.

第二种测量方式是间接测量，即transducer没有直接与moving contacts相连，而是与moving contacts联动的结构相连，例如mechanism或者interconnecting linkage. 

> The second type of measurement with a linear transducer is an **indirect measurement**, where the transducer is not connected directly to the moving contacts but to a part of the circuit breaker that is connected to the moving contacts such as the mechanism or interconnecting linkage.

![image-20230205173623334](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230205173623334.png?raw=true)

当使用间接连接的测量方式时，travel of transducer可能等于也可能不等于travel of the main contacts. 如果不相等，则需要使用**conversion factor（or ratio）**以获得正确地stroke length和travel parameters。

> When this type of connection is used, the travel of the transducer may or may not be equal to the travel of the main contacts. If the travel of the transducer is different, a conversion factor or ratio should be used in order to obtain the correct stroke length and travel parameters of the circuit breaker. 
>
> For example, 80 mm of transducer stroke can be equivalent to 120 mm of contact stroke so a multiplication factor of 1.5 shall be used.

## Two types of Conversion of Measurements Made with a Rotary Transducer

Rotary Transducer测得量的单位是度（degrees），有时是弧度（radians），最终都转换为长度单位

> When a rotary transducer is used, the measured quantity is in degrees, or occasionally radians, and is then converted to a unit of length.

因此很明显，使用Rotary Transducer测量触头运动的方式都属于间接测量。但是，转换的方式有两种。第一种是**constant conversion**，即在触头运动的整个过程中，1 degree等于一个确定的长度值，这种测量方式在interconnecting parts比较少且比较简单时经常使用。

> There are two types of conversions, the first is a **constant conversion** where **one degree is equal to a certain value of length throughout the entire travel of the contacts**. This is common where the mechanical linkage is simple with few interconnecting parts.

而当断路器的连接部件非常复杂时，在触头运动的整个过程中，弧度和长度的比值可能不是常数，例如在前10 degrees时，1 degree可能对应1.5 mm；而在下一个10 degrees中，1 degree可能对应2.5 mm。在这种转换方式下，我们就需要使用conversion table.

> When the linkage is more complicated, the ratio of the angle to length **may not be constant** throughout the total travel of the contacts i.e. one degree might equal one and a half millimeters for the first ten degrees then for the next ten degrees of travel, one degree might equal two and a half millimeters. In these cases a **conversion table** must be used to account for the varying values.

Rotary transducer的优点是：1）体积相对较小，2）配件少，适用于多种不同类型的断路器。缺点是：我们需要知道conversion factor或者conversion table. 如果说明书中没有提供conversion factor（or table），则需要联系断路器制造商。

> Rotary transducers have the advantage of being relatively small and with a few accessories one kit can hook up to many different styles or types of circuit breakers. 
>
> The disadvantage of the rotary transducer is that you need to know the conversion factor or table in order to calculate the correct parameters of your circuit breaker. 
>
> If the conversion factor or table is not provided in the manual, the breaker manufacturer should be contacted.

Rotary transducer最常用于live tank SF6 circuit breakers，但是也用于一些类型的dead tank SF6 breakers，bulk oil circuit breakers和generator circuit breakers.

> Rotary transducers are most common on <u>live tank SF6 circuit breakers</u> but are also used on certain types of <u>dead tank SF6 breakers</u>, <u>bulk oil circuit breakers</u> and <u>generator circuit breakers</u>.

下面是使用Rotary transducer的例子：

![image-20230205180710188](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230205180710188.png?raw=true)

![image-20230205180756918](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230205180803122.png?raw=true)

<br>

# Speed Calculation

当使用合适的transducer直接测量到（或间接测量到）触头的运动后，大多数parameters都会被自动地计算出。但是有一个例外，即velocity measurement. 

> Once the proper transducer, and conversion factor if needed, is selected, most of the parameters such as stroke, overtravel, rebound, penetration etc. will come out of the measurements automatically.
>
> One of the exceptions to this is the velocity measurement.

为了计算出velocity，我们必须在测得的travel curve上挑选出一段区间。因此，我们需要挑选出两个点。

> In order to calculate the velocity the analyzer must be told where on the curve velocity should be measured.
>
> Two different points on the travel curve are selected and the average velocity between these two points is calculated.

这些点可以参考travel curve上许多不同的点，例如distance below close position，distance above open position，percentage of stroke，或者distance below upper point等等。

> These points can reference many different points on the curve such as distance below close, distance above open, percentage of stroke, distance below upper point etc.

另一类常用的做法（也是各种文献最常采用的方式）是将event（如contact touch或者contact separation）作为参考点。

> Another common reference point is an event during the timing e.g. contact touch or contact separation.

无论采取何种方式确定区间，都是从两个最主要的方面进行考虑的：（1）velocity是在travel curve上的一段线性区间中进行计算的；（2）速度是在arcing zone进行计算。出于这种考虑，我们通常会采取后一种确定calculation points的方式，将其确定在contact touch（刚合点）或者contact separation（刚分点）附近。

> The two most important factors that influence the selection of the speed calculation points are that the **velocity is measured on a linear portion of the travel curve** and that **it is measured during the arcing zone,** therefore the calculation points are generally near **contact touch** on the close and **contact separation** on the open.

一种最常见的错误的计算velocity的方式是将stroke直接与total time相除。由此计算出的速度并不是arcing zone内的平均速度，而是total travel内的平均速度。在这种计算方式下，travel初始阶段的加速过程和末尾阶段的减速过程会掩盖掉arcing zone内的instantaneous velocity，因此这种方式并不合理。

> A common misconception for calculating velocity is to take the total travel distance (stroke) and divide it by the total time it takes for the contacts to reach the fully closed position, this will not determine the velocity during the arcing zone but the average velocity for the total travel. In this case the acceleration at the beginning of the travel and deceleration at the end will mask the instantaneous velocity around the arcing zone.

但另一方面，speed calculation points的选择并不是一成不变的，而是会根据断路器制造商的不同，断路器类型的不同，操动机构类型的不同而发生改变。因此，想要获得更详细的信息，我们需要联系断路器的制造商。

> A common misconception for calculating velocity is to take the total travel distance (stroke) and divide it by the total time it takes for the contacts to reach the fully closed position, this will not determine the velocity during the arcing zone but the average velocity for the total travel. In this case the acceleration at the beginning of the travel and deceleration at the end will mask the instantaneous velocity around the arcing zone.

![image-20230206193141371](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230206193141371.png?raw=true)

如果这些信息都是未知的，则推荐contact touch和其前10 ms前的点作为close calculation points；将contact separation和其后10 ms处的点作为作为open calculation points。

<br>

**Reference**

[1] [Circuit breaker testing guide - Megger](https://uk.megger.com/support/technical-library/technical-guides/circuit-breaker-testing-guide).



