下图所示是一个使用理想的SPDT开关实现的Buck电路，能够实现降低DC输入电压的功能 [XX, previous blog]：

![image-20230602122148995](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602122148995.png)

随着SPDT开关位置的变化，其输出电压波形$v_s(t)$如下图所示：

![image-20230602122415217](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602122415217.png)

在实际中，这个理想的开关通常使用半导体器件（例如晶体管或二极管）实现。晶体管或者二极管被控制系统控制导通或阻断，以实现理想开关开合的功能。上图中：

- 开关的频率$f_s$等于开关周期开关周期$T_s$的倒数，其范围通常为$1\ \mathrm{kHz}\sim1\ \mathrm{MHz}$，这取决于半导体器件的开关速度；
- 占空比$D$是开关在开关周期$T_s$内处于位置1处的时长占比，取值为$(0,1)$；另外，定义$D'=1-D$，表示开关在开关周期$T_s$内处于位置2处的时长占比.

该开关可以减少电压的直流分量，并根据傅里叶分析有可知，$v_s(t)$的直流分量可以使用其平均值表示，即：
$$
\langle v_s\rangle=\dfrac1{T_s}\int_0^{T_s}v_s(t)\mathrm{d}t=\dfrac1{T_s}(DT_sV_g)=DV_g
$$
为了抑制$v_s(t)$中开关频率及其谐波的分量，可以在输出后添加一个低通滤波器：

![image-20230602141558202](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602141558202.png)

> ==低通滤波器的分析XXXXXX==

