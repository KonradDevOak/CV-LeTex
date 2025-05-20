\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}				     % Version of LaTeX package 
\ProvidesClass{cvClass}[2016/06/03]	 % My custom CV class

\pdfminorversion=5
\pdfcompresslevel=9
\pdfobjcompresslevel=2

\pagestyle{empty}
\usepackage[nomessages]{fp}% http://ctan.org/pkg/fp
\usepackage{graphicx}
\usepackage{calc}
\usepackage[dvipsnames]{xcolor}
\usepackage{polski}
\usepackage{ragged2e}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{enumitem}
% \usepackage[showframe]{geometry}
\usepackage{geometry}
% \usepackage{fontawesome}
\usepackage{fontawesome5}
\usepackage{hyperref} %https://www.utf8-chartable.de/unicode-utf8-table.pl
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  filecolor=red,
  urlcolor=black
}
\urlstyle{same}

\geometry {
  a4paper,
  left=13mm,
  top=17mm,
  right=13mm,
  bottom=17mm
}

% Properties
\newcommand{\name}[1]{\textcolor{red}{#1}}
\newcommand{\surname}[1]{#1}
\newcommand{\dateOfBirth}[1]{#1}
\newcommand{\address}[1]{#1}
\newcommand{\phoneNumber}[1]{\Large{\bf{Phone number:}} #1}
\newcommand{\emailAddress}[1]{\Large{\bf{Email:}} #1}
\newcommand{\linkedin}[2]{\Large{\bf{Linkedin:}} \href{#1}{#2}}
\newcommand{\github}[2]{\Huge\faGithub/\large\href{#1}{#2}}
\newcommand{\dataTime}[1]{#1}
\newcommand{\from}[1]{#1}
\newcommand*{\onto}[1]{#1}


\newcommand{\rgb}[1]{\textcolor{red}{#1}}


\setlength{\fboxsep}{0pt}
\setlength{\fboxrule}{2pt}
\RequirePackage{titlesec}

\newcommand{\rgbClass}[1]{\textcolor{red}{#1}}

\titleformat{\section}				       % Customise the \section command 
  {\huge\scshape\raggedright}	       % Make the \section headers large (\Large),
  										               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      	     % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           	     % Can be used to insert code before the heading
  %[\titlerule]                      % Inserts a horizontal line after the heading


\titleformat{\subsection}
  {\large\scshape\raggedright}
  {}{0em}
  {}

\newcommand{\personalData}[6]{
  \begin{itemize}[leftmargin=*]\setlength\itemsep{-0.8mm}
    \item[] \Huge{\textsc{#1 #2}}\hfill #3
    \item[] #4
    \item[] #5
    \item[] #6
  \end{itemize}\vspace{3mm}
}

\newcommand{\newsection}[2]{
  \hspace{-2mm}
  \begin{minipage}{0.14\textwidth}
    \centering
    \noindent\color{#1}\rule{\textwidth}{4pt}
  \end{minipage}
  \begin{minipage}{0.01\textwidth}
    ~
  \end{minipage}
  \begin{minipage}{0.80\textwidth}
    \vspace{0.4cm}\section{#2}
    \vspace{-0.1cm}
  \end{minipage}
}

\newcommand{\text}[1]{
  \newline
  \begin{minipage}[t]{0.05\textwidth}
    ~
  \end{minipage}
  \begin{minipage}[t]{0.94\textwidth}
    \large\bf #1
  \end{minipage}
  \vspace{5mm}
}

\newcommand{\education}[4] {
  \begin{itemize}[leftmargin=0cm]\setlength\itemsep{-0.08cm}
    \item[] {\large University name: \bf #1}
    \item[] {\large Faculty: #2}
    \item[] {\large Field: #3}
    \item[] {\large Degree: #4}
  \end{itemize}
  \vspace{0.1mm}
}

\newcommand{\interval}[2] {
  \begin{itemize}[leftmargin=1cm]\setlength\itemsep{-0.08cm}
    \item[] {\bf\large #1}
    \item[] \hspace{7mm}{\bf -}
    \item[] {\bf\large #2}
  \end{itemize}
}

\newcommand{\intervalSection}[2]{
  \newline
  \begin{minipage}[t]{0.165\textwidth}
    #1
  \end{minipage}
  \begin{minipage}[t]{0.01\textwidth}
    ~
  \end{minipage}
  \begin{minipage}[t]{0.80\textwidth}
    #2
  \end{minipage}
}

\newcommand{\partOfTripleSubsections}[2] {
  \large {\bf #1}
  \large #2
}

\newcommand{\twoColumns}[2] {
  \begin{minipage}[t]{0.05\textwidth}
    ~
  \end{minipage}
  \begin{minipage}[t]{0.5\textwidth}
    #1
  \end{minipage}
  \begin{minipage}[t]{0.5\textwidth}
    #2
  \end{minipage}
}

\newcommand{\tripleSubsections}[3] {
  \begin{minipage}[t]{0.05\textwidth}
    ~
  \end{minipage}
  \begin{minipage}[t]{0.30\textwidth}
    #1
  \end{minipage}
  \begin{minipage}[t]{0.32\textwidth}
    #2
  \end{minipage}
  \begin{minipage}[t]{0.31\textwidth}
    #3
  \end{minipage}
}

\newcommand{\sectionItems}[1]{
  \begin{itemize}[leftmargin=1.4cm]\setlength\itemsep{0cm}
    #1
  \end{itemize}
}

\newcommand{\experienceItems}[1]{
  \begin{itemize}\setlength\itemsep{0cm}
    #1
  \end{itemize}
}

\newcommand{\subsectionItems}[1]{
  \begin{itemize}\setlength\itemsep{0cm}
    #1
  \end{itemize}
}

\newcommand{\companyInfo}[2]{
  {\bf #1}\\
  {\underline{#2}}
}

\newcommand{\experience}[5]{
  \begin{itemize}[leftmargin=0cm]\setlength\itemsep{-0.8mm}
    \item[] {{\bf #1}{\hfill \small#2}}
    \item[] {\underline{#3}}
    \item[] #4
  \end{itemize}\vspace{-5.8mm}
  #5
  \vspace{0.01cm}
}

\newcommand{\newsectionandreferences}[3]{
  \vspace{-0.3cm}
  \begin{minipage}{0.14\textwidth}
    \centering
    {\noindent\color{#1}\rule{\textwidth}{4pt}}\\
    ~
  \end{minipage}
  \begin{minipage}{0.01\textwidth}
    ~
  \end{minipage}
  \begin{minipage}{0.72\textwidth}
    \vspace{0.4cm}\section{#2}
    \large
    {\bf #3}
    \vspace{-0.1cm}
  \end{minipage}
}

\newcommand{\declaration}[2]{
  \begin{minipage}[t]{0.02\textwidth}
    ~
  \end{minipage}
  \begin{minipage}[t]{0.935\textwidth}
    \color{#1}{\footnotesize{#2}}
  \end{minipage}
}

\newcommand{\sectionProgressBars}[1]{
  \begin{itemize}[leftmargin=1.0cm, label={}]\setlength\itemsep{-0mm}
    #1
  \end{itemize}
}

\newlength{\barwidth}
\setlength{\barwidth}{0.57\textwidth}

\newcommand{\progressbar}[2]{
  \begin{minipage}[c]{0.35\textwidth}
    \large #1
  \end{minipage}
  \begin{minipage}[c]{0.65\textwidth}
    \noindent\colorbox{gray!30}{%
    \begin{minipage}[c]{\barwidth}
      \colorbox{gray!30}{\rule{0pt}{4mm}}%
      \colorbox{red!70}{\rule{0pt}{4mm}\hspace{#2\barwidth}}%
      \FPeval{\result}{clip(#2*100)}%
      \textcolor{black}{\hspace{1mm}$\result$\%}
      \end{minipage}%
    }
  \end{minipage}
}
