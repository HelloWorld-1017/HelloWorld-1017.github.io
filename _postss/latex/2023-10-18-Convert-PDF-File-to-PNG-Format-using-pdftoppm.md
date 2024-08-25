---
layout: single
title: Convert PDF File to PNG Format using `pdftoppm.exe`
date: 2023-10-18 20:12:31 +0800
categories:
 - LaTeX
 - MATLAB
tag:
 - LaTeX Tools
 - MATLAB System Commands
---

# Basic usage of `pdftoppm.exe`

It is convenient to convert PDF file to PNG (Portable Network Graphics) file using `pdftoppm.exe`, all we need is to use the following command in the command prompt [[1]](#ref):

> **Pdftoppm** converts Portable Document Format (PDF) files to color image files in Portable Pixmap (PPM) format, grayscale image files in Portable Graymap (PGM) format, or monochrome image files in Portable Bitmap (PBM) format. Pdftoppm reads the PDF file, PDF-file, and writes one PPM file for each page, `PPM-root-nnnnnn.ppm`, where `nnnnnn` is the page number. If PPM-root is '-', the image is sent to stdout (this is probably only useful when converting a single page) [[1]](#ref). 

```bash
pdftoppm -png "pdfname" "pngname"
```

For example, if we want to convert a PDF file `document.pdf` to `.png` format, we could use:

```bash
pdftoppm -png "document.pdf" "png"
```

N.B., The command prompt should be started in the folder where `document.pdf` is put.
{: .notice--primary}

A series of `.png` files will turn up in the current folder, named `png-01.png`, `png-02.png`, `png-03.png` ... The number of `.png` files is the same as the number of `document.pdf` pages, that is each page in `document.pdf` is converted to one `.png` file. 

Actually `pdftoppm.exe` provides more available options, we could view help information of it by inputting command:

```bash
pdftoppm -h
```

```
pdftoppm version 22.02.0
Copyright 2005-2022 The Poppler Developers - http://poppler.freedesktop.org
Copyright 1996-2011 Glyph & Cog, LLC
Usage: pdftoppm [options] [PDF-file [PPM-file-prefix]]
  -f <int>                                 : first page to print
  -l <int>                                 : last page to print
  -o                                       : print only odd pages
  -e                                       : print only even pages
  -singlefile                              : write only the first page and do not add digits
  -scale-dimension-before-rotation         : for rotated pdf, resize dimensions before the rotation
  -r <fp>                                  : resolution, in DPI (default is 150)
  -rx <fp>                                 : X resolution, in DPI (default is 150)
  -ry <fp>                                 : Y resolution, in DPI (default is 150)
  -scale-to <int>                          : scales each page to fit within scale-to*scale-to pixel box
  -scale-to-x <int>                        : scales each page horizontally to fit in scale-to-x pixels
  -scale-to-y <int>                        : scales each page vertically to fit in scale-to-y pixels
  -x <int>                                 : x-coordinate of the crop area top left corner
  -y <int>                                 : y-coordinate of the crop area top left corner
  -W <int>                                 : width of crop area in pixels (default is 0)
  -H <int>                                 : height of crop area in pixels (default is 0)
  -sz <int>                                : size of crop square in pixels (sets W and H)
  -cropbox                                 : use the crop box rather than media box
  -hide-annotations                        : do not show annotations
  -mono                                    : generate a monochrome PBM file
  -gray                                    : generate a grayscale PGM file
  -displayprofile <string>                 : ICC color profile to use as the display profile
  -defaultgrayprofile <string>             : ICC color profile to use as the DefaultGray color space
  -defaultrgbprofile <string>              : ICC color profile to use as the DefaultRGB color space
  -defaultcmykprofile <string>             : ICC color profile to use as the DefaultCMYK color space
  -sep <string>                            : single character separator between name and page number, default -
  -forcenum                                : force page number even if there is only one page
  -png                                     : generate a PNG file
  -overprint                               : enable overprint
  -freetype <string>                       : enable FreeType font rasterizer: yes, no
  -thinlinemode <string>                   : set thin line mode: none, solid, shape. Default: none
  -aa <string>                             : enable font anti-aliasing: yes, no
  -aaVector <string>                       : enable vector anti-aliasing: yes, no
  -opw <string>                            : owner password (for encrypted files)
  -upw <string>                            : user password (for encrypted files)
  -q                                       : don't print any messages or errors
  -progress                                : print progress info
  -v                                       : print copyright and version info
  -h                                       : print usage information
  -help                                    : print usage information
  --help                                   : print usage information
  -?                                       : print usage information
```

Among which, I think the `-r <fp>` option is the most commonly used, whose function is specifying the resolution of `.png` file (default resolution is 150 dpi). The complete command is:

```bash
pdftoppm -png "document.pdf" "png" -r 600
```

<br>

In fact, `pdftoppm.exe` in my computer is downloaded with TeX Live, it is one of tools and located at the folder `C:\texlive\2022\bin\win32`. In this folder, there exist other numerous small-but-useful tools. We could list them using MATLAB code:

```matlab
% MATLAB script
dir(fullfile("C:\texlive\2022\bin\win32","*.exe"))
```

```
a2ping.exe                    httexi.exe                    pltotf.exe                    
a5bookle.exe                  htxelatex.exe                 pmpost.exe                    
a5toa4.exe                    htxetex.exe                   pmxab.exe                     
afm2afm.exe                   hyperxmp-add-bytecount.exe    pmxchords.exe                 
afm2pl.exe                    includeres.exe                pn2pdf.exe                    
afm2tfm.exe                   inimf.exe                     png22pnm.exe                  
aftopl.exe                    initex.exe                    png2bmp.exe                   
albatross.exe                 installfont-tl.exe            pooltype.exe                  
aleph.exe                     jadetex.exe                   ppltotf.exe                   
amstex.exe                    jamo-normalize.exe            prepmx.exe                    
arara.exe                     jbig2.exe                     ps2ascii.exe                  
arlatex.exe                   jfmutil.exe                   ps2eps.exe                    
asy.exe                       kanji-config-updmap-sys.exe   ps2pdf.exe                    
authorindex.exe               kanji-config-updmap-user.exe  ps2pdf12.exe                  
autoinst.exe                  kanji-config-updmap.exe       ps2pdf13.exe                  
autosp.exe                    kanji-fontmap-creator.exe     ps2pdf14.exe                  
axohelp.exe                   ketcindy.exe                  ps2pk.exe                     
bbl2bib.exe                   komkindex.exe                 ps2ps.exe                     
bbox.exe                      kpseaccess.exe                ps4pdf.exe                    
bg5conv.exe                   kpsereadlink.exe              psbook.exe                    
bg5latex.exe                  kpsestat.exe                  psjoin.exe                    
bg5pdflatex.exe               kpsewhich.exe                 psnup.exe                     
bib2gls.exe                   l3build.exe                   psresize.exe                  
bibcop.exe                    lacheck.exe                   psselect.exe                  
bibdoiadd.exe                 latex-dev.exe                 pst2pdf.exe                   
biber-ms.exe                  latex-git-log.exe             pstops.exe                    
biber.exe                     latex-papersize.exe           psviewer.exe                  
bibmradd.exe                  latex.exe                     ptex.exe                      
bibtex.exe                    latex2man.exe                 ptex2pdf.exe                  
bibtex8.exe                   latex2nemeth.exe              ptftopl.exe                   
biburl2doi.exe                latexdef.exe                  purifyeps.exe                 
bibzbladd.exe                 latexdiff-vc.exe              pygmentex.exe                 
bitmap2eps.exe                latexdiff.exe                 pythontex.exe                 
bmeps.exe                     latexindent.exe               r-mpost.exe                   
bmp2png.exe                   latexmk.exe                   r-pmpost.exe                  
bundledoc.exe                 latexpand.exe                 r-upmpost.exe                 
cachepic.exe                  latexrevise.exe               repstopdf.exe                 
cef5conv.exe                  lily-glyph-commands.exe       rpdfcrop.exe                  
cef5latex.exe                 lily-image-commands.exe       rubikrotation.exe             
cef5pdflatex.exe              lily-rebuild-pdfs.exe         rungs.exe                     
cefconv.exe                   listbib.exe                   runscript.exe                 
ceflatex.exe                  llmk.exe                      sam2p.exe                     
cefpdflatex.exe               lollipop.exe                  scor2prt.exe                  
cefsconv.exe                  ltx2crossrefxml.exe           sjisconv.exe                  
cefslatex.exe                 ltximg.exe                    sjislatex.exe                 
cefspdflatex.exe              luacsplain.exe                sjispdflatex.exe              
cfftot1.exe                   luafindfont.exe               spix.exe                      
checkcites.exe                luahbtex.exe                  splitindex.exe                
chkdvifont.exe                luajithbtex.exe               srcredact.exe                 
chklref.exe                   luajittex.exe                 sty2dtx.exe                   
chktex.exe                    lualatex-dev.exe              svn-multi.exe                 
citeproc-lua.exe              lualatex.exe                  synctex.exe                   
cjk-gs-integrate.exe          luaotfload-tool.exe           t1ascii.exe                   
cjpeg.exe                     luatex.exe                    t1asm.exe                     
cllualatex.exe                luatools.exe                  t1binary.exe                  
cluttex.exe                   lwarpmk.exe                   t1disasm.exe                  
clxelatex.exe                 m-tx.exe                      t1dotlessj.exe                
context.exe                   mag.exe                       t1lint.exe                    
contextjit.exe                make4ht.exe                   t1mac.exe                     
convbkmk.exe                  makedtx.exe                   t1rawafm.exe                  
convertgls2bib.exe            makeglossaries-lite.exe       t1reencode.exe                
cslatex.exe                   makeglossaries.exe            t1testpage.exe                
csplain.exe                   makeindex.exe                 t1unmac.exe                   
ctan-o-mat.exe                makejvf.exe                   t4ht.exe                      
ctanbib.exe                   match_parens.exe              tangle.exe                    
ctangle.exe                   mathspic.exe                  teckit_compile.exe            
ctanify.exe                   mendex.exe                    tex.exe                       
ctanupload.exe                mex.exe                       tex2aspc.exe                  
ctie.exe                      mf-nowin.exe                  tex2xindy.exe                 
ctwill-refsort.exe            mf.exe                        tex4ebook.exe                 
ctwill-twinx.exe              mf2pt1.exe                    tex4ht.exe                    
ctwill.exe                    mflua-nowin.exe               texaccents.exe                
cweave.exe                    mflua.exe                     texcount.exe                  
de-macro.exe                  mfluajit-nowin.exe            texdef.exe                    
depythontex.exe               mfluajit.exe                  texdiff.exe                   
detex.exe                     mfplain.exe                   texdirflatten.exe             
devnag.exe                    mft.exe                       texdoc.exe                    
deweb.exe                     mk4ht.exe                     texdoctk.exe                  
diadia.exe                    mkgrkindex.exe                texexec.exe                   
digestif.exe                  mkjobtexmf.exe                texfot.exe                    
disdvi.exe                    mkocp.exe                     texhash.exe                   
djpeg.exe                     mkofm.exe                     texindy.exe                   
dosepsbin.exe                 mkpic.exe                     texliveonfly.exe              
doubside.exe                  mkt1font.exe                  texloganalyser.exe            
dt2dv.exe                     mktexfmt.exe                  texlogfilter.exe              
dv2dt.exe                     mktexlsr.exe                  texlogsieve.exe               
dvi2tty.exe                   mktexmf.exe                   texlua.exe                    
dviasm.exe                    mktexpk.exe                   texluac.exe                   
dvibook.exe                   mktextfm.exe                  texluajit.exe                 
dviconcat.exe                 mktexupd.exe                  texluajitc.exe                
dvicopy.exe                   mllatex.exe                   texmfstart.exe                
dvidvi.exe                    mltex.exe                     texosquery-jre5.exe           
dvigif.exe                    mmafm.exe                     texosquery-jre8.exe           
dvihp.exe                     mmpfb.exe                     texosquery.exe                
dviinfox.exe                  mpost.exe                     texplate.exe                  
dvilj.exe                     mptopdf.exe                   texsis.exe                    
dvilj2p.exe                   msxlint.exe                   texview.exe                   
dvilj4.exe                    mtxrun.exe                    texworks.exe                  
dvilj4l.exe                   mtxrunjit.exe                 tftopl.exe                    
dvilj6.exe                    multibibliography.exe         thumbpdf.exe                  
dvilualatex-dev.exe           musixflx.exe                  tie.exe                       
dvilualatex.exe               musixtex.exe                  tif22pnm.exe                  
dviluatex.exe                 odvicopy.exe                  tiff2png.exe                  
dviout.exe                    odvitype.exe                  tlaunch.exe                   
dvipdfm.exe                   ofm2opl.exe                   tlaunchmode.exe               
dvipdfmx.exe                  omfonts.exe                   tlcockpit.exe                 
dvipng.exe                    opl2ofm.exe                   tlshell.exe                   
dvipos.exe                    optex.exe                     todos.exe                     
dvips.exe                     optexcount.exe                tomac.exe                     
dviselect.exe                 ot2kpx.exe                    tounix.exe                    
dvispc.exe                    otangle.exe                   ttf2afm.exe                   
dvisvgm.exe                   otfinfo.exe                   ttf2kotexfont.exe             
dvitodvi.exe                  otftotfm.exe                  ttf2pk.exe                    
dvitomp.exe                   otp2ocp.exe                   ttf2tfm.exe                   
dvitype.exe                   outocp.exe                    ttfdump.exe                   
e2pall.exe                    ovf2ovp.exe                   ttftotype42.exe               
ebb.exe                       ovp2ovf.exe                   twill.exe                     
ebong.exe                     pamphletangler.exe            type1afm.exe                  
eplain.exe                    patgen.exe                    ulqda.exe                     
eps2eps.exe                   pbibtex.exe                   unzip.exe                     
epsffit.exe                   pdf2dsc.exe                   upbibtex.exe                  
epspdf.exe                    pdf2ps.exe                    updmap-sys.exe                
epspdftk.exe                  pdfannotextractor.exe         updmap-user.exe               
epstopdf.exe                  pdfatfi.exe                   updmap.exe                    
eptex.exe                     pdfattach.exe                 updvitomp.exe                 
etex.exe                      pdfclose.exe                  updvitype.exe                 
euptex.exe                    pdfcrop.exe                   uplatex-dev.exe               
exceltex.exe                  pdfcslatex.exe                uplatex.exe                   
extconv.exe                   pdfcsplain.exe                upmendex.exe                  
extractbb.exe                 pdfdde.exe                    upmpost.exe                   
extractres.exe                pdfdetach.exe                 uppltotf.exe                  
fc-cache.exe                  pdfetex.exe                   uptex.exe                     
fc-cat.exe                    pdffonts.exe                  uptftopl.exe                  
fc-list.exe                   pdfimages.exe                 urlbst.exe                    
fc-match.exe                  pdfinfo.exe                   utf8mex.exe                   
fc-pattern.exe                pdfjadetex.exe                vftovp.exe                    
fc-query.exe                  pdflatex-dev.exe              vlna.exe                      
fc-scan.exe                   pdflatex.exe                  vpe.exe                       
fc-validate.exe               pdflatexpicscale.exe          vpl2ovp.exe                   
fig4latex.exe                 pdfmex.exe                    vpl2vpl.exe                   
findhyph.exe                  pdfopen.exe                   vptovf.exe                    
fmtutil-sys.exe               pdfopt.exe                    weave.exe                     
fmtutil-user.exe              pdfseparate.exe               webquiz.exe                   
fmtutil.exe                   pdftex.exe                    wofm2opl.exe                  
fragmaster.exe                pdftocairo.exe                wopl2ofm.exe                  
gbklatex.exe                  pdftohtml.exe                 wovf2ovp.exe                  
gbkpdflatex.exe               pdftoppm.exe                  wovp2ovf.exe                  
getmapdl.exe                  pdftops.exe                   wrunscript.exe                
gftodvi.exe                   pdftosrc.exe                  xdvipdfmx.exe                 
gftopk.exe                    pdftotext.exe                 xelatex-dev.exe               
gftype.exe                    pdfunite.exe                  xelatex-unsafe.exe            
gregorio.exe                  pdfxmltex.exe                 xelatex.exe                   
gsftopk.exe                   pdvitomp.exe                  xetex-unsafe.exe              
gunzip.exe                    pdvitype.exe                  xetex.exe                     
gzip.exe                      pedigree.exe                  xhlatex.exe                   
hbf2gf.exe                    perltex.exe                   xindex.exe                    
hilatex.exe                   pfarrei.exe                   xindy-lisp.exe                
hishrink.exe                  pfb2pfa.exe                   xindy.exe                     
histretch.exe                 pk2bm.exe                     xml2pmx.exe                   
hitex.exe                     pkfix-helper.exe              xmltex.exe                    
ht.exe                        pkfix.exe                     yplan.exe                     
htcontext.exe                 pktogf.exe                    zip.exe                       
htlatex.exe                   pktype.exe                    
htmex.exe                     platex-dev.exe                
httex.exe                     platex.exe                    
```

<br>

# Invoke `pdftoppm.exe` in MATLAB to batch convert PDF files

If we want to convert all `.pdf` files in the current folder to `.png` files, we could use MATLAB  `system` function [[2]](#ref) to invoke `pdftoppm.exe`, realising batch conversion:

```matlab
clc,clear,close all

pdfFiles = dir("*.pdf");

for i = 1:numel(pdfFiles)
    pdfName = pdfFiles(i).name;
    disp(pdfName)
    system(sprintf('pdftoppm -png -r 600 "%s" "%s"', ...
        pdfName,pdfName(1:end-4)));
end
```

<br>

<div id="ref"></div>

**References**

[1] [pdftoppm - XpdfReader](https://www.xpdfreader.com/pdftoppm-man.html).

[2] [`system`: Execute operating system command and return output - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/system.html).

