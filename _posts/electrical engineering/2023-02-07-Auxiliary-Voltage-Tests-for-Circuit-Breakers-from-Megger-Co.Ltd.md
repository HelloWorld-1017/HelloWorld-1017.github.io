---
title: Takeaways from *Auxiliary Voltage Tests for Circuit Breakers* by Megger Co.Ltd
categories:
 - Electrical Engineering
tags: 
 - Circuit Breaker
date: 2023-02-07 11:36:27 +0800
last_modified_at: 2024-12-08 10:22:04 +0800
---

本博客学习Megger公司[^1]技术文章：*Auxiliary voltage tests of circuit breakers*[^2]，该文章主要讨论的是断路器的Auxiliary voltage tests of circuit breakers.
{: .notice--primary}

# Background

国际标准IEEE C37和IEC 62271都规定：当认证断路器时，需要对操动机构的**outer limit**进行测试。同时，在field test（现场试验）中重复进行其中的一些试验也是有价值的，一方面是确保断路器满足它的design specification（设计规范）；另一方面，这是试验同样可以揭露断路器潜在的问题。

<div class="quote--left" markdown="1">

Measurement of the **outer limits of the operating mechanism** is required by international standards such IEEE C37 and as IEC 62271, when certifying a circuit breaker (CB). 

Some of those tests are valuable to repeat in field tests, obviously to ensure that the CB fulfil its design specification, but those tests and some additional tests in similar spirit can also disclose potential future problems.   

</div>

其中最常见的试验是：auxiliary voltage试验（同样也可以改变其他形式的energy，例如液压和气压）。这篇技术文档就聚焦于auxiliary voltage试验：（1）讨论标准对于auxiliary voltage试验的要求，（2）整理相关术语，并（3）讨论在field tests中什么样的试验有重复的价值。

<div class="quote--left" markdown="1">

The most common is to vary the auxiliary voltage but it could also be other energy resources for example hydraulic and pneumatic pressure.   

This application note will focus of the auxiliary voltage, what the standard requires, sort out the terminology and what tests that are valuable to repeat in field tests.

</div>

<br>

# Operating Conditions

从断路器辅助电压的角度看，断路器具有nominal voltage operating condition（额定电压操动状态），并且只要操动电压在一个指定的范围内波动，断路器就能够动作。

<div class="quote--left" markdown="1">

Seen from the auxiliary voltage a CB has a nominal voltage operating condition and then tolerances
where the CB should operate within specified limits.

</div>

**由于大多数的辅助电压是由stationary battery system（固定电源系统）提供**，因此通常情况下，当操动电压大于额定电压时断路器都能够正常动作。当电池充满电时，它提供的电压值就高于额定操动电压；而当断电后，电池放电，电压值就会下降。因此，国际标准会要求under voltage test和over voltage test.

注：电池是一直供着电的，因此一般电源都是满电状态；当电池的供电电源断电后（即outage），电池才会因为一直待机而耗电。
{: .notice--primary}

注：stationary battery system是固定电源系统，与之相对的是portable power supply，即便携电源系统，后文会介绍两者的优缺点。
{: .notice--primary}

<div class="quote--left" markdown="1">

When the battery is fully charged it has a higher voltage than nominal and in case of an outage the batteries will discharge, and the voltage will drop. 

International standards therefore **require under and over voltage tests**.

</div>

<br>

# Energy

断路器操动机构中的线圈需要energy来energize，而energy来自于电流和电压，这就意味着operating time随着操动操动电压变化而变化。

![image-20230207003223866](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230207003223866.png?raw=true)

<div class="quote--left" markdown="1">

The coil requires a certain energy to operate and the energy in this case is built from both current and
voltage (Figure 1.) which means that the operating time will change with changed voltage.

</div>

当电池提供的电压高于额定电压时（in the upper region of the tolerance），断路器动作就更快，相反就更慢。但是，这两种状况都需要限制在time specification中。

<div class="quote--left" markdown="1">

High voltages, in the upper region of the tolerance, will provide high energy and the operating coil will react faster and obviously then with lower voltage, down to the minimum voltage level, provides lower energy and the operating time will be longer. 

Still both conditions need to be within time specification for the breaker. 

</div>

<br>

# Auxiliary voltage tests

如前文所述，电流和电压共同提供了能量，因此**在试验的过程中需要同时测量电流和电压值**，这是非常重要的。另外需要注意的是coil current并不在本文所讨论的范围内。

<div class="quote--left" markdown="1">

Both current and voltage builds the energy in this case, so it is important to measure both to get the
full picture. 

Coil current analysis is a science on its own and will not be focused on in this application
note.

</div>

根据标准IEC 62271，在试验中需要测量动作过程中整个的supply voltage.

Closing coil需要在85-110%的额定供应电压内激励（合闸过程）；opening coils需要在70-110%的额定供应电压范围内激励（分闸过程）。

<div class="quote--left" markdown="1">

With a reference to the IEC 62271 standard, it is required that the supply voltage is measured during
operation when performing tests, that closing coils shall operate correctly between 85% and 110% of
the rated supply voltage (AC or DC) and the opening coils shall operate between 70% DC (85% AC)
and 110% (AC or DC) of the rated supply voltage.  

</div>

并且需要注意的是，断路器在运行过程中，靠近upper limit的供应电压并不会引起任何的问题，因此在field tests中，通常更需要关注nominal或者minimum voltage等级下断路器的状况。

<br>

# Nominal voltage, station voltage, and portable power supply

最常见的断路器电压测试是在station voltage下进行测试。这种测试的优点是：这种测试不仅能够分析断路器，而且能够分析supply voltage circuit，断路器运行时的显著电压下降会影响操动时间，我们可以对此进行测试和矫正；缺点是：station voltage通常高于nominal voltage，并且不能够被调整。

<div class="quote--left" markdown="1">

Most common is to test the CB operation with the station voltage. 

The advantage to do that is that it’s not just the CB that is analysed but also the supply voltage circuit where significant voltage drops at CB operation will affect the time and therefore should be remedied. 

The disadvantage is that the voltage is what it is, normally higher than nominal voltage, and cannot be adjusted. 

</div>

因此，技术人员可以采用potable power supply设备代替station voltage进行测试，前者的电压值可以进行精确地调整；缺点是potable power supply比较重，并且在断路器动作过程中并不能保证当线圈被被激励时power supply是稳定的，会出现dip（尤其是在电压比较低时）.

![image-20230207010240166](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230207010240166.png?raw=true)

<div class="quote--left" markdown="1">

A portable power supply can be used instead of the station voltage where the advantage obviously is that one can adjust to exactly match the nominal voltage and of course other desired voltage levels. 

The disadvantage is that extra weight must be carried, and it is important that the power supply is stiff so there is no voltage dip when the coil is energized.

</div>

<br>

# Minimum voltage test

在标准中，Minimum voltage test是指：

<div class="quote--left" markdown="1">

With reference to the standards the minimum voltage test is a test at a certain percentage of the nominal voltage.

</div>

试验的目的是：

<div class="quote--left" markdown="1">

This test is to make sure that that the CB operates within the designed time in an undervoltage condition.

</div>

对于操动机构采用DC电源的断路器而言（最常见的情况），如前文所述，合闸和分闸线圈的供电范围是不一样的：

<div class="quote--left" markdown="1">

For DC operated CBs, which are most common, it is different voltage levels for the close and open coils where closing coil is 85% of nominal while the opening coil should operate down to 70% of nominal voltage.

</div>

之所以有差异，是因为断路器合闸所需要的能量更大，如果一个电压能够使断路器合闸，那么在这个电压下，断路器就能够正常分闸。换句话说，断路器在Close-Open operation中总是能够切断故障电流。

<div class="quote--left" markdown="1">

The difference comes from that if it is possible to close the CB it should be a safety margin for the CB to open.

In other words, the circuit breaker should always be able to break a fault current in a Close-Open operation.

</div>

除了根据标准执行minimum voltage operation完成测试外，由于施加的能量低于正常测试情况，因此该测试也更容易检测慢速断路器的问题，即润滑问题。

<div class="quote--left" markdown="1">

Besides fulfilling tests according to the standard by performing minimum voltage operation, it is also easier to detect problems with slow breakers, i.e. lubrication problems, since the energy applied is lower than in the normal test case.

</div>

<br>

# Pick-up voltage test

在国际标准中，并没有对pick-up voltage test（加压测试）进行规定，但是该测试仍然有价值。

Pick-up voltage test的操作步骤是：

<div class="quote--left" markdown="1">

The test is performed by applying voltage pulse **significantly under the minimum voltage**, then increase the voltage for the next pulse and continue like that **until the coil operates**. 

The voltage level when the coil operated is the **pick-up voltage** and this should be significantly under the minimum voltage level.

</div>

如果pick-up voltage接近minimum voltage level，则意味着断路器有可能在欠压情况下无法运行，因此如果发现断路器是这种情况，则应采取纠正措施：

<div class="quote--left" markdown="1">

If the pick-up voltage comes close to the minimum voltage level it means that there is risk that the CB will not operate in an undervoltage situation, so if the CB is found this way, corrective actions should be taken.

</div>

<br>

# Conclusion

<div class="quote--left" markdown="1">

To measure the station voltage is critical to perform an analysis of the coils in the CB operating
mechanism. 

There are advantages to use the station voltage to make sure the supply and wiring as well as the CB is in good condition.

International standards made for certifying CBs require tests which has both lower and higher voltage than the nominal voltage. 

However, in field tests more attention is given to voltages at nominal / station voltage and undervoltage level. 

Minimum voltage test is defined that the closing coils shall operate correctly between 85% and 110% of the rated supply voltage (AC or DC) and the opening coils shall operate between 70% DC (85% AC) and 110% (AC or DC) of the rated supply voltage.

Pick-up voltage test is not required by international standards but still the test gives some value to make sure there is a safety margin between the pick-up voltage and the minimum voltage.  

</div>

**References**

[^1]: [Megger](https://www.megger.com/en).
[^2]: [Auxiliary voltage tests of circuit breakers](https://uk.megger.com/support/technical-library/application-notes/auxiliary-voltage-tests-of-circuit-breakers).
