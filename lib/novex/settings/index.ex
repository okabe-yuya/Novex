defmodule Novex.Settings do
  def load_settings do
    %{
      :punctuation => ["、", "。", ",", "."],
      :rest_time => 80,
      :end_string => "↩︎",
    }
  end
end
