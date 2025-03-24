local ls = require("luasnip")

ls.setup({
  history = false,
  region_check_events = "CursorMoved, InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
})

local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

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



