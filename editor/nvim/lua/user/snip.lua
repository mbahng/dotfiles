local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load({
  exclude = { "markdown-preview.nvim" }
})

ls.setup({
  -- Enable history to prevent some deletion warnings
  history = true,
  
  -- Make the region checks less frequent to reduce warnings
  region_check_events = "InsertEnter",
  
  -- Only check for deletion on InsertLeave rather than any text change
  delete_check_events = "InsertLeave",
  
  -- Add this to ignore VSCode snippet warnings from packages without snippets
  ext_opts = {
    store_selection_keys = nil, -- Recommended for less noise
  },
  
  -- Add this to suppress some verbose logging
  loaders_store_source = false
})

-- Rest of your configuration
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- jsdoc
ls.add_snippets(
  "javascriptreact",
  {
    s({trig="doc", regTrig=false, snippetType="snippet"},
      fmta(
        [[
        /**
        * <> 
        */
        ]],
        { i(1) }
      )
    ),
  }
)

ls.add_snippets(
  "javascript",
  {
    s({trig="doc", regTrig=false, snippetType="snippet"},
      fmta(
        [[
        /**
        * <> 
        */
        ]],
        { i(1) }
      )
    ),
  }
)

-- initialize setup for python package development
ls.add_snippets(
  "toml",
  {
    s({trig="pyproject", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        [project]
        name = ""
        dynamic = [""]
        description = ""

        requires-python = ">= 3.8"
        dependencies = [
          "numpy"
        ]

        authors = [
          {name = "Muchang Bahng", email = "bahngmc@gmail.com"},
        ]
        maintainers = [
          {name = "Muchang Bahng", email = "bahngmc@gmail.com"}
        ]

        [build-system]
        requires = ["setuptools>=70.0"]
        build-backend = "setuptools.build_meta"

        [project.scripts]
        # python cli commands that allow you to run stuff straight from command line
        # greet = "converters.convert:greet"

        [project.gui-scripts]

        [project.optional-dependencies]
        gui = []
        cli = []
        ]],
        {}, 
        { delimiters = "()" }
      )
    )
  }
)

ls.add_snippets(
  "python",
  {
    s({trig="setup", regTrig=false, snippetType="snippet"},
      fmta(
        [[
        from setuptools import setup

        setup(
           name='',
           description='',
           author='Muchang Bahng',
           author_email='bahngmc@gmail.com',
           packages=[''],  
           install_requires=[], #external packages as dependencies
        )
        ]],
        {}
      )
    ),
  }
)

ls.add_snippets(
  "python",
  {
    s({trig="ig", regTrig=false, snippetType="snippet"},
      fmta(
        [[# type: ignore]],
        {}
      )
    ),
  }
)

-- initialize HTML 
ls.add_snippets(
  "html",
  {
    s({trig="init", regTrig=false, snippetType="snippet"},
      fmta(
        [[
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <title>HTML 5 Boilerplate</title>
            <link rel="stylesheet" href="style.css">
          </head>
          <body>
          <script src="index.js"></script>
          </body>
        </html>
        ]],
        {}, 
        { delimiters = "()" }
      )
    ),
  }
)

-- initialize C 
ls.add_snippets(
  "c",
  {
    s({trig="init", regTrig=false, snippetType="snippet"},
      fmta(
        [[
          #include<stdio.h>

          int main(void) {
            
            return 0; 
          }
        ]],
        {}, 
        { delimiters = "xz" }
      )
    ),

  }
)

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

ls.add_snippets(
  "markdown",
  {
    s({trig="rm", regTrig=false, snippetType="snippet"},
      fmta(
        "\\mathrm{<>}",
        { i(1) }
      )
    ), 

    s({trig="lit", regTrig=false, snippetType="snippet"},
      fmta(
        [[
          Background. 

          Contribution

          Model Inference. 

          Training. 

          Results. 
        ]],
        {}, 
        { delimiters = "()" }
      )
    ),

  }
)

-- normal math stuff 
ls.add_snippets("tex",
  {
    s({trig="ti", regTrig=false, snippetType="snippet"},
      fmta(
        "\\textit{<>}",
        { i(1) }
      )
    ),

    s({trig="rm", regTrig=false, snippetType="snippet"},
      fmta(
        "\\mathrm{<>}",
        { i(1) }
      )
    ),

    s({trig="tb", regTrig=false, snippetType="snippet"},
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

    s({trig="mc", regTrig=false, snippetType="snippet"},
      fmta(
        "\\mathcal{<>}",
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
    s({trig="\\tikzpicture", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        \begin{tikzpicture}

        \end{tikzpicture}
        ]],
        {}
      )
    ),

    s({trig="\\table", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        \begin{table}[H]
          \centering
          \begin{tabular}{|c|c|}
            \hline
            \textbf{Column 1} & \textbf{Column 2} \\
            \hline
            Data 1 & Data 2 \\
            \hline
          \end{tabular}
          \caption{}
          \label{tab:}
        \end{table}
        ]],
        {}
      )
    ),

    s({trig="\\table2", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        \begin{table}[H]
          \centering
          \begin{minipage}{.5\textwidth}
            \centering
            \begin{tabular}{|c|c|}
              \hline
              \textbf{first} & \textbf{second} \\
              \hline
              1 & 2 \\
              \hline
            \end{tabular}
            \caption{}
            \label{tab:}
          \end{minipage}
          \begin{minipage}{.5\textwidth}
            \centering
            \begin{tabular}{|c|c|}
              \hline
              \textbf{first} & \textbf{second} \\
              \hline
              1 & 2 \\ 
              \hline
            \end{tabular}
            \caption{}
            \label{tab:}
          \end{minipage}
        \end{table}
        ]],
        {}
      )
    ),

    s({trig="\\figure", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
          \begin{figure}[H]
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
        \begin{figure}[H]
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
        \begin{figure}[H]
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
        \begin{figure}[H]
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
        \begin{figure}[H]
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
    s({trig="\\code2", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \noindent\begin{minipage}{.5\textwidth}
          \begin{lstlisting}[]{Code}
            <>
          \end{lstlisting}
          \end{minipage}
          \hfill
          \begin{minipage}{.49\textwidth}
          \begin{lstlisting}[]{Output}
            <>
          \end{lstlisting}
        \end{minipage}
      ]],
      { i(1), i(2) }
      )
    ),

    s({trig="\\code1", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{lstlisting}
          <>
        \end{lstlisting}
      ]],
      { i(1) }
      )
    ),

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

    s({trig="\\axiom", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{axiom}
          <>
        \end{axiom}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\cd", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{tikzcd}
          <>
        \end{tikzcd}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\center", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{center}
          <>
        \end{center}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\algorithm", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{algorithm}
        \caption{Algorithm Name}
        \label{alg:<>}
        \begin{algorithmic}[1]  % The [1] adds line numbers
          % Procedure declaration
          \Procedure{ProcedureName}{parameter1, parameter2}
              
          % Input/Output documentation
          \Require{Input requirements or preconditions}
          \Ensure{Output guarantees or postconditions}
          
          % Variable initialization
          \State $variable1 \gets initialValue$
          \State $variable2 \gets 0$
          
          % Control structures
          \If{condition}
              \State statement1
              \State statement2
          \ElsIf{condition2}
              \State statement3
          \Else
              \State statement4
          \EndIf
          
          % Loops
          \For{$i \gets 1$ to $n$}
              \State perform operation
          \EndFor
          
          \While{condition}
              \State perform operation
          \EndWhile
          
          % Function calls
          \State $result \gets \Call{SubProcedure}{arg1, arg2}$
          
          % Return statement
          \State \Return $result$
          \EndProcedure

          % Sub-procedure definition
          \Procedure{SubProcedure}{arg1, arg2}
              \State perform operations
              \State \Return $value$
          \EndProcedure
        \end{algorithmic}
        \end{algorithm}
      ]],
      { i(1) }
      )
    ),

    s({trig="\\algo", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{algo}
          <>
        \end{algo}
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

    s({trig="\\exercise", regTrig=false, snippetType="snippet"},
      fmta(
      [[
        \begin{exercise}
          <>
        \end{exercise}
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

  % packages
    % basic stuff for rendering math
    \usepackage[letterpaper, top=1in, bottom=1in, left=1in, right=1in]{geometry}
    \usepackage[utf8]{inputenc}
    \usepackage[english]{babel}
    \usepackage{amsmath} 
    \usepackage{amssymb}

    % extra math symbols and utilities
    \usepackage{mathtools}        % for extra stuff like \coloneqq
    \usepackage{mathrsfs}         % for extra stuff like \mathsrc{}
    \usepackage{centernot}        % for the centernot arrow 
    \usepackage{bm}               % for better boldsymbol/mathbf 
    \usepackage{enumitem}         % better control over enumerate, itemize
    \usepackage{hyperref}         % for hypertext linking
    \usepackage{xr-hyper}
    \usepackage{fancyvrb}          % for better verbatim environments
    \usepackage{newverbs}         % for texttt{}
    \usepackage{xcolor}           % for colored text 
    \usepackage{listings}         % to include code
    \usepackage{lstautogobble}    % helper package for code
    \usepackage{parcolumns}       % for side by side columns for two column code
    

    % page layout
    \usepackage{fancyhdr}         % for headers and footers 
    \usepackage{lastpage}         % to include last page number in footer 
    \usepackage{parskip}          % for no indentation and space between paragraphs    
    \usepackage[T1]{fontenc}      % to include \textbackslash
    \usepackage{footnote}
    \usepackage{etoolbox}

    % for custom environments
    \usepackage{tcolorbox}        % for better colored boxes in custom environments
    \tcbuselibrary{breakable}     % to allow tcolorboxes to break across pages

    % figures
    \usepackage{pgfplots}
    \pgfplotsset{compat=1.18}
    \usepackage{float}            % for [H] figure placement
    \usepackage{tikz}
    \usepackage{tikz-cd}
    \usepackage{circuitikz}
    \usetikzlibrary{arrows}
    \usetikzlibrary{positioning}
    \usetikzlibrary{calc}
    \usepackage{graphicx}
    \usepackage{algorithmic}
    \usepackage{caption} 
    \usepackage{subcaption}
    \captionsetup{font=small}

    % for tabular stuff 
    \usepackage{dcolumn}

    \usepackage[nottoc]{tocbibind}
    \pdfsuppresswarningpagegroup=1
    \hfuzz=5.002pt                % ignore overfull hbox badness warnings below this limit

  % New and replaced operators
    \DeclareMathOperator{\Tr}{Tr}
    \DeclareMathOperator{\Sym}{Sym}
    \DeclareMathOperator{\Span}{span}
    \DeclareMathOperator{\std}{std}
    \DeclareMathOperator{\Cov}{Cov}
    \DeclareMathOperator{\Var}{Var}
    \DeclareMathOperator{\Corr}{Corr}
    \DeclareMathOperator{\pos}{pos}
    \DeclareMathOperator*{\argmin}{\arg\!\min}
    \DeclareMathOperator*{\argmax}{\arg\!\max}
    \newcommand{\ket}[1]{\ensuremath{\left|#1\right\rangle}}
    \newcommand{\bra}[1]{\ensuremath{\left\langle#1\right|}}
    \newcommand{\braket}[2]{\langle #1 | #2 \rangle}
    \newcommand{\qed}{\hfill$\blacksquare$}     % I like QED squares to be black

  % Custom Environments
    \newtcolorbox[auto counter, number within=section]{question}[1][]
    {
      colframe = orange!25,
      colback  = orange!10,
      coltitle = orange!20!black,  
      breakable, 
      title = \textbf{Question \thetcbcounter ~(#1)}
    }

    \newtcolorbox[auto counter, number within=section]{exercise}[1][]
    {
      colframe = teal!25,
      colback  = teal!10,
      coltitle = teal!20!black,  
      breakable, 
      title = \textbf{Exercise \thetcbcounter ~(#1)}
    }
    \newtcolorbox[auto counter, number within=section]{solution}[1][]
    {
      colframe = violet!25,
      colback  = violet!10,
      coltitle = violet!20!black,  
      breakable, 
      title = \textbf{Solution \thetcbcounter}
    }
    \newtcolorbox[auto counter, number within=section]{lemma}[1][]
    {
      colframe = red!25,
      colback  = red!10,
      coltitle = red!20!black,  
      breakable, 
      title = \textbf{Lemma \thetcbcounter ~(#1)}
    }
    \newtcolorbox[auto counter, number within=section]{theorem}[1][]
    {
      colframe = red!25,
      colback  = red!10,
      coltitle = red!20!black,  
      breakable, 
      title = \textbf{Theorem \thetcbcounter ~(#1)}
    } 
    \newtcolorbox[auto counter, number within=section]{proposition}[1][]
    {
      colframe = red!25,
      colback  = red!10,
      coltitle = red!20!black,  
      breakable, 
      title = \textbf{Proposition \thetcbcounter ~(#1)}
    } 
    \newtcolorbox[auto counter, number within=section]{corollary}[1][]
    {
      colframe = red!25,
      colback  = red!10,
      coltitle = red!20!black,  
      breakable, 
      title = \textbf{Corollary \thetcbcounter ~(#1)}
    } 
    \newtcolorbox[auto counter, number within=section]{proof}[1][]
    {
      colframe = orange!25,
      colback  = orange!10,
      coltitle = orange!20!black,  
      breakable, 
      title = \textbf{Proof. }
    } 
    \newtcolorbox[auto counter, number within=section]{definition}[1][]
    {
      colframe = yellow!25,
      colback  = yellow!10,
      coltitle = yellow!20!black,  
      breakable, 
      title = \textbf{Definition \thetcbcounter ~(#1)}
    } 
    \newtcolorbox[auto counter, number within=section]{example}[1][]
    {
      colframe = blue!25,
      colback  = blue!10,
      coltitle = blue!20!black,  
      breakable, 
      title = \textbf{Example \thetcbcounter ~(#1)}
    } 
    \newtcolorbox[auto counter, number within=section]{code}[1][]
    {
      colframe = green!25,
      colback  = green!10,
      coltitle = green!20!black,  
      breakable, 
      title = \textbf{Code \thetcbcounter ~(#1)}
    } 
    \newtcolorbox[auto counter, number within=section]{algo}[1][]
    {
      colframe = green!25,
      colback  = green!10,
      coltitle = green!20!black,  
      breakable, 
      title = \textbf{Algorithm \thetcbcounter ~(#1)}
    } 

    \definecolor{dkgreen}{rgb}{0,0.6,0}
    \definecolor{gray}{rgb}{0.5,0.5,0.5}
    \definecolor{mauve}{rgb}{0.58,0,0.82}
    \definecolor{darkblue}{rgb}{0,0,139}
    \definecolor{lightgray}{gray}{0.93}
    \renewcommand{\algorithmiccomment}[1]{\hfill$\triangleright$\textcolor{blue}{#1}}

    % default options for listings (for code)
    \lstset{
      autogobble,
      frame=ltbr,
      language=Python,
      aboveskip=3mm,
      belowskip=3mm,
      showstringspaces=false,
      columns=fullflexible,
      keepspaces=true,
      basicstyle={\small\ttfamily},
      numbers=left,
      firstnumber=1,                        % start line number at 1
      numberstyle=\tiny\color{gray},
      keywordstyle=\color{blue},
      commentstyle=\color{dkgreen},
      stringstyle=\color{mauve},
      backgroundcolor=\color{lightgray}, 
      breaklines=true,                      % break lines
      breakatwhitespace=true,
      tabsize=3, 
      xleftmargin=2em, 
      framexleftmargin=1.5em, 
      stepnumber=1
    }

  % Page style
    \pagestyle{fancy}
    \fancyhead[L]{}
    \fancyhead[C]{Muchang Bahng}
    \fancyhead[R]{Spring 2025} 
    \fancyfoot[C]{\thepage / \pageref{LastPage}}
    \renewcommand{\footrulewidth}{0.4pt}          % the footer line should be 0.4pt wide
    \renewcommand{\thispagestyle}[1]{}  % needed to include headers in title page

  % external documents 
  %  \externaldocument[place-]{../Machine_Learning/paper}[../Machine_Learning/paper.pdf] 

\begin{document}

\title{}
\author{Muchang Bahng}
\date{Spring 2025}

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




