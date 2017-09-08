%-------------------------------------------------------
% limecv.cls
%
% A XeLaTeX document class
%
%
% This file may be distributed and/or modified under the
% conditions of the GPL-3.0 License, a version can be 
% found in the GitHub repository:
%
%    https://github.com/opieters/limecv
%
% Maintainer: Olivier Pieters
% me (at) olivierpieters (dot) be

\def\fileversion{0.1}
\def\filedate{2017/09/03}

% Changelog
%
% v0.1: initial release
%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{limecv}[\filedate\space Version%
  \fileversion\space by Olivier Pieters]

\RequirePackage{ifxetex}
\RequirePackage{xparse}
% complex length calculations
\RequirePackage{calc}
\RequirePackage{xcolor}
\RequirePackage{tabularx}


%-------------------------------------------------------


%-------------------------------------------------------
% pass document options to article class, which forms 
% base of this document class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%-------------------------------------------------------
%
%   define colours
%   %%%%%%%%%%%%%%
%

\definecolor{cvGreen}{HTML}{357F2D}
\definecolor{cvGreenLight}{HTML}{b8e4b3}
\definecolor{cvRed}{HTML}{7f2d35}

\definecolor{cvDark}{HTML}{2F3142}
\definecolor{cvAccent}{HTML}{474A65}

%-------------------------------------------------------
%
%   misc
%   %%%%
%
% needed?
\RequirePackage{hyperref}
\RequirePackage{url}

\newcolumntype{L}[1]{>{\raggedright\let\newline\\%
  \arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\%
  \arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\%
  \arraybackslash\hspace{0pt}}m{#1}}

\NewDocumentCommand{\cvComma}{}{,}

% http://tex.stackexchange.com/questions/63223
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\@IfNoValueOrEmptyTF}%
  {mmm}{\IfNoValueTF{#1}{#2}{
%   Order: |{argument}{if empty}{if not empty}|
    \tl_if_empty:nTF {#1} {#2} {#3}%
   }
}
\ExplSyntaxOff

% https://tex.stackexchange.com/questions/87638
\def\getStringLength#1#2{%
  \begingroup\@tempcnta\z@
  \let\x\g@tStringLength
  \ifx\g@tStringLength#1\g@tStringLength
    \def\x##1\g@tStringLength{\endgroup\def#2{0}}%
  \fi
  \x#2#1\g@tStringLength
}
\def\g@tStringLength#1#2#3{%
  \advance\@tempcnta\@ne
  \ifx\g@tStringLength#3%
    \edef#1{\endgroup\def\noexpand#1{\the\@tempcnta}}#1%
  \else
    \expandafter\g@tStringLength\expandafter#1%
    \expandafter#3%
  \fi
}

%-------------------------------------------------------
%
%   drawing
%   %%%%%%%
%
% needed?
\RequirePackage{tikz}
\RequirePackage{graphicx}

\usetikzlibrary{%
  calc,
  positioning,
  fit,
  arrows.meta,
  backgrounds,
  matrix,
  node-families}

%-------------------------------------------------------
%
%   XeLaTeX specific
%   %%%%%%%%%%%%%%%%
\ifxetex
  \RequirePackage{fontspec}  
  \RequirePackage{fontawesome}

  % set fonts
  \setmainfont[Numbers={Monospaced}]{Fira Sans}
  \setsansfont{Fira Sans}
  \setmonofont{Fira Mono}
  \newfontfamily{\cv@FA}{FontAwesome}

  % define some missing icons
  \ProvideDocumentCommand{\faAddressCard}{}{{\cv@FA%
    \symbol{"F2B9}}}
  \ProvideDocumentCommand{\faVcard}{}{{\cv@FA%
    \symbol{"F2BB}}}
  \ProvideDocumentCommand{\faMicrochip}{}{{\cv@FA%
    \symbol{"F2DB}}}
  % future possibility: https://github.com/xdanaux/moderncv/blob/2033517d3f29f9c16af1b3421d52f281e94aa2a5/moderncviconsmarvosym.sty
  \NewDocumentCommand{\cv@XeOnly}{m}{#1}
\else
  \NewDocumentCommand{\cv@XeOnly}{m}{}
\fi

%-------------------------------------------------------
%
%   page layout
%   %%%%%%%%%%%
%
% for now, only A4 paper is supported
\pagenumbering{gobble}
\RequirePackage{parskip}

\newlength{\colsep}
\setlength{\colsep}{0.25cm} % 2 times column separation!

\newlength\nodesep 
\setlength\nodesep{0.75cm}
\newlength\nodediameter 
\setlength\nodediameter{2pt}

\newlength\headericonwidth
\ifxetex
  \setlength{\headericonwidth}{%
    \maxof{\widthof{\faBriefcase}}{\widthof{%
      \faGraduationCap}}}
\else
  \setlength{\headericonwidth}{0pt}
\fi

\newlength\margin
\setlength\margin{1cm}

\newlength\sidewidth
\setlength\sidewidth{0.3\paperwidth-\margin}

\newlength\mainwidth
\setlength\mainwidth{\paperwidth-4\margin-\sidewidth}

\newlength{\timedotsep} 
\setlength{\timedotsep}{0.4cm}

\newlength{\startendsep} 
\setlength{\startendsep}{0.3cm}

\newlength{\sectionsep}
\setlength{\sectionsep}{0.4cm}

\newlength\tablesepwidth
\setlength{\tablesepwidth}{0.3cm}

\newlength\coverletterheight
\setlength\coverletterheight{\sidewidth}

\newlength\coverletterwidth
\setlength\coverletterwidth{\mainwidth+3\margin}

%-------------------------------------------------------
%
%   TikZ styling
%   %%%%%%%%%%%%
% 

\tikzset{
  interesticon/.style = {%
    below=0.4cm of text,
    minimum width=3em
  },
  interesttext/.style = {%
    below=0cm of icon
  },
  timedottext/.style = {%
    black,
  },
  eventdottext/.style = {%
    text width=\mainwidth-\timedotsep,
    black,
    %text depth=0pt,
    anchor=north west,
  },
  invisibletimedot/.style = {%
    circle,
    minimum width=3pt,
    anchor=center
  },
  timedot/.style = {%
    invisibletimedot,
    draw,
    minimum width=3pt,
    fill,
    black,
  },
  eventdot/.style = {%
    fill=black,
    circle,
    minimum width=2\nodediameter
  },
  contactIcon/.style={%
    minimum height=\baselineskip,
  },
  contactText/.style={%
    minimum height=\baselineskip,
    text depth=0pt,
  },
  headerIcon/.style={%
    minimum width=\headericonwidth,
    anchor=center,
  },
  skillLevel/.style={},
  languageText/.style={},
  skillText/.style={},
  progressArea/.style={%
    minimum width=5em,
    minimum height=0.75em,
    rectangle,
    draw,
    cvGreen},
  progressBar/.style={%
    minimum height=0.75em,
    rectangle,
    draw,
    fill,
    cvGreen,
    anchor=west},
  sectionTitle/.style={%
    anchor=north west,
    align=left,
  },
  sectionEduText/.style={%
    eventdottext,
    anchor=north west
  },
}

%-------------------------------------------------------
%
%   New styling commands
%   %%%%%%%%%%%%%%%%%%%%
%

% based on: 
%   https://tex.stackexchange.com/questions/65731
% alternative: 
%   https://tex.stackexchange.com/questions/15119
\NewDocumentCommand{\cvhrulefill}{}{{\color{cvGreen}%
  \leavevmode\leaders\hrule height 1pt\hfill\kern\z@}}

\newcommand*\ruleline[1]{\par\noindent\raisebox{.6ex}{%
  \makebox[\linewidth]{\cvhrulefill\hspace{1ex}%
  \raisebox{-.6ex}{#1}\hspace{1ex}\cvhrulefill}}}

\usepackage{xstring}
\NewDocumentCommand{\cvSection}{m}{\Large\textbf{%
  \StrChar{#1}{1}\StrGobbleLeft{#1}{1}}}

\newcount\my@repeat@count
\newcommand{\cvSkill}[1]{%
  \begingroup
  \my@repeat@count=\z@
  \@whilenum\my@repeat@count<#1\do{\faCircle\advance%
    \my@repeat@count\@ne}%
  \my@repeat@count=\numexpr5-\z@\relax
  \@whilenum\my@repeat@count>#1\do{\faCircleO\advance%
    \my@repeat@count\m@ne}%
  \endgroup
}

% https://tex.stackexchange.com/questions/37709
\long\def\ifnodedefined#1#2#3{%
  \@ifundefined{pgf@sh@ns@#1}{#3}{#2}%
}

\newcommand{\cv@Title}[2]{%
  \ifnodedefined{last item \the\value{lastItem}}{%
    \node[%
      below=0.6cm of last item %
        \the\value{lastItem}.south west,
      sectionTitle] 
      (title \the\value{titleNext}) 
      {\begingroup\edef\y{\endgroup%
      \cvSection\bgroup\noexpand\kleft{%
        \extract{#1}{1}}}%
      \y\StrGobbleLeft{#1}{1}\egroup};
    \node[left=\timedotsep of title %
      \the\value{titleNext},headerIcon] {#2};
    \node[
      below=0.6cm of last item %
        \the\value{lastItem}.south west,
      sectionTitle] 
      (title \the\value{titleNext} dummy) {%
        \phantom{\cvSection{Education}}};
    \begin{scope}[on background layer]
      \draw[line width=2pt,cvGreen] 
        let \p1=(title \the\value{titleNext} %
                 dummy.south west), 
            \p2=(current page.east) in 
        (\x1,\y1-0.1cm) to (\x2,\y1-0.1cm);
    \end{scope}
  }{%
    \node[sectionTitle] at (0,0) (title %
      \the\value{titleNext})
    {\begingroup\edef\y{\endgroup%
    \cvSection\bgroup\noexpand\kleft{\extract{#1}{1}}}%
    \y\StrGobbleLeft{#1}{1}\egroup};
    \node[
      left=\timedotsep of title \the\value{titleNext},
      headerIcon] 
      {#2};
    \begin{scope}[on background layer]
      \draw[line width=2pt,cvGreen] 
        let \p1=(title \the\value{titleNext}%
                 .south west), 
            \p2=(current page.east) in 
        (\x1,\y1-0.1cm) to (\x2,\y1-0.1cm);
    \end{scope}
  }%
  \stepcounter{titlePrev}%
  \stepcounter{titleNext}
}

\NewDocumentCommand{\cv@EndSectionDraw}{}{
  \draw (start) to (end.center);}

\NewDocumentCommand{\cvItem}{m}{%
  \ifnodedefined{item \the\value{itemPrev}}{%
    \node[%
      below=\sectionsep of item %
        \the\value{itemPrev}.south west,
      eventdottext] 
      (item \the\value{itemNext} header) 
      {\phantom{Evening}};
    \node[%
      below=\sectionsep of item %
        \the\value{itemPrev}.south west,
      sectionEduText] 
      (item \the\value{itemNext}) 
      {#1};
    \node[%
      left=\timedotsep of item %
        \the\value{itemNext} header,
      timedot] 
      {};
  }{
    \node[%
      below=\sectionsep of title %
        \the\value{titlePrev}.south west,
      eventdottext] 
      (item \the\value{itemNext} header) 
      {\phantom{Evening}};
    \node[
      below=\sectionsep of title %
        \the\value{titlePrev}.south west,
      sectionEduText] 
      (item \the\value{itemNext}) 
      {#1};
    \node[
      left=\timedotsep of item %
        \the\value{itemNext} header,
      timedot] 
      (start) 
      {};
  }
  \node[
    left=\timedotsep of item %
      \the\value{itemNext}.south west,
    invisibletimedot] 
    (end) 
    {};
  \stepcounter{itemPrev}
  \stepcounter{itemNext}
}

\NewDocumentCommand{\cvSkillTwo}{smmmm}{%
  \IfBooleanTF{#1}{% if starred version
    \cvSkill{#2} & #3 & \cvSkill{#4} & #5 \\[1ex]
  }{% if normal version
    \cvSkill{#2} \pgfmatrixnextcell 
      #3 \pgfmatrixnextcell
    \cvSkill{#4} \pgfmatrixnextcell 
      #5 \\ 
  }%
}

\NewDocumentCommand{\cvSkillOne}{smm}{%
  \IfBooleanTF{#1}{% if starred version
    \cvSkill{#2} & #3 \\
  }{% if normal version
    \cvSkill{#2} \pgfmatrixnextcell #3 \\ 
  }%
}

%-------------------------------------------------------
%
%   Counters
%   %%%%%%%%
% 
\newcounter{titlePrev}
\setcounter{titlePrev}{0}
\newcounter{titleNext}
\setcounter{titleNext}{1}
\newcounter{itemPrev}
\setcounter{itemPrev}{0}
\newcounter{itemNext}
\setcounter{itemNext}{1}

\newcounter{lastItem}
\setcounter{lastItem}{1}

\newcounter{languages}
\setcounter{languages}{1}

\newcounter{cvInterestCounter}
\setcounter{cvInterestCounter}{1}

%-------------------------------------------------------
%
%   CV environments
%   %%%%%%%%%%%%%%%
% 

\newenvironment{cvEducation}{%
  \cv@Title{Education}{\faGraduationCap}
  \setcounter{itemPrev}{0}
  \setcounter{itemNext}{1}}{%
  \cv@EndSectionDraw
  \stepcounter{lastItem}
  \draw (item \the\value{itemPrev}.south west) 
    node (last item \the\value{lastItem}) {};
  }

\newenvironment{cvExperience}{%
  \cv@Title{Experience}{\faBriefcase}
  \setcounter{itemPrev}{0}
  \setcounter{itemNext}{1}}{%
  \cv@EndSectionDraw
  \stepcounter{lastItem}
  \draw (item \the\value{itemPrev}.south west) 
    node (last item \the\value{lastItem}) {};
  }

\newenvironment{cvSkills}{%
  \cv@Title{Skills}{\faStar}
  \matrix[matrix of nodes,
          below=0.6cm of title %
            \the\value{titlePrev}.south west,
          anchor=north west,
          column sep=6pt,
          row sep=6pt,
          every node/.style={Text Depth=tdSkills},
          column 1/.style={%
            anchor=east,
            align=left,
            skillLevel},
          column 2/.style={%
            anchor=west,
            skillText},
          column 3/.style={%
            anchor=east,
            align=left},
          column 4/.style={%
            anchor=west,
            skillText}] (skills) \bgroup%
}{%
  \\\egroup;
  \stepcounter{lastItem}
  \draw (skills.south west) %
    node (last item \the\value{lastItem}) {};
}

\newenvironment{cvSkills*}{%
  \cv@Title{Skills}{\faStar}
  \node[
    below=0.6cm of title \the\value{titlePrev}%
      .south west,
    anchor=north west] (skills) %
    \bgroup\begin{tabular}{@{}llll@{}}%
}{%
  \end{tabular}\egroup;
  \stepcounter{lastItem}
  \draw (skills.south west) node (last item \the\value{lastItem}) {};
}

\newenvironment{cvReferences}{%
  \cv@Title{References}{\faLink}
  \node[
    below=0.6cm of title \the\value{titlePrev}.south west,
    anchor=north west,
    ] (cvReferences) \bgroup %
}{%
  \egroup;
  \stepcounter{lastItem}
  \draw (cvReferences.south west) node (last item \the\value{lastItem}) {};
}

% first name, second name, picture, position

\newenvironment{cvProfile}{%
  \ruleline{Profile}
}{%
  \vspace{4pt}
}

\newif\ifcvcontactfirst
\newenvironment{cvContact}{%
  \ruleline{Contact}%
  \vspace{4pt}
  
  \global\cvcontactfirstfalse

  \cv@ContactTemplate{\cvContactAddress}{\faMapMarker}
  \cv@ContactTemplate{\cvContactPhone}{\faPhone}
  
  \cv@ContactTemplateLink{\cvContactEmail}{\faEnvelope}
  \cv@ContactTemplateLink{\cvContactWebsite}{\faGlobe}
  \cv@ContactTemplateLink{\cvContactGithub}{\faGithub}
  \cv@ContactTemplateLink{\cvContactLinkedin}{\faLinkedinSquare}
  \cv@ContactTemplateLink{\cvContactTwitter}{\faTwitter}
  \cv@ContactTemplateLink{\cvContactKeybase}{\faKey}

  % flags source: https://commons.wikimedia.org/wiki/Category:SVG_sovereign_state_flags


  \begin{tikzpicture}[every node/.style={inner sep=0pt, outer sep=0pt}]
    \matrix [
      column 1/.style={anchor=center},
      column 2/.style={anchor=west,align=left},
      column sep=5pt,
      row sep=5pt,
      inner sep=0pt, 
      outer sep=0pt] (contact) \bgroup
}{%
  \\\egroup; % \\ required, does not compile otherwise
  \end{tikzpicture}%
  \vspace{4pt}
}

\newenvironment{cvSideBar}{%
  \begin{tikzpicture}[remember picture,overlay]
    \draw (current page.center) ++(-\paperwidth/2,\paperheight/2) node (h1) {};
    \draw (h1) ++(\sidewidth+2\margin,-\paperheight) node (h2) {};
    \draw[fill=cvGreenLight,cvGreenLight] (h1) rectangle (h2);
  \end{tikzpicture}
  \begin{minipage}{\sidewidth}
    \vspace*{2cm}
    \begin{center}
}{%
    \end{center}
  \end{minipage}%
}

\newenvironment{cvSideBar*}{%
  \begin{tikzpicture}[remember picture,overlay]
    \draw (current page.center) ++(\paperwidth/2,\paperheight/2) node (h3) {};
    \draw (h3) ++(-\sidewidth-2\margin,-\paperheight) node (h4) {};
    \draw[fill=cvGreenLight,cvGreenLight] (h3) rectangle (h4);
  \end{tikzpicture}
  \begin{minipage}{\sidewidth}
    %\vspace*{2cm}
    \begin{center}
}{%
    \end{center}
  \end{minipage}%
}



\NewDocumentEnvironment{cvMainContent}{}{%
  %  \begin{scope}[on background layer]
  %    \node [note,below right=-5mm of if, anchor=north west, text width=2cm] (note1) {using a note here};
  %  %you may also use align = center instead of text width = ...
  %  \end{scope}

  \begin{tikzpicture}[every node/.style={inner sep=0pt,outer sep=0pt},remember picture,overlay,shift={($(current page.north west)+(\sidewidth+3\margin+\timedotsep,-\margin)$)}]
}{%
  \end{tikzpicture}
}

\NewDocumentEnvironment{cvMainContent*}{}{%
  \stepcounter{titlePrev}
  \stepcounter{titleNext}
    \begin{tikzpicture}[%
      every node/.style={inner sep=0pt,outer sep=0pt},
      remember picture,
      overlay,
      shift={($(current page.north west)+(\margin+\timedotsep,-\margin)$)}]
}{%
    \end{tikzpicture}%
}
  
\newif\ifcv@interestLong
\cv@interestLongtrue

\RequirePackage{pdftexcmds}

\NewDocumentEnvironment{cvInterests}{o}{%
  % set defaults
  \cv@interestLongtrue
  % parse optional arguments
  \@IfNoValueOrEmptyTF{#1}{}{%
    \ifnum\pdf@strcmp{#1}{short}=\z@ %
      \cv@interestLongfalse%
    \else %
      \ifnum\pdf@strcmp{#1}{juhu}=\z@ %
      \cv@interestLongtrue%
      \else %
      % add \MessageBreak
        \ClassError{limecv}{Unkown option `#1' for cvInterests environment.}{Only `long' and `short' are valid options for this environment.}%
      \fi%
    \fi%
  }
  \NewDocumentCommand{\cvInterest}{mm}{%
    % parse optinal argument if present
    \ifnum\value{cvInterestCounter}>1 %
      \node[interesticon] (icon) {##1};
      \node[interesttext] (text) {##2};
    \else
      \node[] (icon) {##1};
      \node[interesttext] (text) {##2};
    \fi
    \stepcounter{cvInterestCounter}
  }
  % TODO: make this work!!
  \NewDocumentCommand{\cvInterestsPersonal}{}{\faUser\ Personal}
  \NewDocumentCommand{\cvInterestsProfessional}{}{\faWork\ Professional}
  \ruleline{Interests}%
  \vspace{4pt}
  \begin{tikzpicture}
    %TODO: make long/short options do something differently!
}{%
  \end{tikzpicture}
}

\newif\ifcv@projectImage
\cv@projectImagefalse
\newif\ifcv@projectLink
\cv@projectLinkfalse

\newcounter{cv@project}
\setcounter{cv@project}{1}

\define@key{cv@Project}{image}{%
  \global\def\cv@projectImage{#1}%
  \cv@projectImagetrue}
\define@key{cv@Project}{link}{%
  \global\def\cv@projectLink{#1}%
  cv@projectLinktrue}

\NewDocumentEnvironment{cvProjects}{}{%
  \ruleline{Projects}%
  \vspace{4pt}

  \NewDocumentCommand{\cvProject}{omm}{%
    \setkeys{cv@Project}{##1}
    \draw () node {};
  }
  \begin{tikzpicture}
}{
  \end{tikzpicture}
}

% https://tex.stackexchange.com/questions/274479
% https://tex.stackexchange.com/questions/34563/precision-copyfitting-in-xcoffin
\newcommand{\getLeftSideBearing}[1]{\the\XeTeXglyphbounds1\XeTeXglyphindex"#1" }
\newcommand{\getRightSideBearing}[1]{\the\XeTeXglyphbounds3\XeTeXglyphindex"#1" }
\def\kright#1{\leavevmode #1\kern-\XeTeXglyphbounds3 \the\XeTeXcharglyph`#1 }
\def\kleft#1{\leavevmode \kern-\XeTeXglyphbounds1 \the\XeTeXcharglyph`#1 #1}

% removes left bearing of nth character:
\newlength\cv@bearingLeft
\newlength\cv@bearingRight

% string - nth char
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\extract}{mm}{%
  \tl_item:nn { #1 } { #2 }%
}
\ExplSyntaxOff

\newenvironment{cvCoverLetter}{%
  \begin{tikzpicture}[remember picture,overlay, every node/.style={inner sep=0cm,outer sep=0cm}]
    % set lengths
    \setlength{\cv@bearingLeft}{\getLeftSideBearing{\extract{\cv@FirstName}{0}}}
    \setlength{\cv@bearingRight}{\getRightSideBearing{\extract{\pgfkeysvalueof{/cv/info/last name}}{-1}}}

    % draw green background
    \begin{scope}[on background layer]
      \draw (current page.center) ++(-\paperwidth/2,\paperheight/2) node (h5) {};
      \draw (h5) ++(\paperwidth,-\coverletterheight) node (h6) {};
      \draw[fill=cvGreenLight,cvGreenLight] (h5) rectangle (h6);
    \end{scope}
    \draw (current page.north east) ++(-0.5\paperwidth+0.5\coverletterwidth,-\coverletterheight/2) node (h7) {};
    \node[anchor=east] at (h7) (cv cover letter name){%
      \fontsize{50}{60}\selectfont
      % trick to expand argument such that `kleft` sees an alphabetic constant (i.e. a single letter)
      \begingroup\edef\y{\endgroup%
        \noexpand\kleft{\cv@FirstNameLetter}}%
      \y
      \StrGobbleLeft{\pgfkeysvalueof{/cv/info/first name}}{1}\space
      \StrGobbleRight{\pgfkeysvalueof{/cv/info/last name}}{1}
      % same trick
      % trick to expand argument such that `kleft` sees an alphabetic constant (i.e. a single letter)
      \begingroup\edef\y{\endgroup%
        \noexpand\kright{\cv@LastNameLetter}}%
      \y
      };
    \node[%
      align=right,
      cvAccent,
      below=10pt of cv cover letter name.south east,
      anchor=north east]{%
        \StrGobbleRight{\pgfkeysvalueof{/cv/info/position}}{1}
    \begingroup\edef\y{\endgroup%
      \noexpand\kright{\cv@PositionLetter}}%
    \y};
    
    \begin{scope}[on background layer]
      \draw[line width=3pt,cvGreen] 
         (cv cover letter name.south west) to 
         (cv cover letter name.south east);
    \end{scope}
  \end{tikzpicture}

  \vspace{\dimexpr\coverletterheight\relax}
  
  \begin{center}
    \begin{minipage}{\coverletterwidth}
      \today
      
      \vspace{\baselineskip}

      \NewDocumentCommand{\cvBeneficiary}{m}{%
        \setkeys{cvCoverLetter}{##1}
        \begin{tabular}{@{}l}
          \@IfNoValueOrEmptyTF{%
            \cv@coverletterName}{}{%
            \MakeUppercase{\cv@coverletterName}} %
          \@IfNoValueOrEmptyTF{%
            \cv@coverletterCompany}{}{\\ %
            \cv@coverletterCompany} %
          \@IfNoValueOrEmptyTF{%
            \cv@coverletterPosition}{}{\\ %
            \cv@coverletterPosition} %
          \@IfNoValueOrEmptyTF{%
            \cv@coverletterAddressLineA}{}{\\ %
            \cv@coverletterAddressLineA} %
          \@IfNoValueOrEmptyTF{%
            \cv@coverletterAddressLineB}{}{\\ %
            \cv@coverletterAddressLineB} %
          \@IfNoValueOrEmptyTF{%
            \cv@coverletterAddressLineC}{}{\\ %
            \cv@coverletterAddressLineC} %
        \end{tabular}%
        \vspace{\margin}
      }
      \NewDocumentCommand{\cvFullName}{}{%
        \pgfkeysvalueof{/cv/info/first name} %
        \pgfkeysvalueof{/cv/info/last name}
      }
}{%
    \end{minipage}
  \end{center}
}

%-------------------------------------------------------
%
%   Key-value parsing structure
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%\pgfkeys{/cv/.is family}
\newif\ifcv@refStored
\newif\ifcv@refName
\newif\ifcv@refPosition
\newif\ifcv@refCompany
\newif\ifcv@refAddressLineA
\newif\ifcv@refAddressLineB
\newif\ifcv@refAddressLineC
\newif\ifcv@refWorkPhone
\newif\ifcv@refMobilePhone
\pgfkeys{/cv/references/.is family,
         /cv/references/.unknown/.style = %
         {\pgfkeyscurrentpath/\pgfkeyscurrentname/%
         .initial = #1}}
\pgfkeys{/cv/references/name/.is if=cv@refName}
\pgfkeys{/cv/references/name=false}
\pgfkeys{/cv/references/position/.is if=cv@refPosition}
\pgfkeys{/cv/references/position=false}
\pgfkeys{/cv/references/company/.is if=cv@refCompany}
\pgfkeys{/cv/references/copmany=false}
\pgfkeys{/cv/references/address line 1/.is if=%
  cv@refAddressLineA}
\pgfkeys{/cv/references/address line 1=false}
\pgfkeys{/cv/references/address line 2/.is if=%
  cv@refAddressLineB}
\pgfkeys{/cv/references/address line 2=false}
\pgfkeys{/cv/references/address line 3/.is if=%
  cv@refAddressLineC}
\pgfkeys{/cv/references/address line 3=false}
\pgfkeys{/cv/references/work phone/.is if=%
  cv@refWorkPhone}
\pgfkeys{/cv/references/work phone=false}
\pgfkeys{/cv/references/mobile phone/.is if=%
  cv@refMobilePhone}
\pgfkeys{/cv/references/mobile phone=false}
\pgfkeys{/cv/references/value stored/.is if=%
  cv@refStored}
\pgfkeys{/cv/references/value stored=false}
\pgfkeys{/cv/info/.is family,
         /cv/info/.unknown/.style = %
         {\pgfkeyscurrentpath/\pgfkeyscurrentname/%
         .initial = #1}}

% Note that the argument must be expandable,
% or use xkvltxp package before \documentclass (see 
% manual of xkeyval)
\RequirePackage{xkeyval}

% For simple key-value commands, keyval would suffice

% default key values
\def\cv@refAName{}
\def\cv@refBName{}
\def\cv@refACompany{}
\def\cv@refBCompany{}
\def\cv@refAPosition{}
\def\cv@refBPosition{}
\def\cv@refAAddressLineA{}
\def\cv@refBAddressLineA{}
\def\cv@refAAddressLineB{}
\def\cv@refBAddressLineB{}
\def\cv@refAAddressLineC{}
\def\cv@refBAddressLineC{}
\def\cv@refAPhoneWork{}
\def\cv@refBPhoneWork{}
\def\cv@refAMobilePhone{}
\def\cv@refBMobilePhone{}

% cover letter keys
\def\cv@coverletterName{}
\def\cv@coverletterCompany{}
\def\cv@coverletterPosition{}
\def\cv@coverletterAddressLineA{}
\def\cv@coverletterAddressLineB{}
\def\cv@coverletterAddressLineC{}

% keys
\define@key{cvAddReferenceA}{name}{%
  \global\def\cv@refAName{#1}%
  \pgfkeys{/cv/references/name = true}}
\define@key{cvAddReferenceA}{company}{%
  \global\def\cv@refACompany{#1}%
  \pgfkeys{/cv/references/company = true}}
\define@key{cvAddReferenceA}{position}{%
  \global\def\cv@refAPosition{#1}%
  \pgfkeys{/cv/references/position = true}}
\define@key{cvAddReferenceA}{address line 1}{%
  \global\def\cv@refAAddressLineA{#1}%
  \pgfkeys{/cv/references/address line 1 = true}}
\define@key{cvAddReferenceA}{address line 2}{%
  \global\def\cv@refAAddressLineB{#1}%
  \pgfkeys{/cv/references/address line 2 = true}}
\define@key{cvAddReferenceA}{address line 3}{%
  \global\def\cv@refAAddressLineC{#1}%
  \pgfkeys{/cv/references/address line 3 = true}}
\define@key{cvAddReferenceA}{phone work}{%
  \global\def\cv@refAPhoneWork{#1}%
  \pgfkeys{/cv/references/phone work = true}}
\define@key{cvAddReferenceA}{mobile phone}{%
  \global\def\cv@refAMobilePhone{#1}%
  \pgfkeys{/cv/references/mobile phone = true}}

\define@key{cvAddReferenceB}{name}{%
  \global\def\cv@refBName{#1}%
  \pgfkeys{/cv/references/name = true}}
\define@key{cvAddReferenceB}{company}{%
  \global\def\cv@refBCompany{#1}%
  \pgfkeys{/cv/references/company = true}}
\define@key{cvAddReferenceB}{position}{%
  \global\def\cv@refBPosition{#1}%
  \pgfkeys{/cv/references/position = true}}
\define@key{cvAddReferenceB}{address line 1}{%
  \global\def\cv@refBAddressLineA{#1}%
  \pgfkeys{/cv/references/address line 1 = true}}
\define@key{cvAddReferenceB}{address line 2}{%
  \global\def\cv@refBAddressLineB{#1}%
  \pgfkeys{/cv/references/address line 2 = true}}
\define@key{cvAddReferenceB}{address line 3}{%
  \global\def\cv@refBAddressLineC{#1}%
  \pgfkeys{/cv/references/address line 3 = true}}
\define@key{cvAddReferenceB}{phone work}{%
  \global\def\cv@refBPhoneWork{#1}%
  \pgfkeys{/cv/references/phone work = true}}
\define@key{cvAddReferenceB}{mobile phone}{%
  \global\def\cv@refBMobilePhone{#1}%
  \pgfkeys{/cv/references/mobile phone = true}}

% cover letter keys
\define@key{cvCoverLetter}{name}{%
  \global\def\cv@coverletterName{#1}}
\define@key{cvCoverLetter}{company}{%
  \global\def\cv@coverletterCompany{#1}}
\define@key{cvCoverLetter}{position}{%
  \global\def\cv@coverletterPosition{#1}}
\define@key{cvCoverLetter}{address line 1}{%
  \global\def\cv@coverletterAddressLineA{#1}}
\define@key{cvCoverLetter}{address line 2}{%
  \global\def\cv@coverletterAddressLineB{#1}}
\define@key{cvCoverLetter}{address line 3}{%
  \global\def\cv@coverletterAddressLineC{#1}}

\NewDocumentCommand{\cvAddReference}{sm}{%
  \IfBooleanTF{#1}{%
    \setkeys{cvAddReferenceA}{#2}
    \pgfkeys{/cv/references/name = true}%
  }{%
    \setkeys{cvAddReferenceB}{#2}
    \ifcv@refStored%
      \begin{tabular}{@{}L{0.5\mainwidth-0.5\timedotsep-0.5\tablesepwidth}@{\hskip \tablesepwidth}L{0.5\mainwidth-0.5\timedotsep-0.5\tablesepwidth}@{}}%
        \ifcv@refName            \cv@refAName         & \cv@refBName         \fi %
        \ifcv@refCompany      \\ \cv@refACompany      & \cv@refBCompany      \fi %
        \ifcv@refPosition     \\ \cv@refAPosition     & \cv@refBPosition     \fi %
        \ifcv@refAddressLineA \\ \cv@refAAddressLineA & \cv@refBAddressLineA \fi %
        \ifcv@refAddressLineB \\ \cv@refAAddressLineB & \cv@refBAddressLineB \fi %
        \ifcv@refAddressLineC \\ \cv@refAAddressLineC & \cv@refBAddressLineC \fi %
        \ifcv@refWorkPhone    \\ \cv@refAPhoneWork    & \cv@refBPhoneWork    \fi %
        \ifcv@refMobilePhone  \\ \cv@refAMobilePhone  & \cv@refBMobilePhone  \fi %
      \end{tabular}%
      \pgfkeys{/cv/references/value stored = false}%
    \else%
      \begin{tabular}{@{}L{0.5\mainwidth-0.5\timedotsep}@{}}%
        \ifcv@refName            \cv@refBName         \fi %
        \ifcv@refCompany      \\ \cv@refBCompany      \fi %
        \ifcv@refPosition     \\ \cv@refBPosition     \fi %
        \ifcv@refAddressLineA \\ \cv@refBAddressLineA \fi %
        \ifcv@refAddressLineB \\ \cv@refBAddressLineB \fi %
        \ifcv@refAddressLineC \\ \cv@refBAddressLineC \fi %
        \ifcv@refWorkPhone    \\ \cv@refBPhoneWork    \fi %
        \ifcv@refMobilePhone  \\ \cv@refBMobilePhone  \fi %
      \end{tabular}%
    \fi%
  }%
}

%-------------------------------------------------------
%
%   Contact info commands
%   %%%%%%%%%%%%%%%%%%%%%
%
\NewDocumentCommand{\cv@ContactTemplate}{mm}{
  \NewDocumentCommand{#1}{m}{
      \ifcvcontactfirst \\ \else \global\cvcontactfirsttrue \fi\node[contactIcon]{#2}; 
        \pgfmatrixnextcell \node[contactText]{##1};
  }
}
\NewDocumentCommand{\cv@ContactTemplateLink}{mm}{
  \NewDocumentCommand{#1}{mm}{
      \ifcvcontactfirst \\ \else\global\cvcontactfirsttrue \fi\node[contactIcon]{#2}; 
        \pgfmatrixnextcell \node[contactText]{\@IfNoValueOrEmptyTF{##1}{##2}{\href{##1}{##2}}};
  }
}

%-------------------------------------------------------
%
%   ID commands
%   %%%%%%%%%%%
%
\newlength\cvPictureWidth
\setlength\cvPictureWidth{4cm}

\NewDocumentCommand{\cvID}{mmmm}{
  \@IfNoValueOrEmptyTF{#3}{}{
    \begin{tikzpicture}
      \node[
        circle,
        text=white,
        minimum size=\cvPictureWidth,
        path picture={
          \node at (path picture bounding box.center){
          \includegraphics[width=\cvPictureWidth]{#3}
          };
        }]
        {};
    \end{tikzpicture}
  }

  {\LARGE
  #1

  \vspace{0.1cm}

  #2}
  
  \vspace{0.5cm}
  
  \@IfNoValueOrEmptyTF{#4}{}{\color{cvAccent} #4}
  
  \vspace{0.5cm}
  {\globaldefs=1\relax\pgfkeys{/cv/info/first name = %
    #1}\def\cv@FirstNameLetter{\extract{#1}{1}}}
  {\globaldefs=1\relax\pgfkeys{/cv/info/last name = %
    #2}\def\cv@LastNameLetter{\extract{#2}{-1}}}
  {\globaldefs=1\relax\pgfkeys{/cv/info/position = %
    #4}\def\cv@PositionLetter{\extract{#4}{-1}}}
}

%-------------------------------------------------------
%
%   Language commands
%   %%%%%%%%%%%%%%%%%
%

\pgfkeys{/cv/languages/.is family,
/cv/languages/.unknown/.style = {\pgfkeyscurrentpath/\pgfkeyscurrentname/.initial = #1}}


\newenvironment{cvLanguages}{%
  \NewDocumentCommand{\cvLanguage}{mm}{%
    {\globaldefs=1\relax\pgfkeys{/cv/languages/lang\the\value{languages} = ##2}}
    \node[languageText]{##1}; \pgfmatrixnextcell \node[progressArea] (language \the\value{languages}) {}; \\
    \stepcounter{languages}
  }%
  \ruleline{Languages}%
  \vspace{4pt}
  \begin{tikzpicture}[every node/.style={text depth=0pt,inner sep=0pt,outer sep=0pt}]
  \matrix [
    column 1/.style={anchor=east},
    column sep=6pt,
    row sep=6pt,
    column 2/.style={anchor=west,align=left}
  ] (contact) \bgroup
}{%
  \\\egroup;
  \newcounter{languagelevel}
  \setcounter{languagelevel}{1}
  \loop\ifnum\value{languagelevel}<\value{languages}
    \draw (language \the\value{languagelevel}.west) %
      node[%
        progressBar,
        minimum width=\pgfkeysvalueof{%
        /cv/languages/lang\the\value{languagelevel}}em]%
        {};
    \stepcounter{languagelevel}
  \repeat
  \end{tikzpicture}
}

%-------------------------------------------------------
%
%   Global font colour
%   %%%%%%%%%%%%%%%%%%
%
\newcommand{\globalcolor}[1]{%
  \color{#1}\global\let\default@color\current@color
}

\AtBeginDocument{\globalcolor{cvDark}}