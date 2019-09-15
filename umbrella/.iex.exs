# Will be using `ANSI`
Application.put_env(:elixir, :ansi_enabled, true)

prefix = IO.ANSI.light_black_background() <> IO.ANSI.green() <> "%prefix" <> IO.ANSI.reset()
counter = IO.ANSI.light_black_background() <> IO.ANSI.green() <> " %node (%counter)" <> IO.ANSI.reset()
last = IO.ANSI.yellow() <> ">" <> IO.ANSI.reset()
alive = IO.ANSI.bright() <> IO.ANSI.yellow() <> IO.ANSI.blink_rapid() <> "⚡" <> IO.ANSI.reset()

default_prompt = prefix <> counter <> " :: " <> last
alive_prompt = prefix <> counter <> " :: " <> alive <> last

inspect_limit = 5_000
history_size = 1_000

eval_result = [:green, :bright]
eval_error = [:red, :bright]
eval_info = [:blue, :bright]

# Configuring IEx
IEx.configure [
  inspect: [limit: inspect_limit],
  history_size: history_size,
  colors: [
    eval_result: eval_result,
    eval_error: eval_error,
    eval_info: eval_info,
  ],
  default_prompt: default_prompt,
  alive_prompt: alive_prompt
]

import Ecto.Query
import Ecto.Changeset

import Sunulator.IExUtils
alias Sunulator.Repo
