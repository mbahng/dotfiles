local ls = require("luasnip")

ls.setup({
  history = true,
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged,InsertLeave",
})

local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


-- PyTorch
ls.add_snippets(
  "python",
  {
    s({trig="torch-imports", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
          import torch
          import torch.nn as nn 
          import os 
          from torchvision import datasets 
          import torchvision.transforms as transforms 
          from torch.utils.data import DataLoader
        ]],
        {}
      )
    ),

    s({trig="torch-device", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
          device = (
          "cuda" if torch.cuda.is_available(), 
          else "cpu"
          )
        ]],
        {}
      )
    ),

    s({trig="torch-data-CIFAR10", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
          root = os.path.join('./data')

          transform = transforms.Compose(
              [transforms.ToTensor(),
               transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])

          training_data = datasets.CIFAR10(
              root=root,            
              train=True,            
              download=True,          
              transform=transform    
          )
          test_data = datasets.CIFAR10(
              root=root,
              train=False,
              download=True,
              transform=transform 
          )

          train_dataloader = DataLoader(training_data,    # our dataset
                                        batch_size=64,    # batch size
                                        shuffle=True      # shuffling the data
                                      )
          test_dataloader = DataLoader(test_data, batch_size=64, shuffle=True)
        ]],
        {}
      )
    ),

  }
)

-- normal math stuff 
ls.add_snippets("tex",
  {
    s({trig="ti", regTrig=false, snippetType="snippet"},
      fmta(
        "\\texit{<>}",
        { i(1) }
      )
    ),

    s({trig="ti", regTrig=false, snippetType="snippet"},
      fmta(
        "\\textbf{<>}",
        { i(1) }
      )
    ),

    s({trig="tt", regTrig=false, snippetType="snippet"},
      fmta(
        "\\texttt{<>}",
        { i(1) }
      )
    ),

    s({trig="mb", regTrig=false, snippetType="snippet"},
      fmta(
        "\\mathbf{<>}",
        { i(1) }
      )
    ),

    s({trig="bs", regTrig=false, snippetType="snippet"},
      fmta(
        "\\boldsymbol{<>}",
        { i(1) }
      )
    ),

    s({trig="bb", regTrig=false, snippetType="snippet"},
      fmta(
        "\\mathbb{<>}",
        { i(1) }
      )
    ),

    s({trig="\\ff", regTrig=false, snippetType="snippet"},
      fmta(
        "\\frac{<>}{<>}",
        { i(1), i(2) }
      )
    ),

  }
)

-- figures and subfigures
ls.add_snippets("tex",
  {
    s({trig="\\figure", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
          \begin{figure}[hbt!]
            \centering 
            \includegraphics[scale=0.4]{img/<>}
            \caption{<>} 
            \label{fig:<>}
          \end{figure}
        ]],
        { i(1), i(2), i(3)}
      )
    ),

    s({trig="\\subfigure12", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        \begin{figure}[hbt!]
          \centering
          \begin{subfigure}[b]{0.48\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.48\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
        { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8)}
      )
    ),

    s({trig="\\subfigure13", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        \begin{figure}[hbt!]
          \centering
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
        { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11)}
      )
    ),

    s({trig="\\subfigure22", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        \begin{figure}[hbt!]
          \centering
          \begin{subfigure}[b]{0.48\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.48\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}

          \begin{subfigure}[b]{0.48\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.48\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>.png}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
        { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11), i(12), i(13), i(14)}
      )
    ),

    s({trig="\\subfigure23", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{figure}[hbt!]
          \centering 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}

          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}
          \hfill 
          \begin{subfigure}[b]{0.32\textwidth}
          \centering
            \includegraphics[width=\textwidth]{img/<>}
            \caption{<>}
            \label{fig:<>}
          \end{subfigure}

          \caption{<>}
          \label{fig:<>}    
        \end{figure}
        ]],
        { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11), i(12), i(13), i(14), i(15), i(16), i(17), i(18), i(19), i(20)}
      )
    ),

  }
)

-- latex environments
ls.add_snippets("tex",
  {
    s({trig="\\enumerate", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{enumerate} 
          \item <>
        \end{enumerate}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\equation", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{equation} 
          <>
        \end{equation}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\align", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{align} 
          <>
        \end{align}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\definition", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{definition} 
          <>
        \end{definition}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\theorem", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{theorem} 
          <>
        \end{theorem}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\lemma", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{lemma} 
          <>
        \end{lemma}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\answer", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{answer} 
          <>
        \end{answer}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\example", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{example} 
          <>
        \end{example}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\question", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{question} 
          <>
        \end{question}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\corollary", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{corollary} 
          <>
        \end{corollary}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\proof", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{proof} 
          <>
        \end{proof}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\proposition", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{proposition} 
          <>
        \end{proposition}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\pmatrix", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{pmatrix} 
          <>
        \end{pmatrix}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\bmatrix", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{bmatrix} 
          <>
        \end{bmatrix}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\verbatim", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{verbatim} 
          <>
        \end{verbatim}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\cverbatim", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{cverbatim} 
          <>
        \end{cverbatim}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\solution", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{solution} 
          <>
        \end{solution}
      ]],
      { i(1) }
      )
    ),

  }
)

-- initialize latex  
ls.add_snippets("tex",
  {
    s({trig="init", regTrig=false, snippetType="snippet"},
      fmta(
      [[ 
        \documentclass{article}

          % preamble
          \usepackage[letterpaper, top=1in, bottom=1in, left=1in, right=1in]{geometry}
          \usepackage[utf8]{inputenc}
          \usepackage[english]{babel}
          \usepackage{amsmath, amssymb, amsthm, mathtools} % necessary
          \usepackage{lastpage} % insert last page number
          \usepackage{centernot} % for not slash

          \usepackage{pgfplots}
          \pgfplotsset{compat=1.18}
          \usepackage{hyperref} % hyperlinks
          \usepackage{fancyhdr} % fancy headers
          \usepackage{fancyvrb} % verbatim
          \usepackage{parskip}

          \usepackage{subcaption} % captions for figures
          \definecolor{cverbbg}{gray}{0.93}

          \setlength{\parindent}{0pt} % set no indent
          \hfuzz=5.002pt % ignore overfull hbox badness warnings below this limit

          \DeclareMathOperator{\Tr}{Tr}
          \DeclareMathOperator{\Sym}{Sym}
          \DeclareMathOperator{\Span}{span}
          \DeclareMathOperator{\std}{std}
          \DeclareMathOperator{\Cov}{Cov}
          \DeclareMathOperator{\Var}{Var}
          \DeclareMathOperator{\Corr}{Corr}
          \DeclareMathOperator*{\argmin}{\arg\!\min}
          \DeclareMathOperator*{\argmax}{\arg\!\max}
          \newenvironment{question}{\color{blue}}{\ignorespacesafterend}

          \newcommand{\ket}[1]{\ensuremath{\left|#1\right\rangle}}
          \newcommand{\bra}[1]{\ensuremath{\left\langle#1\right|}}
          \newcommand{\bracket}[2]{\langle #1 | #2 \rangle}

          \theoremstyle{definition}
          \newtheorem{theorem}{Theorem}[section]
          \newtheorem{proposition}[theorem]{Proposition}
          \newtheorem{lemma}[theorem]{Lemma}
          \newtheorem{example}{Example}[section]
          \newtheorem{exercise}{Exercise}[section]
          \newtheorem{corollary}{Corollary}[theorem]
          \newtheorem{definition}{Definition}[section]
          \renewcommand{\qed}{\hfill$\blacksquare$}
          \renewcommand{\footrulewidth}{0.4pt}% default is 0pt

          \newenvironment{solution}{\noindent \textit{Solution.}}{}
          \newenvironment{cverbatim}
            {\SaveVerbatim{cverb}}
            {\endSaveVerbatim
            \flushleft\fboxrule=0pt\fboxsep=.5em
            \colorbox{cverbbg}{%
              \makebox[\dimexpr\linewidth-2\fboxsep][l]{\BUseVerbatim{cverb}}%
            }
            \endflushleft
          }

          \renewcommand{\thispagestyle}[1]{} % needed for including header in title page

        \begin{document}
        \pagestyle{fancy}

        \lhead{}
        \chead{Muchang Bahng}
        \rhead{\date{Spring 2024}}
        \cfoot{\thepage / \pageref{LastPage}}

        \title{}
        \author{Muchang Bahng}
        \date{Spring 2024}

        \maketitle
        \tableofcontents
        \pagebreak

        <>

        \end{document}
      ]],
      { i(1) }
      )
    ),
  }
)




