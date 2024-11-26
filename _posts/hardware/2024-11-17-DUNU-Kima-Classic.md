---
title: Electrostatic Discharge of DUNU Kima Classic Wired Headphones
toc: false
categories:
 - Electrical Engineering
 - Hardware
 - Materials
tags:
 - Electromagnetism
date: 2024-11-17 17:57:52 +0800
last_modified_at: 2024-11-26 14:02:40 +0800
---

Last year I bought a wired headphones, DUNU Kima Classic[^1][^5], and a DAC/AMP (digital-to-analog converter/amplifier), DUNU DTC500[^4], to use together. They are good, but electrostatic problems always trouble me. That is, when I am listening musics via the headphones connecting with my PC (or laptop), at the moment that I am charging iPhone or iPad or moving them while charging (happens nearby), or that encountering static electricity on clothes, my ears will feel electric shock. Not that seriously, but I still feel very uncomfortable. I won’t encounter such problems if I use Bluetooth headphones, and, this kind of problems happen whether I use DAC or not, so I guess they are just caused by the headphones. As in the official website, DUNU Kima Classic features[^1]:

<div class="quote--left" markdown="1">

- High-Quality DLC[^2][^3] Diaphragm Dynamic Driver.
- **Strong Magnetic Circuit Featuring N52 Neodymium Magnets**.
- Resonance Chamber Dual-Cavity Design.
- High-Airflow Design Architecture.
- High-Density Metallic Alloy Shells.
- All-New Color Scheme.
- Improved Tuning For Cleaner & More Transparent Sound.
- Ergonomic & Comfortable Shell Design.
- **High-Purity Single-Crystal Copper Silver-Plated Cable.**
- Standard 0.78mm 2-pin Connectors.
- 3.5mm Single-Ended Termination Plug.

</div>

It’s actually a dynamic speaker[^6][^7][^9] (a.k.a electrodynamic speaker driver[^8]):

<div class="quote--left" markdown="1">

The dynamic speaker was invented in 1925 by Edward W. Kellogg and Chester W. Rice. When the electrical current from an audio signal passes through its voice coil—a coil of wire capable of moving axially in a cylindrical gap containing a concentrated magnetic field produced by a permanent magnet—the coil is forced to move rapidly back and forth due to Faraday's law of induction; this attaches to a diaphragm or speaker cone (as it is usually conically shaped for sturdiness) in contact with air, thus creating sound waves. In addition to dynamic speakers, several other technologies are possible for creating sound from an electrical signal, a few of which are in commercial use.[^7]

</div>

<div class="quote--left" markdown="1">

The most common type of driver, commonly called a dynamic loudspeaker, uses a lightweight diaphragm, or cone, connected to a rigid basket, or frame, via a flexible suspension, commonly called a spider, that constrains a voice coil to move axially through a cylindrical magnetic gap. A protective dust cap glued in the cone's center prevents dust, most importantly ferromagnetic debris, from entering the gap.

When an electrical signal is applied to the voice coil, a magnetic field is created by the electric current in the voice coil, making it a variable electromagnet. The coil and the driver's magnetic system interact in a manner similar to a solenoid, generating a mechanical force that moves the coil (and thus, the attached cone). Application of alternating current moves the cone back and forth, accelerating and reproducing sound under the control of the applied electrical signal coming from the amplifier.[^8]

</div>

Basically, it utilizes current flowing through voice coil to generate magnetic field to move diaphragm to produce sound. BTW, I’m not sure, but I feel its structure looks like a solenoid with a permanent magnet in a way.

I searched for some information online. I found that this kind of phenomena are called ESD[^10] (Electrostatic Discharge), and there are several reasons for ESD generation[^11]. And, it flows from ears to the metal parts of headphones, rather than the opposite direction[^12]:

<div class="quote--left" markdown="1">
**Question**

Is it possible to be shocked by static electricity through headphones / earphones?

**Answer**

Yes, it is possible. In a cold climate with low humidity, it is easy to build up a static charge on one's body.  As an example, wearing shoes with leather soles while shuffling one's feet on a wool carpet will often build up a substantial static charge. When a part of one's body touches an item that is grounded (like the screw on a switch wall plate), the body's static electricity will discharge to the grounded screw. The amount of electrical current in such a static discharge is not harmful, though the discharge itself can startle.

The cable that carries the audio signal from the headphone jack to the headphones / earphones has metallic wire inside. This wire is also a path to ground through which the static charge can travel. Though one's ears are touching the plastic parts of the headphones / earphones, there is metallic wire inside of the headphones / earphones. **A static charge often has a high enough voltage to leap from one's ear to the metal inside of the headphones /earphones, discharging the static electricity via the cable and into the device playing the audio signal, e.g., CD player or MP3 player.** 

It is important to note that such static discharges are "acts of nature" and do not indicate that one's headphones / earphones are defective. **Nor will the static discharge cause harm to the headphones / earphones.**

</div>

Reference[^12] says that ESD has no harm for headphones, but as article[^10], “ESD events can have a negative impact on the lifespan of electronic devices.” and there should be some ESD protection in headphone design. I tend to believe the latter. 

For my headphones, the equipped headphone cable, "High-Purity Single-Crystal Copper Silver-Plated Cable" (specifically, standard high-purity single-crystal copper silver-plated Litz cable[^13][^14]), can ensure sound quality in the transmission and reduce interference, but it can’t prevent ESD. I guess it may relate to aforementioned ear-to-headphone discharge direction.

<br>

**References**

- [DUNU Kima Classic Review](https://www.youtube.com/watch?v=6ct_DUt1RKo).

[^1]: [DUNU Kima Classic](https://www.dunu-topsound.com/product-page/copy-of-glacier).
[^2]: [Diamond-like carbon](https://en.wikipedia.org/wiki/Diamond-like_carbon).
[^3]: [KEFINE Klean 10mm DLC Diaphragm Dynamic Driver IEM](https://hifigo.com/products/kefine-klean?srsltid=AfmBOoo-iws4gaHCNIIoA61M2CMJs0P7x8wydcXkQM2_de6ZuIQsRO-I).

[^4]: [DUNU DTC 500 Portable USB DAC & AMP Headphone AMP Type-C To 3.5/4.4mm Outputs](https://hifigo.com/products/dunu-dtc500?srsltid=AfmBOoqagR3i73IJ6_b3pySXJbGI142VQvx4jPDh1gJLp6886N14d_xR).
[^5]: [DUNU达音科KIMA classic入耳式有线耳机typec苹果适用高音质hifi](https://detail.tmall.com/item.htm?app=chrome&bxsign=scddANwNMQ6EJwRCpFrihEYYod8PIgOnPb6QWDC8Ak-L3Srhv8NFHmzNrEdaIrv1AOc5VNmXkdhoDSjUfhc_HH1eNEJg-plh_gI36psRY9sYFmqa5YGi3e0sdX519Y_rydK&cpp=1&id=693910503368&price=899-1317&shareUniqueId=29324451215&share_crt_v=1&shareurl=true&short_name=h.TY28ZRBH0wnDLFD&sourceType=item&sp_tk=Wlg1MjNzMU5Oam0%3D&spm=a2159r.13376460.0.0&suid=CC8C0492-02CB-49CE-984A-A3CF6C4F36C4&tbSocialPopKey=shareItem&tk=ZX523s1NNjm&un=3d310f755c2dc6dabbeeeafdb2768e28&un_site=0&ut_sk=1.WeSDmX9SlUgDAHQITRU16K1w_21380790_1731917044054.Copy.1&wxsign=tbwMdLKE0oQS7Tau6pyUQtGOdsj10seBMWYBiC6MAew487WKfK3bO7Yq1QyUSxodZXGZiTcp-ZuvMfmviOToISmB8K6rQ53axk7q5Fl64mvZVHvkTft1b9jzvoMfQ0k3Wem).
[^6]: [闲扯HiFi耳机那些事儿：当\*级动圈遭遇\*级静电](https://post.smzdm.com/p/amm05klv/).
[^7]: [Loudspeaker](https://en.wikipedia.org/wiki/Loudspeaker).
[^8]: [Electrodynamic speaker driver](https://en.wikipedia.org/wiki/Electrodynamic_speaker_driver).

[^9]: [Headphones](https://en.wikipedia.org/wiki/Headphones).
[^10]: [“ESD Protection in Bluetooth Headphone Design: Ensuring Reliability and Longevity](https://www.romanearbuds.com/news/esd-protection-in-bluetooth-headphone-design-ensuring-reliability-and-longevity/).
[^11]: [Electrostatic Discharge (ESD) Explained for Wired Headsets](https://www.zebra.com/us/en/support-downloads/notifications/electrostatic-discharge-explained.html).
[^12]: [Static Electricity Discharge through Headphones / Earphones?](https://service.shure.com/s/article/static-electricity-discharge-through-headphones-earphones?language=en_US).
[^13]: [DUNU Kima Classic DLC Diaphragm Dynamic Driver IEMs](https://hifigo.com/products/dunu-kima-classic?rfsn=3270172.0d5635).
[^14]: [Litz wire](https://en.wikipedia.org/wiki/Litz_wire).
