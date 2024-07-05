---
title: Hyphen, En Dash, vs. Em Dash
toc: false
categories:
 - English
drafted_at: 2024-07-01 21:53:49 +0800
date: 2024-07-03 22:01:23 +0800
last_modified_at: 2024-07-05 10:07:35 +0800
modification_history:
 - 2024-07-03 22:01:23 +0800
 - 2024-07-05 10:07:35 +0800
---

During the process of transcribing some English texts, I find ‘dash’ is actually often used when someone wants to make an explanation within a sentence. However, I rarely use ‘dash’; leaving aside the grammar, there is one point always confusing me. That is, the dash length seem different at different cases, and I don’t know how to type them correctly. Specifically, in English typing mode, when I type `[hyphen/minus]` key[^4] on the keyboard, I have ‘-’, which looks kind of short; while in Chinese typing mode, if I type `[Shift]` + `[hyphen/minus]`, I have ‘——’, and after deleting one of them at which case, I’ll get ‘—’. It indeed looks like those dashes I ever saw to connect two parts of a sentence, but this method of typing an ‘English’ dash sounds ugly.

So, how to type a long dash in a standard way? To figure out this point, I looked up some references, and found that those dashes looks like the same but with different lengths can be categorized into three categories, i.e. hyphen, en dash, and em dash; they also have different functions from the perspective of English grammar. As in reference[^6]:

<br>

<div class="quote--left" markdown="1">

There are two types of **dash**. The en dash is approximately the length of the letter **N**, and the em dash the length of the letter **M**.

- The shorter **en dash** (–) is used to mark ranges and with the meaning “to” in phrases like “Dover–Calais crossing.”
- The longer **em dash** (—) is used to separate extra information or mark a break in a sentence.

**The en dash is sometimes also used in the same way as an em dash, especially in UK English**; in this case, it takes a space on either side.

Make sure not to confuse dashes with shorter hyphens (-), which are used to combine words (as in *well-behaved* or *long-running*). **A hyphen should not be used in place of a dash.**

</div>

In short, ‘hyphen (-)’ is used to combine words, ‘en dash (–)’ to mark ranges and with the meaning “to” in phrases, ‘em dash (—)’ to separate extra information or mark a break in a sentence.

However, there seems not a direct way to type an ‘en dash’ or ‘em dash’ by a single key on the keyboard. Besides, different softwares (or platforms) have different ways to render input symbols[^5]. Take my case. As will be showed in the following table, if I type `[hyphen/minus]` $n$ times in a row, they are themselves, i.e. $n$ symbols of `-`, while as in HTML web pages, they will be translated into ‘en dash’ or ‘em dash’. 

After searching for some references, I tried some methods:

| Mode                | Method                                                   | Characters in markdown file                 | Characters in HTML                                           |
| ------------------- | -------------------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------ |
| English typing mode | `[hyphen/minus]` $\times$ 1                              | `-`                                         | - (<font color="green">Hyphen/minus</font>)                  |
| English typing mode | `[hyphen/minus]` $\times$ 2                              | `--`                                        | -- (<font color="blue">En dash</font>)                       |
| English typing mode | `[hyphen/minus]` $\times$3                               | `---`                                       | --- (<font color="red">Em dash</font>)                       |
| English typing mode | `[hyphen/minus]` $\times$ 4                              | `----`                                      | ---- (<font color="red">Em dash</font> + <font color="green">Hyphen/minus</font>) |
| English typing mode | `[hyphen/minus]` $\times$ 5                              | `-----`                                     | ----- (<font color="red">Em dash</font> + <font color="blue">En dash</font>) |
| English typing mode | `[hyphen/minus]` $\times$6                               | `------`                                    | ------ (<font color="red">Em dash</font> $\times$ 2)         |
| Chinese typing mode | `[Shift]` + `[hyphen/minus]`                             | `——`                                        | —— (<font color="red">Em dash</font> $\times$ 2)             |
| Chinese typing mode | `[Shift]` + `[hyphen/minus]` and then delete one of them | `—`                                         | — (<font color="red">Em dash</font>)                         |
| Numeric keyboard    | EN DASH ALT CODES `ALT+0150`[^2][^3]                     | – (<font color="blue">En dash</font>)       | – (<font color="blue">En dash</font>)                        |
| Numeric keyboard    | EM DASH ALT CODES `ALT+0151`[^2][^3]                     | — (<font color="red">Em dash</font>)        | — (<font color="red">Em dash</font>)                         |
| HTML code           | `&ndash;`[^5]                                            | &ndash; (<font color="blue">En dash</font>) | &ndash; (<font color="blue">En dash</font>)                  |
| HTML code           | `&mdash;`[^5]                                            | &mdash; (<font color="red">Em dash</font>)  | &mdash; (<font color="red">Em dash</font>)                   |

From this table, we can conclude that:

- To type a ‘hyphen (-)’ (or say, minus symbol), just type `[hyphen/minus]` one time.
- To type ‘en dash (–)’ in HTML web pages, there are two ways:
    - `[hyphen/minus]` $\times$ 2
    - `&ndash;`
- and as for ‘em dash (—)’, more of the same:
    - `[hyphen/minus]` $\times$3
    - `&mdash;`

# References

[^2]: [How to type an em dash symbol on a Mac or Windows \| Zapier](https://zapier.com/blog/em-dash-on-keyboard/).
[^3]: [Punctuation ALT Codes « “•” »](https://www.i2symbol.com/punctuation-alt-codes).
[^4]: [Hyphen-minus - Wikipedia](https://en.wikipedia.org/wiki/Hyphen-minus).
[^5]: [Wikipedia:How to make dashes - Wikipedia](https://en.wikipedia.org/wiki/Wikipedia:How_to_make_dashes).
[^6]: [Em Dash (—) vs. En Dash (–) \| How to Use in Sentences](https://www.scribbr.com/language-rules/dashes/).
