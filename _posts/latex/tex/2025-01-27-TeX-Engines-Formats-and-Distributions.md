---
title: An Introduction to TeX Engines, TeX Formats, and TeX Distributions
categories:
 - LaTeX
tags:
 - ConTeXt
 - LaTeX Fundamentals
 - LuaTeX
 - pdfTeX
 - TeX
 - XeTeX
date: 2025-01-27 17:13:15 +0800
last_modified_at: 2025-01-27 17:13:15 +0800
---

# TeX typesetting program

TeX is a typesetting program which was originally designed and written by Donald Knuth[^5] when he was writing his book series *The Art of Computer Programming*. It was firstly released in 1978 as version TeX78.[^1]

<div class="quote--left" markdown="1">

When the first paper volume of Knuth's *The Art of Computer Programming* was published in 1968, it was typeset using hot metal typesetting on a Monotype machine. This method, dating back to the 19th century, produced a "classic style" appreciated by Knuth. When the second edition was published, in 1976, the whole book had to be typeset again because the Monotype technology had been largely replaced by phototypesetting, and the original fonts were no longer available. <i class="emphasize">When Knuth received the galley proofs of the new book on 30 March 1977, he found them inferior. Disappointed, Knuth set out to design his own typesetting system.</i>

Knuth saw for the first time the output of a high-quality digital typesetting system, and became interested in digital typography. On 13 May 1977, he wrote a memo to himself describing the basic features of TeX. <i class="emphasize">He planned to finish it on his sabbatical in 1978, but as it happened, the language was not "frozen" (ready to use) until 1989, more than ten years later.</i> Guy Steele happened to be at Stanford during the summer of 1978, when Knuth was developing his first version of TeX. When Steele returned to the Massachusetts Institute of Technology that autumn, he rewrote TeX's input/output (I/O) to run under the Incompatible Timesharing System (ITS) operating system. The first version of TeX, called TeX78, was written in the SAIL programming language to run on a PDP-10 under Stanford's WAITS operating system.

</div>

<div class="quote--left" markdown="1">
On 30 March 1977 the diary of Professor Donald Knuth, a computer scientist at Stanford University, recorded the following note to express his dissatisfaction with the quality of typeset proofs he’d just received for volume 2 of his book series *The Art of Computer Programming*:

<div class="quote--left--inside">

“<i class="emphasize">Galley proofs for vol. 2 finally arrive, they look awful... (typographically). I decide I have to solve the problem myself.</i>”

</div>

The quote above is from page 482 of *Digital Typography*[^23] by Donald E. Knuth. That small entry in Professor Knuth’s diary marked the catalyst for a programming journey which lasted many years and resulted in the creation of typesetting software capable of producing exquisitely typeset mathematics and, of course, beautifully typeset text: a program that Knuth named TeX.[^18]

</div>

The two goals of designing TeX are[^1]:

<div class="quote--left" markdown="1">

TeX was designed with two main goals in mind: to allow anybody to produce high-quality books with minimal effort, and to provide a system that would give exactly the same results on all computers, at any point in time (together with the Metafont language[^4][^16] for font description and the Computer Modern family of typefaces). TeX is free software, which made it accessible to a wide range of users.

</div>

In 1982, a rewritten TeX was published and named TeX82. And in 1990, Knuth released a new major version TeX 3.0, to change 7-bit into 8-bit character sets[^18], allowing 256 characters in the input text. TeX 3.0 is also the last major version, and after then only “updates” have been made.[^1]

<div class="quote--left" markdown="1">
TeX82, a new version of TeX rewritten from scratch, was published in 1982. Among other changes, the original hyphenation algorithm was replaced by a new algorithm written by Frank Liang. <i class="emphasize">TeX82 also uses fixed-point arithmetic instead of floating-point, to ensure reproducibility of the results across different computer hardware</i>, and includes a real, Turing-complete programming language, following intense lobbying by Guy Steele. In 1989, Donald Knuth released new versions of TeX and Metafont. Despite his desire to keep the program stable, Knuth realized that 128 different characters for the text input were not enough to accommodate foreign languages; the main change <i class="emphasize">in version 3.0 of TeX is thus the ability to work with 8-bit inputs, allowing 256 different characters in the text input</i>. TeX3.0 was released on March 15, 1990.

</div>

And, Knuth adopts a sort of “romantic” version numbering system, that is adding an extra digit at the end of the decimal after each update, to approach the irrational number $\pi$. To Knuth, keeping the TeX output consistent and stable is more important than importing new features for TeX.[^1]

<div class="quote--left" markdown="1">
Since version 3, TeX has used an idiosyncratic version numbering system, where  <i class="emphasize">updates have been indicated by adding an extra digit at the end of the decimal, so that the version number asymptotically approaches $\pi$</i>. This is a reflection of the fact that TeX is now very stable, and only minor updates are anticipated. The current version of TeX is 3.141592653; it was last updated in 2021. The design was frozen after version 3.0, and no new feature or fundamental change will be added, so all newer versions will contain only bug fixed. Even though Donald Knuth himself has suggested a few areas in which TeX could have been improved, he indicated that he firmly believes that  <i class="emphasize">having an unchanged system that will produce the same output now and in the future is more important than introducing new features</i>. For this reason, he has stated that  <i class="emphasize">the "absolutely final change (to be made after my death)" will be to change the version number to $\pi$, at which point all remaining bugs will become features</i>. Likewise, versions of Metafont after 2.0 asymptotically approach $e$ (currently at 2.7182818), and a similar change will be applied after Knuth's death.

...

The original source code for the current TeX software is written in WEB, a mixture of documentation written in TeX and a Pascal subset in order to ensure readability and portability. For example, <i class="emphasize">TeX does all of its dynamic allocation itself from fixed-size arrays and uses only fixed-point arithmetic for its internal calculations</i>. As a result, TeX has been ported to almost all operating systems, usually by using the web2c program to convert the source code into C instead of directly compiling the Pascal code. <i class="emphasize">Knuth has kept a very detailed log of all the bugs he has corrected and changes he has made in the program since 1982</i>; as of 2021, the list contains 440 entries, not including the version modification that should be done after his death as the final change in TeX. Knuth offers monetary awards to people who find and report a bug in TeX. The award per bug started at US \\$2.56 (one "hexadecimal dollar") and doubled every year until it was frozen at its current value of \\$ 327.68. Knuth has lost relatively little money as there have been very few bugs claimed. In addition, recipients have been known to frame their check as proof that they found a bug in TeX rather than cashing it.

Due to scammers finding scanned copies of his checks on the internet and using them to try to drain his bank account, Knuth no longer sends out real checks, but those who submit bug reports can get credit at The Bank of San Serriffe instead.

</div>


As a typesetting system, TeX has its own features and syntax. Right now, the term of TeX per se refers to more, may including the ecosystem built around the original TeX. Knuth also welcomes others to extend the functionality of TeX. Those extensions usually exist as macros.[^1]

<div class="quote--left" markdown="1">

The term now refers to the system of extensions – which includes software programs called <i class="term">TeX engines</i>, sets of <i class="term">TeX macros</i>, and <i class="term">packages</i> which provide extra typesetting functionality – built around the original TeX language. TeX is a popular means of typesetting complex mathematical formulae; it has been noted as one of the most sophisticated digital typographical systems.

...

When he designed TeX, Donald Knuth did not believe that a single typesetting system would fit everyone's needs; instead, <i class="emphasize">he designed many hooks inside the program so that it would be possible to write extensions</i>, and released the source code, hoping that the publishers would design versions tailoring to their own needs. While such extensions have been created (including some by Knuth himself), most people <i class="emphasize">have extended TeX only using macros</i> and it has remained a system associated with technical typesetting.

<br>

**Macro language**

TeX documents are written and programmed using an unusual <i class="term">macro language</i>. Broadly speaking, <i class="emphasize">the running of this macro language involves expansion and execution stages which do not interact directly</i>. Expansion includes both literal expansion of macro definitions as well as conditional branching, and execution involves such tasks as setting variables/registers and the actual typesetting process of adding glyphs to boxes.

The definition of a macro not only includes a list of commands but also the syntax of the call. It differs with most widely used lexical preprocessors like M4, in that the body of a macro gets tokenized at definition time.

The TeX macro language has been used to write <i class="emphasize">larger document production systems</i>, most notably including LaTeX and ConTeXt.

</div>

To make a distinction, the Knuth’s TeX is called Plain TeX. LaTeX[^2] and ConTeXt[^6] are “larger document production systems”. Although LaTeX and ConTeXt are developed around the TeX, they are different <i class="term">formats</i>. See below.

Besides, Knuth is very rigorous in some very details about his TeX, in addition to aforementioned version numbering system, there are also some others, like what *exactly* the name “TeX” represents[^1]:

<div class="quote--left" markdown="1">

Donald Knuth has indicated several times that the source code of TeX has been placed into the "public domain", and he strongly encourages modifications or experimentations with this source code. However, <i class="emphasize">since Knuth highly values the reproducibility of the output of all versions of TeX, any changed version must not be called TeX, or anything confusingly similar</i>. To enforce this rule, any implementation of the system must pass a test suite called the TRIP test before being allowed to be called TeX. The question of licence is somewhat confused by the statements included at the beginning of the TeX source code, which indicate that "all rights are reserved. Copying of this file is authorized only if ... you make absolutely no changes to your copy". This restriction should be interpreted as a prohibition to change the source code as long as the file is called `tex.web`[^31]. The copyright note at the beginning of `tex.web` (and `mf.web`)[^3] was changed in 2021 to explicitly state this. This interpretation is confirmed later in the source code when the TRIP test is mentioned ("If this program is changed, the resulting system should not be called 'TeX'").

</div>

and the pronunciation of “TeX”:

<div class="quote--left" markdown="1">

The name TeX is intended by its developer to be pronounced /tɛx/, with the final consonant of loch. The letters of the name are meant to represent the capital Greek letters tau, epsilon, and chi, as TeX is an abbreviation of τέχνη (ΤΕΧΝΗ technē), Greek for both "art" and "craft", which is also the root word of technical. English speakers often pronounce it /tɛk/, like the first syllable of technical.[^1]

</div>

<div class="quote--left" markdown="1">

Knuth almost stubbornly demands that the pronunciation of TeX must be /tɛx/ (according to the international phonetic alphabet[^36]), although it’s often pronounced as /tɛk/ in English. Similarly, he also requests that don’t leave out “K” when call his surname “Knuth”, i.e. “Ka-Nooth”, rather than “Nooth” which is commonly pronounced in English.[^37]

</div>

and the spelling of “TeX”[^1]:

<div class="quote--left" markdown="1">

<i class="emphasize">Knuth instructs that it be typeset with the "E" below the baseline and reduced spacing between the letters.</i> This is done, as Knuth mentions in his TeXbook, to distinguish TeX from other system names such as TEX, the Text EXecutive processor (developed by Honeywell Information Systems). Fans like to proliferate names from the word "TeX"—such as TeXnician (user of TeX software), TeXhacker (TeX programmer), TeXmaster (competent TeX programmer), TeXhax, and TeXnique.

</div>

<br>

# TeX engines, TeX formats, and TeX distributions

As said, built around TeX, written in the TeX macro language, there are many extensions derived. Although almost all of their names include “TeX”, they may belong to different notions. Among which, there are three concepts that users are most commonly exposed to, that is, TeX engine, TeX format, and TeX distribution.

- **TeX engines (or, TeX-based typesetting programs)**: TeX (Knuth’s original TeX software), pdfTeX[^8], XeTeX[^13], and LuaTeX[^7].
- **TeX formats (macro packages for TeX)**: Plain TeX, LaTeX[^2], ConTeXt[^6].
- **TeX distributions**:  TeX Live[^9][^19], MiKTeX[^11][^20], teTeX[^12], and MacTeX[^10].

## TeX engines: TeX, pdfTeX, XeTeX, and LuaTeX

The pdfTeX, XeTeX, LuaTeX et al. are developed on the Knuth’s original TeX software, and they are called <i class="term">TeX engines</i>, or, <i class="term">TeX-based typesetting programs</i>, <i class="term">TeX-based software</i>. We can view them as softwares used to drive the typesetting process[^18]. These TeX engines are derived from TeX’s source code, and strictly speaking, should be referred as “adaptations” or “derivatives”, rather than a new “version” of TeX[^18]. On the other hand, although these programs are derived from Knuth’s original TeX software, they contain features and functionality that aren’t available in Knuth’s original TeX.

TeX and related TeX engines are programmable. Take TeX. We use <i class="emphasize">TeX typesetting language</i> to write some instructions, and then TeX, as an <i class="emphasize">executable program</i>, is controlled by those instructions to output results. This process is the same for pdfTeX, XeTeX, LuaTeX et al. These <i class="emphasize">typesetting instructions</i> are called <i class="term">primitive</i> commands, that is a particular set of low-level commands. Each TeX engine can recognize hundreds of primitive commands, and many of the same primitives are supported by all engines, but some are specific to a particular engine---about this point, reference[^28] gives a detailed comparison about those primitives for different TeX engines.

These new TeX engines promote the source code of Knuth’s original TeX to add new features and provide support for modern typesetting technologies. They not only provide additional features (e.g., outputting direct to PDF, supporting OpenType fonts), but also add new primitives to Knuth’s original set, thus providing users with greater programming power and flexibility to control and take advantage of the additional functionality built into new TeX-based typesetting engines. So, it’s easy to understand that, these TeX engines are not completely compatible with each other, because some primitive commands may be correctly recognizable for some TeX engines but not for others. 

<div class="quote--left" markdown="1">

Here is a summary of some key features provided by the three most popular TeX engines[^18]:

**pdfTeX**[^24]: As its name suggests, it provides the ability to output directly to PDF, saving users from having to convert TeX’s native DVI format to PostScript and converting that to PDF via GhostScript or Acrobat Distiller (NB: some users also go from DVI to PDF via tools such as dvipdf). pdfTeX also introduced refinements to TeX’s typesetting—such as margin kerning (character protrusion). pdfTeX was developed by Hàn Thế Thành and its implementation details formed the basis for his PhD dissertation *Micro-typographic extensions to the TeX typesetting system*[^21]. First release date (as recorded in the release notes): August 2001

**XeTeX**[^25]: It introduced the ability to directly read/input TeX files saved or created in UTF-8 encoding, added sophisticated handling of multilingual typesetting—including complex scripts such as Arabic. One particularly useful feature is that XeTeX enabled very easy and convenient use of OpenType fonts and later versions added OpenType-based typesetting of mathematics. XeTeX was developed by Jonathan Kew although subsequent development has been led by other members of the TeX community. First release date (Wikipedia): Initially Mac OSX only, April 2004.

**LuaTeX**[^26]: Arguably the most powerful and versatile of all the TeX engines, LuaTeX is derived from pdfTeX (in addition to many other sources/libraries) and provides significant additional functionality. The key innovation is the addition of the Lua[^22] scripting language, allowing very sophisticated control of the TeX engine through an easy-to-use scripting language. It also supports UTF-8 text encoding, OpenType-based mathematical typesetting and very advanced use of OpenType fonts for text typesetting—although the mechanism is different to the one deployed by XeTeX. LuaTeX also integrates the MetaPost graphics language, allowing users to fully exploit MetaPost’s sophisticated drawing capabilities. In addition to the preparation of books and journal papers, LuaTeX is ideal for advanced or customized document engineering—a powerful feature is LuaTeX’s extensibility through “plugins” written in C/C++ and loaded as a .DLL (Windows) or .so (on Linux). LuaTeX is developed by a team that includes Hans Hagen, Taco Hoekwater, Luigi Scarso and others. First release date: Development work started around 2006 with numerous beta releases culminating in a version 1.0 release in September 2016. It is still undergoing very active development.

</div>

## TeX formats: Plain TeX, LaTeX, and ConTeXt

As said, primitive commands are a set of low-level commands. Actually, starting from those primitive commands, we can define much more high-level commands, called <i class="term">macros</i>, which can greatly simplifies the user programming process, and reflect the typesetting power of TeX.[^18]

<div class="quote--left" markdown="1">

TeX achieves its true power and sophistication through so-called <i class="term">TeX macros</i>. The primitive commands of an engine’s TeX language can be combined together to define new commands (called macros) which are <i class="emphasize">built from combinations of low-level primitive instructions and/or other macros</i>. TeX macros allow users to define new commands that are capable of performing complex typesetting operations, saving a great deal of time, typing and programming errors. In addition, TeX engines provide primitives that can determine which TeX engine is being used to typeset a document—so that a TeX engine can, on-the-fly, adapt its behaviour depending on whether or not it supports a particular primitive it might encounter. If a certain primitive is not supported directly but can be “mimicked” (using combinations of other primitives) then all is usually well—but if the chosen TeX engine really cannot cope with a particular primitive then typesetting will fail and an error will be reported. The TeX language is, after all, a programming language albeit one designed to solve typesetting problems; but as a programming language TeX is extremely arcane and works very differently to most programming languages you are likely to encounter today.

</div>

For example, the TeX system defines about 300 primitive commands, and <i class="term">Plain TeX</i> adds about 600 macros built from primitive commands. Take [the below example](#bye). The macro `\bye` is defined by Plain TeX based on TeX primitive commands, `\def\bye{\par\vfill\supereject\end}`[^29][^30], where `\par`, `\vfill`, and `\end` are primitive commands (see[^28][^32]), and `\supereject` is a macro to “take care of any leftover insertions”[^29].  The macro `\supereject` is defined in the file `plain.tex`[^32] (for my computer, the file locates in the directory `C:\texlive\2021\texmf-dist\tex\plain\base\plain.tex`) as `\def\supereject{\par\penalty-\@MM}`, where `\penalty` is a primitive and `\@MM` is a macro that is also defined in `plain.tex` as `\mathchardef\@MM=20000`, among which `\mathchardef` is a primitive (“`\chardef` command is used to define some integer constants less than 255, and `\mathchardef` for larger ones”[^33]).

We can view Plain TeX is a collection of pre-defined macros based on TeX primitives, and at times it is called a type of <i class="term">format</i> (or <i class="term">document format</i>, <i class="term">format file</i>). And, LaTeX and ConTeXt are also such formats.

<div class="quote--left" markdown="1">

The base TeX system understands about 300 commands, called primitives. These low-level commands are rarely used directly by users, and most functionality is provided by <i class="term">format files</i> (predumped memory images of TeX after large macro collections have been loaded). Knuth's original default <i class="term">format</i>, which adds about 600 commands, is **Plain TeX**. The most widely used format is **LaTeX**, originally developed by Leslie Lamport, which incorporates document styles for books, letters, slides, etc., and adds support for referencing and automatic numbering of sections and equations. Another widely used format, **AMS-TeX**[^14], is produced by the American Mathematical Society and provides many more user-friendly commands, which can be altered by journals to fit with their house style. Most of the features of AMS-TeX can be used in LaTeX by using the "AMS packages" (e.g., `amsmath`, `amssymb`) and the "AMS document classes" (e.g., `amsart`, `amsbook`). This is then referred to as AMS-LaTeX. Other formats include **ConTeXt**, used primarily for desktop publishing and written mostly by Hans Hagen at Pragma.[^1]

</div>

<div class="quote--left" markdown="1">

The logical extension to writing individual TeX macros for your own personal use is to prepare a collection of macros that others can also use—a package of macros which provide some useful tools and commands from which other (La)TeX users can benefit. And that is precisely what LaTeX is: <i class="emphasize">it is a very large collection of complex and sophisticated macros</i> designed to help you typeset books, journal papers and so forth. It provides a wealth of features to control things like page layout, fonts and a myriad of other typesetting details. Not only that but LaTeX was designed to be extensible: you can plug-in additional, more specialist, macro packages written to solve specific typesetting problems—e.g., producing nicely typeset tables, typesetting particularly complex forms of mathematics, chemical diagrams and so forth. If you visit the Comprehensive TeX Archive Network[^34] you can choose from hundreds, if not thousands, of macro packages that have been written and contributed by users worldwide.[^18]

</div>

Among which, what I am most familiar with is LaTeX[^2].

<div class="quote--left" markdown="1">

LaTeX uses the TeX typesetting program for formatting its output, and is itself written in the TeX macro language. ... LaTeX is intended to provide a high-level, descriptive markup language to utilize TeX more easily. TeX handles the document layout, while LaTeX handles the content side for document processing. LaTeX comprises a collection of TeX macros and a program to process LaTeX documents, and because the plain TeX formatting commands are elementary, it provides authors with ready-made commands for formatting and layout requirements such as chapter headings, footnotes, cross-references and bibliographies.

</div>

LaTeX was written in the early 1980s by Leslie Lamport[^15]. The current version is LaTeX2e, first released in 1994 but incrementally updated starting in 2015.[^2]

## Compile a TeX format using a TeX engine

To conclude, TeX, pdfTeX, XeTeX, and LuaTeX *et al.* are TeX engines, and Plain TeX, LaTeX, and ConTeXt *et al.* are TeX formats. So, to get a well-typeset document, we should write a `.tex` file in a certain TeX format, and then use a certain TeX engine to compile it. For example, we could [use TeX to compile Plain TeX formatting document by command `tex`](#example--tex), [use pdfTeX to compile LaTeX document by `latex`](#example--latex), [use LuaTeX to compile ConTeXt document by `context`](#example--context), and so forth. See the following summary table[^35].

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261943710.png" alt="image-20250126194342662" style="width:67%;" />

From the table, we can see some compilation commands like `pdflatex`, `xelatex`, and `lualatex`, and sometimes they are referred as pdfLaTeX, XeLaTeX, and LuaLaTeX, respectively. These terms don’t denote certain TeX engines or TeX formats, but represent using which kind of TeX engine to compile LaTeX formatting document[^18].

<div class="quote--left" markdown="1">
Frequently you will see terms such as pdfLaTeX, XeLaTeX or LuaLaTeX: but these are not actually the names of TeX engines, all they signify is which TeX engine is being used to run the LaTeX macro collection:


- pdfLaTeX means using the LaTeX macro package with the pdfTeX engine
- XeLaTeX means using the LaTeX macro package with the XeTeX engine
- LuaLaTeX means using the LaTeX macro package with the LuaTeX engine

For example, to say “I am using pdfLaTeX” means “I am preparing my typeset document using the LaTeX macro package and processing it with the pdfTeX engine”. Equally, if anyone says to you that they are “using TeX” then you should now see that statement probably does not tell you the whole story—that is, unless they are using Knuth’s original version of TeX, which is quite unlikely these days.

</div>

## TeX distributions: TeX Live and MiKTeX

For most users, we usually get access to aforementioned TeX typesetting engines, document formats, various kinds of macro packages, and more TeX-related utilities *etc.* via installing a TeX distribution. For UNIX-compatible systems, including Linux and macOS, the most commonly used TeX distribution is TeX Live[^19]. TeX Live also provides a version for Windows systems. Besides, another usual TeX distribution for Windows system is MiKTeX[^20]. [^1][^18]

<br>

# Comparison between different TeX formats

As said above, Plain TeX, LaTeX, and ConTeXt are actually different TeX formats---the collection of macros they can recognize is not completely the same. One significant difference is the organizational structure of document file. For example, LaTeX document is organized like:

```latex
\documentclass{article}

% preamble area

\begin{document}

% document body

\end{document}
```

but Plain TeX and ConTeXt look very different from it. So, in the following text, I would create three files, `doc_tex.tex`, `doc_latex.tex`, and `doc_context.tex`, respectively written in Plain TeX format, LaTeX format, and ConTeXt format. Then, compile them by TeX engine, pdfTeX engine, and LuaTeX engine, respectively, making a contrast for output files.

## TeX document

The first file is `doc_tex.tex`[^1], a Plain TeX document:

<div id="bye"></div>

```tex
Hello, World!

The quadratic formula is $-b \pm \sqrt{b^2 - 4ac} \over 2a$

The quadratic formula is $$-b \pm \sqrt{b^2 - 4ac} \over 2a$$
\bye          % marks the end of the file; not shown in the final output
```

including an inline mathematical equation and a display mathematical equation.

<div class="quote--left" markdown="1">
Knuth explained in jest that he chose the dollar sign to indicate the beginning and end of mathematical mode in plain TeX because typesetting mathematics was traditionally supposed to be expensive.[^1]

</div>

Next, use the command to compile the file:

<div id="example--tex"></div>

```powershell
tex doc_tex.tex
```

```
This is TeX, Version 3.141592653 (TeX Live 2021/W32TeX) (preloaded format=tex)
(./doc_tex.tex [1] )
Output written on doc_tex.dvi (1 page, 788 bytes).
Transcript written on doc_tex.log
```

and we can get two files, `doc_tex.dvi` and `doc_tex.log`, where `doc_tex.dvi` is the output file which we expect.

<div class="quote--left" markdown="1">

... representing the content of the page in a **d**e**v**ice **i**ndependent format (DVI). A DVI file could then be either viewed on screen or converted to a suitable format for any of the various printers for which a device driver existed (printer support was generally not an operating system feature at the time that TeX was created). Knuth has said that there is nothing inherent in TeX that requires DVI as the output format, and later versions of TeX, notably pdfTeX, XeTeX, and LuaTeX, all support output directly to PDF.[^1]

</div>

Here is the corresponding rendered content of `doc_tex.dvi`:

![image-20250124142926045](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501241429149.png)

## LaTeX document

The second file is `doc_latex.tex`[^2], written in LaTeX format:

```latex
\documentclass{article} % Starts an article
\usepackage{amsmath} % Imports amsmath
\title{\LaTeX} % Title

\begin{document} % Begins a document
  \maketitle
  \LaTeX{} is a document preparation system for
  the \TeX{} typesetting program. It offers
  programmable desktop publishing features and
  extensive facilities for automating most
  aspects of typesetting and desktop publishing,
  including numbering and cross-referencing,
  tables and figures, page layout,
  bibliographies, and much more. \LaTeX{} was
  originally written in 1984 by Leslie Lamport
  and has become the dominant method for using
  \TeX; few people write in plain \TeX{} anymore.
  The current version is \LaTeXe.

  % This is a comment, not shown in final output.
  % The following shows typesetting power of LaTeX:
  \begin{align}
    E_0 &= mc^2 \\
    E &= \frac{mc^2}{\sqrt{1-\frac{v^2}{c^2}}}
  \end{align} 
\end{document}
```

Use pdfTeX to compile it:

<div id="example--latex"></div>

```
latex doc_latex.tex
```

```
This is pdfTeX, Version 3.141592653-2.6-1.40.23 (TeX Live 2021/W32TeX) (preloaded format=latex)
 restricted \write18 enabled.
entering extended mode
(./doc_latex.tex
LaTeX2e <2021-11-15> patch level 1
L3 programming layer <2021-11-22>
(c:/texlive/2021/texmf-dist/tex/latex/base/article.cls
Document Class: article 2021/10/04 v1.4n Standard LaTeX document class
(c:/texlive/2021/texmf-dist/tex/latex/base/size10.clo))
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amstext.sty
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsgen.sty))
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsbsy.sty)
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsopn.sty))
(c:/texlive/2021/texmf-dist/tex/latex/l3backend/l3backend-dvips.def)
No file doc_latex.aux.

LaTeX Warning: No \author given.

[1] (./doc_latex.aux) )
Output written on doc_latex.dvi (1 page, 1768 bytes).
Transcript written on doc_latex.log.
```

and so we have three files, `doc_latex.log`, `doc_latex.aux`, and `doc_latex.dvi`. Or, we can use command `pdflatex` to compile to get a PDF file[^27].

Here is the content of `doc_latex.dvi`:

![image-20250124143150742](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501241431851.png)

<br>

## ConTeXt document

The third file is `doc_context.tex`[^6], which is written in ConTeXt format:

```tex
% This line is a comment because % precedes it.
% It specifies the format of head named 'title'
% Specifically the style of the font: sans serif
% + bold + big font.

\setuphead[title][style={\ss\bfd},
    before={\begingroup},
    after={John Doe, the author\smallskip%
           \currentdate\bigskip\endgroup}]

\starttext

\title{\CONTEXT}

\section{Text}
\CONTEXT\ is a document preparation system for the 
\TEX\ typesetting program. It offers programmable 
desktop publishing features and extensive 
facilities for automating most aspects of 
typesetting and desktop publishing, including 
numbering and cross-referencing (for example to 
equation \in[eqn:famous-emc]), tables and figures, 
page layout, bibliographies, and much more.

It was originally written around 1990 by Hans 
Hagen. It could be an alternative or complement 
to \LATEX.

\section{Maths}
With \CONTEXT\ we could write maths. Equations 
can be automatically numbered.

\placeformula[eqn:famous-emc]
\startformula
    E = mc^2
\stopformula
with
\placeformula[eqn:def-m]
\startformula
    m = \frac{m_0}{\sqrt{1-\frac{v^2}{c^2}}}
\stopformula

\stoptext
```

Use the command to compile:

<div id="example--context"></div>

```powershell
context doc_context.tex
```

```
resolvers       | formats | executing runner 'run luatex format': C:/texlive/2021/bin/win32/luatex --jobname="doc_context" --fmt=C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9/formats/luatex/cont-en.fmt --lua=C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9/formats/luatex/cont-en.lui cont-yes.mkiv --c:currentrun=1 --c:fulljobname="./doc_context.tex" --c:input="./doc_context.tex" --c:kindofrun=1 --c:maxnofruns=9 --c:texmfbinpath="C:/texlive/2021/bin/win32"
This is LuaTeX, Version 1.13.2 (TeX Live 2021/W32TeX)
 system commands enabled.
open source     > level 1, order 1, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-yes.mkiv'
system          >
system          > ConTeXt  ver: 2021.03.05 19:11 MKIV  fmt: 2025.1.17  int: english/english
system          >
system          > 'cont-new.mkiv' loaded
open source     > level 2, order 2, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-new.mkiv'
system          > beware: some patches loaded from cont-new.mkiv
close source    > level 2, order 2, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-new.mkiv'
system          > files > jobname 'doc_context', input './doc_context', result 'doc_context'
fonts           > latin modern fonts are not preloaded
languages       > language 'en' is active
open source     > level 2, order 3, name 'C:/Users/whatastarrynight/Desktop/tex/tex, latex, context/doc_context.tex'
fonts           > preloading latin modern fonts (second stage)
fonts           > 'fallback modern-designsize rm 12pt' is loaded
structure       > sectioning > title @ level 2 : 0.0 -> \CONTEXT
structure       > sectioning > section @ level 3 : 0.0.1 -> Text
structure       > sectioning > section @ level 3 : 0.0.2 -> Maths
backend         > xmp > using file 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/lpdf-pdx.xml'
pages           > flushing realpage 1, userpage 1, subpage 1
close source    > level 2, order 3, name 'C:/Users/whatastarrynight/Desktop/tex/tex, latex, context/doc_context.tex'
close source    > level 1, order 3, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-yes.mkiv'

mkiv lua stats  > used config file: selfautoparent:/texmfcnf.lua;selfautoparent:/texmf-dist/web2c/texmfcnf.lua
mkiv lua stats  > used cache path: readable+writable: 'C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9'
mkiv lua stats  > resource resolver: loadtime 0.089 seconds, 1 scans with scantime 0.001 seconds, 0 shared scans, 17 found files, scanned paths: C:/Users/whatastarrynight/.texlive2021/texmf-config
mkiv lua stats  > stored bytecode data: 454 modules (0.279 sec), 96 tables (0.012 sec), 550 chunks (0.291 sec)
mkiv lua stats  > traced context: maxstack: 1420, freed: 0, unreachable: 1420
mkiv lua stats  > cleaned up reserved nodes: 57 nodes, 9 lists of 442
mkiv lua stats  > node memory usage: 14 attribute, 4 attribute_list, 1 glue, 51 glue_spec, 3 kern, 2 penalty, 2 temp, 2 user_defined
mkiv lua stats  > node list callback tasks: 8 unique task lists, 9 instances (re)created, 152 calls
mkiv lua stats  > driver time: 0.093 seconds
mkiv lua stats  > used backend: pdf (backend for directly generating pdf output)
mkiv lua stats  > jobdata time: 0.001 seconds saving, 0.000 seconds loading
mkiv lua stats  > callbacks: internal: 357, file: 104, direct: 2, late: 5, function 613, total: 1081 (0 per page)
mkiv lua stats  > result saved in file: doc_context.pdf, compresslevel 3, objectcompresslevel 1
mkiv lua stats  > loaded patterns: en::1, load time: 0.000
mkiv lua stats  > loaded fonts: 7 files: latinmodern-math.otf, lmmono12-regular.otf, lmroman10-regular.otf, lmroman12-regular.otf, lmroman8-regular.otf, lmsans10-bold.otf, lmsans12-regular.otf
mkiv lua stats  > font engine: otf 3.113, afm 1.513, tfm 1.000, 12 instances, 3 shared in backend, 3 common vectors, 0 common hashes, load time 0.229 seconds
mkiv lua stats  > cross referencing: 1 identified, 1 unknown
mkiv lua stats  > used platform: mswin, type: windows, binary subtree: bin
mkiv lua stats  > used engine: luatex version: 1.1302, functionality level: 7430, banner: this is luatex, version 1.13.2 (tex live 2021/w32tex)
mkiv lua stats  > used hash slots: 46525 of 65536 + 200000
mkiv lua stats  > lua properties: engine: lua 5.3, used memory: 129 MB, ctx: 128 MB, max: unknown MB, hash chars: min(32,40), symbol mask: utf (τεχ)
mkiv lua stats  > runtime: 0.784 seconds, 1 processed pages, 1 shipped pages, 1.276 pages/second

resolvers       | formats | executing runner 'run luatex format': C:/texlive/2021/bin/win32/luatex --jobname="doc_context" --fmt=C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9/formats/luatex/cont-en.fmt --lua=C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9/formats/luatex/cont-en.lui cont-yes.mkiv --c:currentrun=2 --c:fulljobname="./doc_context.tex" --c:input="./doc_context.tex" --c:kindofrun=2 --c:maxnofruns=9 --c:texmfbinpath="C:/texlive/2021/bin/win32"
This is LuaTeX, Version 1.13.2 (TeX Live 2021/W32TeX)
 system commands enabled.
open source     > level 1, order 1, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-yes.mkiv'
system          >
system          > ConTeXt  ver: 2021.03.05 19:11 MKIV  fmt: 2025.1.17  int: english/english
system          >
system          > 'cont-new.mkiv' loaded
open source     > level 2, order 2, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-new.mkiv'
system          > beware: some patches loaded from cont-new.mkiv
close source    > level 2, order 2, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-new.mkiv'
system          > files > jobname 'doc_context', input './doc_context', result 'doc_context'
fonts           > latin modern fonts are not preloaded
languages       > language 'en' is active
open source     > level 2, order 3, name 'C:/Users/whatastarrynight/Desktop/tex/tex, latex, context/doc_context.tex'
fonts           > preloading latin modern fonts (second stage)
fonts           > 'fallback modern-designsize rm 12pt' is loaded
structure       > sectioning > title @ level 2 : 0.0 -> \CONTEXT
structure       > sectioning > section @ level 3 : 0.0.1 -> Text
structure       > sectioning > section @ level 3 : 0.0.2 -> Maths
backend         > xmp > using file 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/lpdf-pdx.xml'
pages           > flushing realpage 1, userpage 1, subpage 1
close source    > level 2, order 3, name 'C:/Users/whatastarrynight/Desktop/tex/tex, latex, context/doc_context.tex'
close source    > level 1, order 3, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-yes.mkiv'

mkiv lua stats  > used config file: selfautoparent:/texmfcnf.lua;selfautoparent:/texmf-dist/web2c/texmfcnf.lua
mkiv lua stats  > used cache path: readable+writable: 'C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9'
mkiv lua stats  > resource resolver: loadtime 0.068 seconds, 1 scans with scantime 0.001 seconds, 0 shared scans, 16 found files, scanned paths: C:/Users/whatastarrynight/.texlive2021/texmf-config
mkiv lua stats  > stored bytecode data: 454 modules (0.211 sec), 96 tables (0.008 sec), 550 chunks (0.219 sec)
mkiv lua stats  > traced context: maxstack: 1420, freed: 0, unreachable: 1420
mkiv lua stats  > cleaned up reserved nodes: 57 nodes, 9 lists of 442
mkiv lua stats  > node memory usage: 14 attribute, 4 attribute_list, 1 glue, 51 glue_spec, 3 kern, 2 penalty, 2 temp, 2 user_defined
mkiv lua stats  > node list callback tasks: 8 unique task lists, 9 instances (re)created, 152 calls
mkiv lua stats  > driver time: 0.078 seconds
mkiv lua stats  > used backend: pdf (backend for directly generating pdf output)
mkiv lua stats  > jobdata time: 0.001 seconds saving, 0.001 seconds loading
mkiv lua stats  > callbacks: internal: 353, file: 104, direct: 2, late: 5, function 613, total: 1077 (1077 per page)
mkiv lua stats  > randomizer: initialized with value 0.31982421875
mkiv lua stats  > result saved in file: doc_context.pdf, compresslevel 3, objectcompresslevel 1
mkiv lua stats  > loaded patterns: en::1, load time: 0.000
mkiv lua stats  > loaded fonts: 6 files: latinmodern-math.otf, lmroman10-regular.otf, lmroman12-regular.otf, lmroman8-regular.otf, lmsans10-bold.otf, lmsans12-regular.otf
mkiv lua stats  > font engine: otf 3.113, afm 1.513, tfm 1.000, 11 instances, 3 shared in backend, 3 common vectors, 0 common hashes, load time 0.148 seconds
mkiv lua stats  > used platform: mswin, type: windows, binary subtree: bin
mkiv lua stats  > used engine: luatex version: 1.1302, functionality level: 7430, banner: this is luatex, version 1.13.2 (tex live 2021/w32tex)
mkiv lua stats  > used hash slots: 46523 of 65536 + 200000
mkiv lua stats  > lua properties: engine: lua 5.3, used memory: 128 MB, ctx: 128 MB, max: unknown MB, hash chars: min(32,40), symbol mask: utf (τεχ)
mkiv lua stats  > runtime: 0.537 seconds, 1 processed pages, 1 shipped pages, 1.862 pages/second

resolvers       | formats | executing runner 'run luatex format': C:/texlive/2021/bin/win32/luatex --jobname="doc_context" --fmt=C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9/formats/luatex/cont-en.fmt --lua=C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9/formats/luatex/cont-en.lui cont-yes.mkiv --c:currentrun=3 --c:fulljobname="./doc_context.tex" --c:input="./doc_context.tex" --c:kindofrun=2 --c:maxnofruns=9 --c:texmfbinpath="C:/texlive/2021/bin/win32"
This is LuaTeX, Version 1.13.2 (TeX Live 2021/W32TeX)
 system commands enabled.
open source     > level 1, order 1, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-yes.mkiv'
system          >
system          > ConTeXt  ver: 2021.03.05 19:11 MKIV  fmt: 2025.1.17  int: english/english
system          >
system          > 'cont-new.mkiv' loaded
open source     > level 2, order 2, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-new.mkiv'
system          > beware: some patches loaded from cont-new.mkiv
close source    > level 2, order 2, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-new.mkiv'
system          > files > jobname 'doc_context', input './doc_context', result 'doc_context'
fonts           > latin modern fonts are not preloaded
languages       > language 'en' is active
open source     > level 2, order 3, name 'C:/Users/whatastarrynight/Desktop/tex/tex, latex, context/doc_context.tex'
fonts           > preloading latin modern fonts (second stage)
fonts           > 'fallback modern-designsize rm 12pt' is loaded
structure       > sectioning > title @ level 2 : 0.0 -> \CONTEXT
structure       > sectioning > section @ level 3 : 0.0.1 -> Text
structure       > sectioning > section @ level 3 : 0.0.2 -> Maths
backend         > xmp > using file 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/lpdf-pdx.xml'
pages           > flushing realpage 1, userpage 1, subpage 1
close source    > level 2, order 3, name 'C:/Users/whatastarrynight/Desktop/tex/tex, latex, context/doc_context.tex'
close source    > level 1, order 3, name 'C:/texlive/2021/texmf-dist/tex/context/base/mkiv/cont-yes.mkiv'

mkiv lua stats  > used config file: selfautoparent:/texmfcnf.lua;selfautoparent:/texmf-dist/web2c/texmfcnf.lua
mkiv lua stats  > used cache path: readable+writable: 'C:/texlive/2021/texmf-var/luatex-cache/context/a86c089b384a3076dc514ba966a1fac9'
mkiv lua stats  > resource resolver: loadtime 0.082 seconds, 1 scans with scantime 0.001 seconds, 0 shared scans, 16 found files, scanned paths: C:/Users/whatastarrynight/.texlive2021/texmf-config
mkiv lua stats  > stored bytecode data: 454 modules (0.206 sec), 96 tables (0.007 sec), 550 chunks (0.213 sec)
mkiv lua stats  > traced context: maxstack: 1420, freed: 0, unreachable: 1420
mkiv lua stats  > cleaned up reserved nodes: 57 nodes, 9 lists of 442
mkiv lua stats  > node memory usage: 14 attribute, 4 attribute_list, 1 glue, 51 glue_spec, 3 kern, 2 penalty, 2 temp, 2 user_defined
mkiv lua stats  > node list callback tasks: 8 unique task lists, 9 instances (re)created, 152 calls
mkiv lua stats  > driver time: 0.078 seconds
mkiv lua stats  > used backend: pdf (backend for directly generating pdf output)
mkiv lua stats  > jobdata time: 0.001 seconds saving, 0.001 seconds loading
mkiv lua stats  > callbacks: internal: 353, file: 104, direct: 2, late: 5, function 613, total: 1077 (1077 per page)
mkiv lua stats  > randomizer: resumed with value 0.31982421875
mkiv lua stats  > result saved in file: doc_context.pdf, compresslevel 3, objectcompresslevel 1
mkiv lua stats  > loaded patterns: en::1, load time: 0.000
mkiv lua stats  > loaded fonts: 6 files: latinmodern-math.otf, lmroman10-regular.otf, lmroman12-regular.otf, lmroman8-regular.otf, lmsans10-bold.otf, lmsans12-regular.otf
mkiv lua stats  > font engine: otf 3.113, afm 1.513, tfm 1.000, 11 instances, 3 shared in backend, 3 common vectors, 0 common hashes, load time 0.133 seconds
mkiv lua stats  > used platform: mswin, type: windows, binary subtree: bin
mkiv lua stats  > used engine: luatex version: 1.1302, functionality level: 7430, banner: this is luatex, version 1.13.2 (tex live 2021/w32tex)
mkiv lua stats  > used hash slots: 46523 of 65536 + 200000
mkiv lua stats  > lua properties: engine: lua 5.3, used memory: 128 MB, ctx: 128 MB, max: unknown MB, hash chars: min(32,40), symbol mask: utf (τεχ)
mkiv lua stats  > runtime: 0.511 seconds, 1 processed pages, 1 shipped pages, 1.957 pages/second
system          | total runtime: 2.574 seconds
```

After a relatively long compilation time, 2.574 seconds, we’d have `doc_context.pdf` and `doc_context.log`, where the content of `doc_context.pdf` is:

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501241435785.png)

<br>

**References**

[^1]: [TeX](https://en.wikipedia.org/wiki/TeX).
[^2]: [LaTeX](https://en.wikipedia.org/wiki/LaTeX).
[^3]: [Web (programming system)](https://en.wikipedia.org/wiki/Web_\(programming_system\)): Web is a computer programming system created by Donald E. Knuth as the first implementation of what he called "literate programming": the idea that one could create software as works of literature, by embedding source code inside descriptive text, rather than the reverse (as is common practice in most programming languages), in an order that is convenient for exposition to human readers, rather than in the order demanded by the compiler. Web consists of two secondary programs: TANGLE, which produces compilable Pascal code from the source texts, and WEAVE, which produces nicely-formatted, printable documentation using TeX. The most significant programs written in Web are TeX and Metafont. Modern TeX distributions use another program Web2C to convert Web source to C.
[^4]: [Metafont](https://en.wikipedia.org/wiki/Metafont).
[^5]: [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth).
[^6]: [ConTeXt](https://en.wikipedia.org/wiki/ConTeXt).
[^7]: [LuaTeX](https://en.wikipedia.org/wiki/LuaTeX).
[^8]: [pdfTeX](https://en.wikipedia.org/wiki/PdfTeX).
[^9]: [TeX Live](https://en.wikipedia.org/wiki/TeX_Live).
[^10]: [MacTeX](https://en.wikipedia.org/wiki/MacTeX).
[^11]: [MiKTeX](https://en.wikipedia.org/wiki/MiKTeX).
[^12]: [teTeX](https://en.wikipedia.org/wiki/TeTeX): teTeX (stylised as teTeX) was a TeX distribution for Unix-like systems. As of May 2006, teTeX is no longer actively maintained and its former maintainer Thomas Esser recommended TeX Live as the replacement. During installation of TexLive it's possible to choose scheme that would include teTeX packages.
[^13]: [XeTeX](https://en.wikipedia.org/wiki/XeTeX).
[^14]: [AMS-LaTeX](https://en.wikipedia.org/wiki/AMS-LaTeX).
[^15]: [Leslie Lamport](https://en.wikipedia.org/wiki/Leslie_Lamport).
[^16]: [Hello, Metafont!](/2025-01-17/12-11-58.html).
[^18]: [What's in a Name: A Guide to the Many Flavours of TeX](https://www.overleaf.com/learn/latex/Articles/What%27s_in_a_Name%3A_A_Guide_to_the_Many_Flavours_of_TeX).
[^19]: [TeX Live](https://www.tug.org/texlive/).
[^20]: [MiKTeX](https://miktex.org/).
[^21]: [Micro-typographic extensions to the TeX typesetting system](https://www.tug.org/TUGboat/tb21-4/tb69thanh.pdf).
[^22]: [TIOBE Index](https://www.tiobe.com/tiobe-index/): In Jan. 2025, Lua is ranked 27th with ratings 0.59%.
[^23]: [Digital Typography: Volume 78 (Center for the Study of Language and Information Publication Lecture Notes): Amazon.co.uk: Knuth, Donald E.: 9781575860107: Books](https://www.amazon.co.uk/Digital-Typography-Language-Information-Publication/dp/1575860104).
[^24]: [pdfTeX](https://tug.org/applications/pdftex/).
[^25]: [XeTeX](https://tug.org/xetex/).
[^26]: [LuaTeX](https://www.luatex.org/).
[^27]: [Compile LaTeX File Using Command Line](https://helloworld-1017.github.io/2025-01-16/16-40-21.html).
[^28]: [TeX primitives listed by TeX engine](https://www.overleaf.com/learn/latex/TeX_primitives_listed_by_TeX_engine).
[^29]: [TEX BY TOPIC, A TEXNICIAN’S REFERENCE](https://texdoc.org/serve/TeXbyTopic.pdf/0).
[^30]: [TeX/bye](https://en.wikibooks.org/wiki/TeX/bye).
[^31]: [CTAN: /tex-archive/systems/knuth/dist/tex](https://ctan.org/tex-archive/systems/knuth/dist/tex?lang=en).
[^32]: [CSNAME.TEX](https://plain-xetex.neocities.org/controlsequences/csname.pdf).
[^33]: [TRALICS : a LaTeX to XML translator (M)](https://www-sop.inria.fr/marelle/tralics/doc-m.html).
[^34]: [CTAN: Comprehensive TeX Archive Network](https://www.ctan.org/).
[^35]: [TeX-related Compilation Commands for Various TeX Formats and Engines](/2025-01-26/20-51-36.html).
[^36]: [International Phonetic Alphabet](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet).
[^37]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 1-2.
