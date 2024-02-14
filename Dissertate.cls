% -------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "Dissertate.cls",
%     date            = "20 Oct 2023",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, Dissertate",
% --------------------------------------------------------------------

% Modified based on suchow/Dissertate (https://github.com/suchow/Dissertate)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Dissertate}[2023/10/25 v2.0 Dissertate Class]
\LoadClass[12pt, oneside, a4paper]{book}

%
% Options
%
\RequirePackage{etoolbox}

% Line spacing: dsingle/ddouble
%   Whether to use single- or doublespacing.
\newtoggle{DissertateSingleSpace}
\togglefalse{DissertateSingleSpace}
\DeclareOption{dsingle}{
    \toggletrue{DissertateSingleSpace}
    \ClassWarning{Dissertate}{Single-spaced mode on.}
}
\DeclareOption{ddouble}{\togglefalse{DissertateSingleSpace}}

\ProcessOptions\relax

% Line Spacing
%   Define two line spacings: one for the body, and one that is more compressed.
\iftoggle{DissertateSingleSpace}{
    \newcommand{\dnormalspacing}{1.2}
    \newcommand{\dcompressedspacing}{1.0}
}{
    \newcommand{\dnormalspacing}{2.0}
    \newcommand{\dcompressedspacing}{1.2}
}

% Block quote with compressed spacing
\let\oldquote\quote
\let\endoldquote\endquote
\renewenvironment{quote}
    {\begin{spacing}{\dcompressedspacing}\oldquote}
    {\endoldquote\end{spacing}}

% Itemize with compressed spacing
\let\olditemize\itemize
\let\endolditemize\enditemize
\renewenvironment{itemize}
    {\begin{spacing}{\dcompressedspacing}\olditemize}
    {\endolditemize\end{spacing}}

% Enumerate with compressed spacing
\let\oldenumerate\enumerate
\let\endoldenumerate\endenumerate
\renewenvironment{enumerate}
    {\begin{spacing}{\dcompressedspacing}\oldenumerate}
    {\endoldenumerate\end{spacing}}

% Text layout.
\RequirePackage[width=6in, a4paper]{geometry}
\usepackage{ragged2e}
%\RaggedRight
\RequirePackage{graphicx}
\usepackage{multirow}
\usepackage{fixltx2e}
\parindent 12pt
\RequirePackage{lettrine}
\RequirePackage{setspace}
\RequirePackage{verbatim}
% avoid figure in a seperate page - update
\renewcommand{\floatpagefraction}{.8}

% Japanese support - update
\usepackage{xeCJK}
\setCJKmainfont{Noto Serif CJK JP}
\setCJKsansfont{Noto Sans CJK JP}
\setCJKmonofont{Noto Sans Mono CJK JP}

% Fonts.
\usepackage{mhchem} % For easily inputing chemicals - update
\RequirePackage{color}
\RequirePackage{xcolor}
\usepackage{hyperref}
\RequirePackage{url}
\RequirePackage{amssymb}
\RequirePackage{mathspec}
\setmathsfont(Digits,Latin,Greek)[Numbers={Proportional}]{EB Garamond}
\setmathrm{EB Garamond}
\AtBeginEnvironment{tabular}{\addfontfeature{RawFeature=+tnum}}
\widowpenalty=300
\clubpenalty=300

\setromanfont[Scale=1.1]{EB Garamond}
\newfontfamily{\smallcaps}[RawFeature={+c2sc,+scmp}]{EB Garamond}
\setsansfont[Scale=MatchLowercase, BoldFont={Lato Bold}]{Lato Regular}
\setmonofont[Scale=MatchLowercase]{Source Code Pro}
\RequirePackage[labelfont={bf,sf,footnotesize,singlespacing},
                textfont={sf,footnotesize,singlespacing},
                justification={justified,RaggedRight},
                singlelinecheck=false,
                margin=0pt,
                figurewithin=chapter,
                tablewithin=chapter]{caption}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}


% Headings and headers.
\RequirePackage{fancyhdr}
\RequirePackage[md,sc,bf,small]{titlesec}
\titleformat*{\subsection}{\itshape\normalsize}

\setlength{\headheight}{15pt}
\pagestyle{plain}
\RequirePackage{titling}

% Front matter.
\setcounter{tocdepth}{1}
\usepackage[titles]{tocloft}
\usepackage[titletoc]{appendix}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\normalsize \scshape}
\renewcommand\listfigurename{Listing of figures}
\renewcommand\listtablename{Listing of tables}

% Endmatter
\renewcommand{\setthesection}{\arabic{chapter}.A\arabic{section}}

% References.
\renewcommand\bibname{References}
% use number style
%\RequirePackage[super,comma,numbers]{natbib}

% use author-year style
%\RequirePackage{natbib}
%\RequirePackage[sort&compress,comma]{natbib}

\usepackage{apacite}
%\setcitestyle{numbers}
%\renewcommand{\bibnumfmt}[1]{[#1]}
% chapter style
\RequirePackage[palatino]{quotchap}
\renewcommand*{\chapterheadstartvskip}{\vspace*{1.0\baselineskip}}
\renewcommand*{\chapterheadendvskip}{\vspace{1.3\baselineskip}}
% change the number_size
\renewcommand*{\chapnumfont}{%
  \usefont{T1}{\@defaultcnfont}{b}{n}\fontsize{80}{110}\selectfont% Default: 100/130
  \color{chaptergrey}%
}

\let\size@chapter\LARGE

% An environment for paragraph-style section.
\providecommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent\textsc{#1}%
}

% Align reference numbers so that they do not cause an indent.
\newlength\mybibindent
\setlength\mybibindent{0pt}
\renewenvironment{thebibliography}[1]
    {\chapter*{\bibname}%
     \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
     \list{\@biblabel{\@arabic\c@enumiv}}
          {\settowidth\labelwidth{\@biblabel{999}}
           \leftmargin\labelwidth
            \advance\leftmargin\dimexpr\labelsep+\mybibindent\relax\itemindent-\mybibindent
           \@openbib@code
           \usecounter{enumiv}
           \let\p@enumiv\@empty
           \renewcommand\theenumiv{\@arabic\c@enumiv}}
     \sloppy
     \clubpenalty4000
     \@clubpenalty \clubpenalty
     \widowpenalty4000%
     \sfcode`\.\@m}
    {\def\@noitemerr
      {\@latex@warning{Empty `thebibliography' environment}}
     \endlist}

% Some definitions.
\def\advisor#1{\gdef\@advisor{#1}}
\def\coadvisorOne#1{\gdef\@coadvisorOne{#1}}
\def\coadvisorTwo#1{\gdef\@coadvisorTwo{#1}}
\def\committeeInternal#1{\gdef\@committeeInternal{#1}}
\def\committeeInternalOne#1{\gdef\@committeeInternalOne{#1}}
\def\committeeInternalTwo#1{\gdef\@committeeInternalTwo{#1}}
\def\committeeExternal#1{\gdef\@committeeExternal{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeterm#1{\gdef\@degreeterm{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\department#1{\gdef\@department{#1}}
\def\field#1{\gdef\@field{#1}}
\def\university#1{\gdef\@university{#1}}
\def\universitycity#1{\gdef\@universitycity{#1}}
\def\universitystate#1{\gdef\@universitystate{#1}}
\def\programname#1{\gdef\@programname{#1}}
\def\pdOneName#1{\gdef\@pdOneName{#1}}
\def\pdOneSchool#1{\gdef\@pdOneSchool{#1}}
\def\pdOneYear#1{\gdef\@pdOneYear{#1}}
\def\pdTwoName#1{\gdef\@pdTwoName{#1}}
\def\pdTwoSchool#1{\gdef\@pdTwoSchool{#1}}
\def\pdTwoYear#1{\gdef\@pdTwoYear{#1}}
% School name and location
\university{The University of Tokyo}
\universitycity{Bunkyo}
\universitystate{Tokyo}

% School color found from UTokyoマーク表現規定書:
% https://www.u-tokyo.ac.jp/content/400102717.pdf

% Color from the mark of UTokyo
\definecolor{SchoolColor}{rgb}{0.2549, 0.5412, 0.8706} % 
\definecolor{chaptergrey}{rgb}{0.95686, 0.66667, 0} % for chapter numbers

\hypersetup{
    colorlinks,
    citecolor=SchoolColor,
    filecolor=black,
    linkcolor=black,
    urlcolor=SchoolColor,
}

\renewcommand{\frontmatter}{
	\input{frontmatter/personalize}
	\maketitle
	\copyrightpage
	\abstractpage
    \contentspage
	% \listoffigures % optional
	\dedicationpage
	\acknowledgments
}

\renewcommand{\maketitle}{
    \pagenumbering{roman}
    \setcounter{page}{0}
	\thispagestyle{empty}
	%\vspace*{\fill}
	%\vspace{100pt}   
        \vspace*{10pt}
	\begin{center}
        \LARGE
        \textsc{博士論文}
        \vspace{100pt}
        
        \setstretch{1.5}
 	\LARGE {\thetitle}  \\
        \Large
        \vspace{10pt}
        \textsc{(和訳)}\\
%	\Huge \linespread{3}\textcolor{SchoolColor}{\thetitle} \normalsize  \\
        \linespread{1}
	\vspace{200pt}
        \Large \theauthor \\
%	\textsc{a dissertation presented \\ by\\
%	\theauthor\\ to\\ The Department of \@department\\
%	\vspace{12pt}
%	in partial fulfillment of the requirements\\
%	for the degree of\\ \@degree\\
%	in the subject of\\ \@field\\
%	\vspace{12pt}
%	\@university\\ \@universitycity, \@universitystate\\
%	\@degreemonth\ \@degreeyear}
	\end{center} %\vspace*{\fill}
}

\newcommand{\copyrightpage}{
	\newpage
	\thispagestyle{empty}
	\vspace*{\fill}
	\scshape \noindent \small \copyright \small 2024\hspace{3pt}-- \theauthor \\
	\noindent all rights reserved.
	\vspace*{\fill}
	\newpage
	\rm
}

\newcommand{\abstractpage}{
    \pdfbookmark{Abstract}{Abstract}
	\newpage
	\pagenumbering{roman}
	\setcounter{page}{1}
	\pagestyle{fancy}
	%\lhead{Dissertation Advisor: Associated Prof.\@advisor}%\rhead{\@author}
	\renewcommand{\headrulewidth}{0.0pt}
	%\vspace*{35pt}
	\begin{center}
    	\Large \textcolor{SchoolColor}{\@title}  \\
            \normalsize
    	\vspace*{20pt}
    	\scshape Abstract \\ \rm
	\end{center}
    \begin{spacing}{\dnormalspacing}
    	\input{frontmatter/abstract}
    \end{spacing}
	\vspace*{\fill}
	\newpage \lhead{} \rhead{}
	\cfoot{\thepage}
}

\newcommand{\contentspage}{
    \pdfbookmark{\contentsname}{Contents}
    \tableofcontents

}

\newcommand{\dedicationpage}{
    \cleardoublepage
    \phantomsection
    \pdfbookmark{Dedication}{Dedication}
	\newpage \thispagestyle{fancy} \vspace*{\fill}
	\scshape \noindent \input{frontmatter/dedication}
	\vspace*{\fill} \newpage \rm
    \cleardoublepage
}

\newcommand{\declaration}{
	\chapter*{Declaration}
	\noindent
    \begin{spacing}{\dnormalspacing}
    	\input{frontmatter/authorlist}
    \end{spacing}
	\vspace*{\fill} \newpage
}

\newcommand{\blankpage}{
	\chapter*{}
	\noindent
        \input{frontmatter/blankpage}
	\vspace*{\fill} \newpage
}

\newcommand{\acknowledgments}{
	\chapter*{Acknowledgments}
	\noindent
    \begin{spacing}{\dnormalspacing}
    	\input{frontmatter/thanks}
    \end{spacing}
	\vspace*{\fill} \newpage
}


\renewcommand{\backmatter}{
    \begin{appendices}
        \include{chapters/appendixA}
    \end{appendices}
    \input{endmatter/personalize}
    \clearpage
    \begin{spacing}{\dcompressedspacing}
        \bibliography{references}
        \addcontentsline{toc}{chapter}{References}
        \bibliographystyle{apacite} % author-year
        %\bibliographystyle{unsrtnat} % number
        \include{endmatter/colophon}
    \end{spacing}
}
