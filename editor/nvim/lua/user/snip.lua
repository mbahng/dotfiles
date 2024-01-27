local ls = require("luasnip")

ls.setup({
  history = true,
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
})

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- accepts two arguments: filetype and the snippets

-- python
--
ls.add_snippets(
  "python",
  {
    s(
      {
        trig="torch-imports",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({
          "import torch",
          "import torch.nn as nn",
          "import os",
          "from torchvision import datasets",
          "import torchvision.transforms as transforms",
          "from torch.utils.data import DataLoader"
        }), 
      }
    ), 

    s(
      {
        trig="torch-device", 
        regTrig=false, 
        snippetType="snippet", 
      },
      {
        t({
          'device = (',
          '\t"cuda"',
          '\tif torch.cuda.is_available()',
          '\telse "cpu"',
          ')'
        }), 
      }
    ), 


    s(
      {
        trig="torch-data-CIFAR10",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({
          'root = os.path.join("./data")',
          '',
          'transform = transforms.Compose(',
          '\t[transforms.ToTensor(),',
          '\ttransforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])',
          '',
          'training_data = datasets.CIFAR10(',
          '\troot=root,',
          '\ttrain=True,',
          '\tdownload=True,',
          '\ttransform=transform',
          '\t)',
          'test_data = datasets.CIFAR10(',
          '\troot=root,',
          '\ttrain=False,',
          '\tdownload=True,',
          '\ttransform=transform',
          ')',
          '',
          'train_dataloader = DataLoader(training_data, batch_size=64, shuffle=True)',
          'test_dataloader = DataLoader(test_data, batch_size=64, shuffle=True)'
        }),
      }
    ),

  }
)

ls.add_snippets(
  "tex",
  {
    s(
      {
        trig="ti",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t("\\textit{"),
        i(1),
        t("}")
      }
    ),

    s(
      {
        trig="tb",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t("\\textbf{"),
        i(1),
        t("}")
      }
    ),


    s(
      {
        trig="tt",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t("\\texttt{"),
        i(1),
        t("}")
      }
    ),

    s(
      {
        trig="mb", 
        regTrig=false,
        snippetType="snippet",
      },
      {
        t("\\mathbf{"),
        i(1),
        t("}")
      }
    ),

    s(
      {
        trig="bs",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t("\\boldsymbol{"),
        i(1),
        t("}")
      }
    ),

    s(
      {
        trig="bb",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t("\\mathbb{"),
        i(1),
        t("}")
      }
    ),

    s(
      {
        trig="\\enumerate",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{enumerate}", "\t\\item "}),
        i(1),
        t({"", "\\end{enumerate}"})
      }
    ), 

    s(
      {
        trig="\\equation",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{equation}", "\t"}),
        i(1),
        t({"", "\\end{equation}"})
      }
    ), 

    s(
      {
        trig="\\align",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{align*}", "\t"}),
        i(1),
        t({"", "\\end{align*}"})
      }
    ), 


    s(
      {
        trig="\\equation",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{equation}", "\t"}),
        i(1),
        t({"", "\\end{equation}"})
      }
    ), 


    s(
      {
        trig="\\definition",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{definition}", "\t"}),
        i(1),
        t({"", "\\end{definition}"})
      }
    ), 


    s(
      {
        trig="\\theorem",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{theorem}", "\t"}),
        i(1),
        t({"", "\\end{theorem}"})
      }
    ),


    s(
      {
        trig="\\lemma",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{lemma}", "\t"}),
        i(1),
        t({"", "\\end{lemma}"})
      }
    ),

    s(
      {
        trig="\\answer",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{answer}", "\t"}),
        i(1),
        t({"", "\\end{answer}"})
      }
    ), 

    s(
      {
        trig="\\example",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{example}", "\t"}),
        i(1),
        t({"", "\\end{example}"})
      }
    ),

    s(
      {
        trig="\\question",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{question}", "\t"}),
        i(1),
        t({"", "\\end{question}"})
      }
    ),

    s(
      {
        trig="\\corollary",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{corollary}", "\t"}),
        i(1),
        t({"", "\\end{corollary}"})
      }
    ), 

    s(
      {
        trig="\\proof",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{proof}", "\t"}),
        i(1),
        t({"", "\\end{proof}"})
      }
    ),

    s(
      {
        trig="\\proposition",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{proposition}", "\t"}),
        i(1),
        t({"", "\\end{proposition}"})
      }
    ), 

    s(
      {
        trig="\\solution",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{solution}", "\t"}),
        i(1),
        t({"", "\\end{solution}"})
      }
    ),

    s(
      {
        trig="\\pmatrix",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{pmatrix}", "\t"}),
        i(1),
        t({"", "\\end{pmatrix}"})
      }
    ),

    s(
      {
        trig="\\bmatrix",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{bmatrix}", "\t"}),
        i(1),
        t({"", "\\end{bmatrix}"})
      }
    ),

    s(
      {
        trig="\\verbatim",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{verbatim}", "\t"}),
        i(1),
        t({"", "\\end{verbatim}"})
      }
    ),

    s(
      {
        trig="\\cverbatim",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({"\\begin{cverbatim}", "\t"}),
        i(1),
        t({"", "\\end{cverbatim}"})
      }
    ),


    s(
      {
        trig="\\ff",
        regTrig=false, 
        snippetType="snippet",
      },
      {
        t("\\frac{"),
        i(1),
        t("}{"),
        i(2),
        t("}")
      }
    ),

    s(
      {
        trig="init",
        regTrig=false,
        snippetType="snippet",
      },
      {
        t({
          "\\documentclass{article}",
          "",
          "\t% preamble",
          "\t\\usepackage[letterpaper, top=1in, bottom=1in, left=1in, right=1in]{geometry}",
          "\t\\usepackage[utf8]{inputenc}",
          "\t\\usepackage[english]{babel}",
          "\t\\usepackage{amsmath, amssymb, amsthm, mathtools} % necessary",
          "\t\\usepackage{lastpage} % insert last page number",
          "\t\\usepackage{centernot} % for not slash",
          "",
          "\t\\usepackage{pgfplots}",
          "\t\\pgfplotsset{compat=1.18}",
          "\t\\usepackage{hyperref} % hyperlinks",
          "\t\\usepackage{fancyhdr} % fancy headers",
          "\t\\usepackage{fancyvrb} % verbatim",
          "\t\\usepackage{parskip}",
          "",
          "\t\\usepackage{subcaption} % captions for figures",
          "\t\\definecolor{cverbbg}{gray}{0.93}",
          "",
          "\t\\setlength{\\parindent}{0pt} % set no indent",
          "\t\\hfuzz=5.002pt % ignore overfull hbox badness warnings below this limit",
          "",
          "\t\\DeclareMathOperator{\\Tr}{Tr}",
          "\t\\DeclareMathOperator{\\Sym}{Sym}",
          "\t\\DeclareMathOperator{\\Span}{span}",
          "\t\\DeclareMathOperator{\\std}{std}",
          "\t\\DeclareMathOperator{\\Cov}{Cov}",
          "\t\\DeclareMathOperator{\\Var}{Var}",
          "\t\\DeclareMathOperator{\\Corr}{Corr}",
          "\t\\DeclareMathOperator*{\\argmin}{\\arg\\!\\min}",
          "\t\\DeclareMathOperator*{\\argmax}{\\arg\\!\\max}",
          "\t\\newenvironment{question}{\\color{blue}}{\\ignorespacesafterend}",
          "",
          "\t\\newcommand{\\ket}[1]{\\ensuremath{\\left|#1\\right\\rangle}}",
          "\t\\newcommand{\\bra}[1]{\\ensuremath{\\left\\langle#1\\right|}}",
          "\t\\newcommand{\\bracket}[2]{\\langle #1 | #2 \\rangle}",
          "",
          "\t\\theoremstyle{definition}",
          "\t\\newtheorem{theorem}{Theorem}[section]",
          "\t\\newtheorem{proposition}[theorem]{Proposition}",
          "\t\\newtheorem{lemma}[theorem]{Lemma}",
          "\t\\newtheorem{example}{Example}[section]",
          "\t\\newtheorem{exercise}{Exercise}[section]",
          "\t\\newtheorem{corollary}{Corollary}[theorem]",
          "\t\\newtheorem{definition}{Definition}[section]",
          "\t\\renewcommand{\\qed}{\\hfill$\\blacksquare$}",
          "\t\\renewcommand{\\footrulewidth}{0.4pt}% default is 0pt",
          "",
          "\t\\newenvironment{solution}{\\noindent \\textit{Solution.}}{}",
          "\t\\newenvironment{cverbatim}",
          "\t\t{\\SaveVerbatim{cverb}}",
          "\t\t{\\endSaveVerbatim",
          "\t\t\\flushleft\\fboxrule=0pt\\fboxsep=.5em",
          "\t\t\\colorbox{cverbbg}{%",
          "\t\t\t\\makebox[\\dimexpr\\linewidth-2\\fboxsep][l]{\\BUseVerbatim{cverb}}%",
          "\t\t}",
          "\t\t\\endflushleft",
          "\t}",
          "",
          "\t\\renewcommand{\\thispagestyle}[1]{} % needed for including header in title page",
          "",
          "\\begin{document}",
          "\t\\pagestyle{fancy}",
          "",
          "\t\\lhead{}",
          "\t\\chead{Muchang Bahng}",
          "\t\\rhead{\\date{Spring 2024}}",
          "\t\\cfoot{\\thepage / \\pageref{LastPage}}",
          "",
          "\t\\title{}",
          "\t\\author{Muchang Bahng}",
          "\t\\date{Spring 2024}",
          "",
          "\t\\maketitle",
          "\t\\tableofcontents",
          "\t\\pagebreak",
          "", "", ""}),
          i(1),
          t({"", "", "\\end{document}"})
      }
    ),

  }
)




