---
layout: single
title: Common Definitions for Circuit Breaker Diagnosis
date: 2023-02-04 10:47:43 +0800
categories: 
 - Circuit Breaker
---

# Major Failure (MF), Minor Failure (mF), and Defect

很多关于断路器故障诊断的文献都对断路器的重大故障（Major Failure）和轻微故障（Minor Failure）做出了定义。

例如，CIGRE WG 13.06在1995年发表的关于断路器故障的第二次调研报告 [1] ：

> **Major Failure (MF)**: Complete failure of a circuit breaker which causes the lack of one or more of its  **fundamental functions**. 
> *NOTE*: A major failure will result in an immediate change in the system operating conditions, e.g. the backup protective equipment being required to remove the fault, or will result in mandatory removal from service for non-scheduled maintenance (intervention required within 30 minutes).  
>
> **Minor Failure (mF)**: Failure of a circuit-breaker other than a major failure or any failure, even complete, of a constructional element or a subassembly which does not cause a major failure of the circuit-breaker.

IEEE Std C37.10-2011 [2]：

> **Major Failure**: Failure of a circuit breaker that causes the termination of one or more of  its **fundamental functions**, **which necessitates immediate action**. 
> *NOTE*: A major failure will result in an immediate change in system operating condition; e.g., the backup protective equipment being required to remove the fault, or will result in mandatory removal from service for non-scheduled maintenance (intervention required within 30 min).
>
> **Minor Failure**: Any failure of a part of a sub-assembly that does not cause a major failure of a circuit breaker.

以及在该标准中提到的CIGRE WG A3.06对于两者的定义：

> CIGRE WG A3.0 defines a switchgear **major failure** as “failure of a switchgear and control gear which causes the cessation of one or more of its **fundamental functions**. A major failure will result in an immediate change in the system operating conditions, e.g., the backup protective equipment will be required to remove the fault, or will result in mandatory removal from  service within 30 minutes for unscheduled maintenance.”
>
> CIGRE WG A3.06 defines **minor failure** as “failure of an equipment other than a major failure or any failure, even complete, of a constructional element or a sub-assembly which does not cause a major failure of the equipment.”

还有Micheal在其博士毕业论文中使用的定义 [3] （引用自文献 [4] ）：

> **Major failure**, defined as "failure of a circuit breaker which causes the cessation of one or more of its **fundamental functions**."
>
> **Minor failure**, defined as "any failure of a constructional element or a subassembly which does not cause a major failure of the circuit breaker"

这些文献中使用的定义都是类似的，即认为如果一个故障导致断路器丧失了fundamental functions，就认为这个故障是MF；除了MF故障之外的**任何**故障都是mF.

那么，什么是断路器的fundamental functions？这些文献中都没有提及。但是在CIGRE的报告 [1] 中列出了一些MF和mF的一些特征。例如，MF有：

![image-20230203234433858](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230203234433858.png?raw=true)

> - Does Not Close (Open) on Command
> - Closes (Opens) Without Command
> - Does Not Make (Break) the Current
> - Fails to Carry the Current
> - Breakdown to Earth
> - Breakdown Between Poles
> - Breakdown Across Open Pole (Internal or External)
> - Locking in Open or Closed Position
> - Others

以及mF：

![image-20230203234542165](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230203234542165.png?raw=true)

mF的类型应该有很多，因为使用不同技术的断路器所发生的故障有很大的差异。

除了MF和mF的定义，有些资料还定义了断路器的另一种failure type category，即Defect. 例如标准 [2] 的一个NOTE就提到：

> IEC also provides a definition for a **third failure type category**: A **defect** is an “imperfection in the state of an item (or inherent weakness) which can result in one or more failures of the item itself or of another item <u>under the specific service or environmental or maintenance conditions</u> for <u>a stated period of time</u>.” **Defects are, however, not included in the survey**.

Defect比mF的严重程度更轻微，用得也比较少。有的时候可能与mF也不做严格的区分，比如在报告 [1] 出现的一个表格中：

![image-20230203235756000](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230203235756000.png?raw=true)

就没有刻意地区分两个概念。

<br>

# Failure Mode

IEEE Std C37.10-2011 [2] 对于failure mode的定义：

> **Failure Mode**: The manner in which failure occurs; generally categorized as electrical, mechanical, thermal, and contamination.

这种对于failure mode的划分方式不太常见，也不太统一。比如说在这篇标准中，仅仅是在开头的Definitions对Failure mode进行了定义，后文并没有进行使用；在其他的文献中也经常用于指代具体的故障，例如文献 [1] 中：

![image-20230204104529845](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230204104529845.png?raw=true)

和文献 [5]：

![image-20230204104804969](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230204104804969.png?raw=true)

<br>

**References**

[1] Fletcher, P. L., and W. Degen. "A summary of the final results and conclusions of the second international enquiry on the reliability of high voltage circuit-breakers." (1995): 24-30.

[2] "IEEE Guide for Investigation, Analysis, and Reporting of Power Circuit Breaker Failures," in *IEEE Std C37.10-2011 (Revision of IEEE Std C37.10-1995)* , vol., no., pp.1-59, 30 Dec. 2011, doi: 10.1109/IEEESTD.2011.9044885.

[3] Stanek, Michael. *Model-aided diagnosis for high voltage circuit breakers*. Diss. ETH Zurich, 2000.

[4] International Electrotechnical Commission: "High-voltage alternating current circuit-breakers - Guide for maintenance." *IEC Technical Report* 1208, 1992-12.

[5] [Microsoft Word - Final WG A3_12 Brochure Report.doc (cigreindia.org)](https://cigreindia.org/CIGRE Lib/Tech. Brochure/319 Circuit breaker control failures CB Control systems.pdf).





