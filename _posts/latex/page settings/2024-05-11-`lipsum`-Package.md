---
title: From LaTeX `lipsum` Package to Cicero's *de Finibus Bonorum et Malorum* (*On the ends of good and evil*) and *Cato Maior de Senectute* (*Cato the Elder on Old Age*)
categories:
 - Design
 - LaTeX
 - Philosophy
 - Psychology
tags:
 - LaTeX Layout
 - Typora
date: 2024-05-11 22:05:01 +0800
last_modified_at: 2024-11-12 17:26:07 +0800
---

# LaTeX `lipsum` package

LaTeX `lipsum` package provides 150 paragraphs of *Lorem Ipsum* dummy text to test documents and examples[^1][^2], and we can easily generate these paragraphs using `\lipsum` command:

```latex
\documentclass{article}
\usepackage{lipsum}

\begin{document}
	\lipsum
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405091633001.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405091633827.png)

As can be seen, `\lipsum` command will generate 1~7 paragraphs by default. Besides, we can specify the range of generated paragraphs and sentences by setting first and second parameters of `\lipsum` command, `\lipsum[<paragraph-range>][sentence-range]`. For example, we choose to generate 7-91 sentences of 1-10 paragraphs:

```latex
\documentclass{article}
\usepackage{lipsum}

\begin{document}
	\lipsum[1-10][7-91]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405091646400.png)

Note that, at this time, there is no segment between the sentences. 

<br>

# Lorem Ipsum 

As mentioned before, these paragraphs are from *Lorem Ipsum.* *Lorem Ipsum* is not exclusively used in LaTeX typesetting system; actually, it is a placeholder text that commonly used to demonstrate the visual form of a document or a typeface before the final copy in printing and typesetting industry[^3][^4]. For example, it appears frequently in templates provided by Apple Pages application: 

![5e0991d02708f46b29a2b662df8b640](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405091726758.png)

and Typora software:

![image-20240521203648698](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405212037534.png)

The history of *Lorem Ipsum* becoming the industry's standard dummy text could be traced back to 1500s[^3], and was introduced to the digital world in the mid-1980s[^4]. The first two words, Lorem Ipsum, are always used to test title style, which is why these texts are called "Lorem Ipsum". And, words "Lorem Ipsum" are a truncation of "dolorem ipsum" (Latin, meaning "pain itself")[^4]. According to those references[^3][^4], *Lorem Ipsum* is derived from Section 1.10.32 and 1.10.33 of *de Finibus Bonorum et Malorum*[^5] (*On the ends of good and evil*, English version is available at[^6]) , written by Cicero (106 BC - 43 BC)[^7] in 45 BC. In the later sections, I would discuss more about Cicero and his book, but here I want to talk about something interesting.

[https://lipsum.com/](https://lipsum.com/)[^3] is a formal and free Lorem Ipsum generator, it tells the origin, development *etc*. about *Lorem Ipsum* in detail, and in whose contents two points appeal to me. 

The first one is that it points out that, those Latin words in *Lorem Ipsum* represent "more-or-less *normal distribution* of letters", standing in the middle of those contents which have certain meanings (readable contents which distract readers) and something like 'Content here, content here' (not readable English), therefore more friendly when testing the appearance of layouts compared with the other both cases. It says, this is a "long established fact". I guess this kind of feeling of readers should comply with a certain psychology foundation.

Another one is that, in the process of development, the original *Lorem Ipsum* probably be modified or broken by accident, sometimes on purpose, by injecting humor randomised words or whatever don't look even slightly believable, which deviates its intention of not distracting readers. Therefore, the purpose of this website is to provide a service to generate the original and clean version of *Lorem Ipsum*. 

Interesting anyway.

<br>

# *de Finibus Bonorum et Malorum* (*On the ends of good and evil*)

*Lorem Ipsum* relates to, as mentioned before, Cicero's book *de Finibus Bonorum et Malorum*. This discovery can be attributed to a Latin scholar, Richard McClintock. Both references[^3][^4] have detailed comparisons for *de Finibus Bonorum et Malorum* and *Lorem Ipsum*. But I totally don't understand Latin, so here I just show the English version (translated by H. Rackham in 1914) of those contents in *de Finibus Bonorum et Malorum* concerning *Lorem Ipsum*. 

<div class="quote--left" markdown=1>

... *This Epicurus finds in pleasure; pleasure he holds to be the Chief Good, pain the Chief Evil.*

*This he sets out to prove as follows: every animal, as soon as it is born, seeks for pleasure, and delights in it as the Chief Good, while it recoils from pain as the Chief Evil, and so far as possible avoids it. This it does as long as it remains unperverted, at the prompting of Nature's own unbiased and honest verdict. Hence Epicurus refuses to admit any necessity for argument or discussion to prove that pleasure is desirable and pain to be avoided. These facts, he thinks, are perceived by the senses, as that fire is hot, snow white, honey sweet, none of which things need be proved by elaborate argument: it is enough merely to draw attention to them. (For there is a difference, he holds, between formal syllogistic proof of a thing and a mere notice or reminder: the former is the method for discovering abstruse and recondite truths, the latter for indicating facts that are obvious and evident.) Strip mankind of sensation, and nothing remains; it follows that Nature herself is the judge of that which is in accordance with or contrary to nature. What does Nature perceive or what does she judge of, beside pleasure and pain, to guider her actions of desire and of avoidance?*

*Some members of our school however would refine upon this doctrine; they say that it is not enough for the judgement of good and evil to rest with the senses; the facts that pleasure is in and for itself desirable and pain in and for itself to be avoided can also be grasped by the intellect and the reason. Accordingly they declare that the perception that the one is to be sought after and the other avoided is a notion naturally implanted in our minds. Others again, with whom I agree, observing that a great many philosophers do advance a vast array of reasons to prove why pleasure should not be counted as a good nor pain as an evil, consider that we had better not be too confident of our case; in their view it requires elaborate and reasoned argument, and abstruse theoretical discussion of the nature of pleasure and pain.*

But I must explain to you how all this mistaken idea of reprobating pleasure and extolling pain arose. To do so, I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who <ins>loves or pursues or desires to obtain pain of itself, because it is pain, but</ins> occasionally <ins>circumstances occur in which toil and pain can procure him some great</ins> pleasure. <ins>To take a trivial example, which of us ever</ins> undertakes <ins>laborious physical exercise, except to obtain some advantage from it? But who</ins> has any right to <ins>find fault</ins> with a man who <ins>chooses to enjoy a pleasure</ins> that has no annoying consequences, or <ins>one</ins> who <ins>avoids a pain</ins> that <ins>produces no</ins> resultant pleasure?

On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so <ins>blinded by desire, that they cannot foresee</ins> the pain and trouble that are bound to ensue; and equal <ins>blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil</ins> and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammeled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.

</div>

The underlined texts in the last two paragraphs are those related to *Lorem Ipsum* according to Wikipedia[^4]. In which, I really like the last sentence:

<div class="quote--center" markdown=1>

The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.

</div>

However, I realize that the discussions in these two paragraphs are incomplete; I am still confused about the viewpoint of Cicero himself. 

Therefore, I look up the complete English translation of *de Finibus Bonorum et Malorum*[^6], and added those texts (italic form) before these two paragraphs, making the whole statement more clear.

To sum up, Epicurus (341–270 BC)[^8] contends that there is no "any necessity for argument or discussion to *prove* that pleasure is desirable and pain to be avoided", because both pleasure and pain can be "perceived by the senses, as that fire is hot, snow white, honey sweet"; they are facts, which didn't need to "be proved by elaborate argument", and "it is enough merely to draw attention to them"; "nature herself is the judge". He believes "strip mankind of sensation, and nothing remains."

Cicero, like many other philosophers, however, holds different views, that "it is not enough for the judgement of good and evil to rest with the senses", and pleasure and pain "can be also graphed by the intellect and the reason". Although the perception is a notion "naturally implanted in our minds",—there is a natural tendency to make mankind to believe that one emotion should be pursued and the other should be avoided,—it's not the unique criterion for judging or defining that the pleasure is Good, the pain is Evil. "We had better not be too confident of our sense", and "it requires elaborate and reasoned argument, and abstruse theoretical discussion of the nature of pleasure and pain". 

Cicero admits that, except for some intentional choices, nobody dislikes or rejects pleasure itself, and loves or desires pain itself; people are born to be this. And, others have no any right to criticize "a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain  that  produces no resultant pleasure". However, people usually denounce those men who indulge in pleasure, and those "who fails their duty through weakness of will", because they are "so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue". If "our power of choice is untrammelled and when nothing prevents our being able to do what we like best", welcoming every pleasure and avoiding every pain, as Epicurus believes, then it finally will hurt someone or something, maybe a lot, whether intentionally or not. Therefore, it's more reasonable to make a such choice: reject pleasures to secure other greater pleasure, and endure pains to avoid worse pains.

To my mind, I am more convinced by Cicero's views. The power of choice to pleasure and pain shouldn't and can't be untrammelled as every individual is so naturally different that if not so, we can't create a relatively peaceful environment, which is why morality and regulation are necessary. Limiting this kind of power protects the majority. 

On the other hand, what is pleasure and what is pain for mankind are not that natural: they are not only about personal perception, but also influenced by people's common beliefs about meaning, by material conditions and technology development, and definitely evolves as time. Setting aside biological mechanisms and just talking about specific things, I don't think I have the same ideas about pleasure and pain as Epicurus or Cicero or any other living in BC. Something has changed and will change in the future, but what may be everlasting is that, sometimes it is a wisdom choice to reject pleasure and endure pains, as Cicero said. This sort of choice, perhaps not conforming to human nature, is not only beneficial to individuals, but also to the entire society.

<br>

# *Cato Maior de Senectute* (*Cato the Elder on Old Age*)

Cicero[^7] (341–270 BC) is a Roman philosopher. I remember that in Charlie Munger's (1924-2023, vice chairman of Berkshire Hathaway Inc.[^9]) book, *Poor Charlie's Almanack*[^10] (available at[^13]), Charlie talks about another masterpiece of Cicero, *Cato Maior de Senectute*[^11] (*Cato the Elder on Old Age*, English version is available at[^12]). Charlie writes, "I practically went into orbit upon seeing a work by Cicero that I could not recall ever having heard of, full of praise for old age". hahaha~ 

Charlie thinks that a grand summary of *de Senectute* is the following statement:

<div class="quote--left" markdown=1>

The best armour of old age is a well spent life preceding it; a life employed in the pursuit of useful knowledge, in honorable actions and the practice of virtue; in which he who labors to improve himself from his youth, will in age reap the happiest fruits of them; not only because these never leave a man, nor even in the extremist [sic] old age; but because a conscience bearing witness that our life was well-spent, together with the remembrance of past good actions, yields an unspeakable comfort to the soul.

</div>

To sum up, if you are doing the right things, there's no need to be afraid of aging: "To Cicero, if you live right, the inferior part of life is the early part". And, doing our jobs well right now is one way to comfort or motivate us: "To him[Cicero], pride in a job well done is vastly constructive. For instance, it motivates good conduct in early life because, in remembrance, you can make yourself happier when old." About this point, Charlie adds that, "besides, as you pat yourself on the back for behaving well, you will improve your future conduct." 

As Charlie says in his book, Benjamin Franklin (1785–1788)[^15], who published the first translation of Cicero's *Cato Maior de Senectute*[^11], and Warren Buffett are also the positive supporters and practicers of Cicero's views. By the way, these wisdoms really remind me of two lines in the film, *The Intern* [^14]:

<div class="quote--center" markdown=1>

Freud said, "Love and work. Work and love. That's all there is."

</div>


![image-20240511205326612](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405112054663.png)

<div class="quote--center" markdown=1>

"Musicians don't retire. They stop when there's no more music in them."

</div>

![image-20240511205724297](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405112057631.png)

Actually, the reason why I have a strong impression of Cicero is that Charlie praise for him extremely highly. Charlie also points out in this book, "His[Cicero's] underlying philosophical view was one of deep and realistic cynicism about human nature, including a distaste for pure mob rule and demagogues." Realistic cynicism about human nature. I think this is why I feel that Cicero's words are fairly sincere.

<br>

**References**

[^1]: [CTAN: Package lipsum](https://ctan.org/pkg/lipsum?lang=en), package documentation: [lipsum.pdf](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/lipsum/lipsum.pdf).
[^2]: [PhelypeOleinik/lipsum: 150 paragraphs of Lorem ipsum dummy text for LaTeX](https://github.com/PhelypeOleinik/lipsum).
[^3]: [Lorem Ipsum - All the facts - Lipsum generator](https://lipsum.com/).
[^4]: [Lorem ipsum](https://en.wikipedia.org/wiki/Lorem_ipsum).
[^5]: [De finibus bonorum et malorum](https://en.wikipedia.org/wiki/De_finibus_bonorum_et_malorum).
[^6]: [De finibus bonorum et malorum Documentation](https://readthedocs.org/projects/de-finibus-bonorum-et-malorum/downloads/pdf/latest/).
[^7]: [Cicero](https://en.wikipedia.org/wiki/Cicero).
[^8]: [Epicurus](https://en.wikipedia.org/wiki/Epicurus).

[^9]: [Charlie Munger](https://en.wikipedia.org/wiki/Charlie_Munger).
[^10]: [Poor Charlie's Almanack](https://en.wikipedia.org/wiki/Poor_Charlie%27s_Almanack).
[^11]: [Cato Maior de Senectute](https://en.wikipedia.org/wiki/Cato_Maior_de_Senectute).
[^12]: [On Old Age (De Senectute)](https://oll.libertyfund.org/titles/cicero-on-old-age-de-senectute).

[^13]: [Poor Charlie’s Almanack - The Wit And Wisdom Of Charles T. Munger ( PDFDrive ) : Free Download, Borrow, and Streaming : Internet Archive](https://archive.org/details/poor-charlies-almanack-the-wit-and-wisdom-of-charles-t.-munger-pdfdrive/page/n27/mode/2up).

[^14]: [The Intern (2015 film)](https://en.wikipedia.org/wiki/The_Intern_(2015_film)).
[^15]: [Benjamin Franklin](https://en.wikipedia.org/wiki/Benjamin_Franklin).
